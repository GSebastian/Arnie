//
//  BreakTrackerViewModel.swift
//  Arnie Workout Tracker
//
//  Created by Sebastian Ghetu on 25/05/2020.
//  Copyright © 2020 Sebastian Ghetu. All rights reserved.
//

import Combine
import Foundation
import UserNotifications
import UIKit

class BreakTrackerViewModel: ObservableObject {
    
    static var defaultRestTime = 30
    static var defaultExtraTime = 10

    @Published var timeLabel = ""

    private var setFinished: (Int) -> Void
    private var setPlanGrouping: SetPlanGrouping
    private var timeCounter: Int {
        didSet {
            timeLabel = timeLabel(forSeconds: timeCounter > 0 ? timeCounter : 0)
        }
    }
    private var timeElapsed = 0
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    private var cancellable: AnyCancellable?
    private var timeFinishedNotificationID: String?
    private var dateWhenLastBackgrounded: Date?
    
    // MARK: - Initalisers
    
    init(setPlanGrouping: SetPlanGrouping, setFinished: @escaping (Int) -> Void) {
        self.setFinished = setFinished
        self.setPlanGrouping = setPlanGrouping
        self.timeCounter = Self.defaultRestTime
        self.timeLabel = timeLabel(forSeconds: Self.defaultRestTime)
    }
    
    // MARK: - Controls
    
    func addMore() {
        timeCounter += Self.defaultExtraTime
        updateNotification()
    }
    
    func nextSet() {
        cancelNotification()
        setFinished(timeElapsed)
    }
    
    // MARK: - Lifecycle
    
    func onAppear() {
        addBackgroundForegroundListeners()

        guard cancellable == nil else { return }

        requestPushPermissions()

        cancellable = timer.sink { [weak self] _ in
            guard let self = self else { return }
            guard self.timeCounter > 0 else {
                self.nextSet()
                return
            }
            self.timeCounter -= 1
            self.timeElapsed += 1
        }
    }
    
    func onDisappear() {
        removeBackgroundForegroundListeners()
        cancellable?.cancel()
    }
    
    // MARK: - Utils
    
    private func timeLabel(forSeconds seconds: Int) -> String {
        let localizedWithPlaceholders =
            NSLocalizedString("setPlan.timeSetPlan.primaryLabel", comment: "")
        return String(format: localizedWithPlaceholders, seconds)
    }

    // MARK: App in Background / Foreground

    private func addBackgroundForegroundListeners() {
        NotificationCenter
            .default
            .addObserver(
                self,
                selector: #selector(appBackgrounded),
                name: UIApplication.didEnterBackgroundNotification,
                object: nil)

        NotificationCenter
            .default
            .addObserver(
                self,
                selector: #selector(appWillForeground),
                name: UIApplication.willEnterForegroundNotification,
                object: nil)
    }

    private func removeBackgroundForegroundListeners() {
        NotificationCenter
            .default
            .removeObserver(
                self,
                name: UIApplication.didEnterBackgroundNotification,
                object: nil)
        NotificationCenter
            .default
            .removeObserver(
                self,
                name: UIApplication.willEnterForegroundNotification,
                object: nil)
    }

    @objc
    private func appBackgrounded() {
        dateWhenLastBackgrounded = Date()
    }

    @objc
    private func appWillForeground() {
        guard let secondsDifference = dateWhenLastBackgrounded?.timeIntervalSinceNow else {
            return
        }
        timeCounter -= abs(Int(secondsDifference))
        timeElapsed += abs(Int(secondsDifference))
        dateWhenLastBackgrounded = nil
    }

    // MARK: Push

    private func requestPushPermissions() {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound, .badge]) { [weak self] granted, error in
            // TODO: Add analytics when live
            guard granted else { return }
            self?.updateNotification()
        }
    }

    private func cancelNotification() {
        guard let timeFinishedNotificationID = timeFinishedNotificationID else { return }
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.removePendingNotificationRequests(withIdentifiers: [timeFinishedNotificationID])
        self.timeFinishedNotificationID = nil
    }

    private func updateNotification() {

        func notificationContent() -> UNNotificationContent {
            let content = UNMutableNotificationContent()
            content.title = NSLocalizedString("breakTracker.breakFinishedNotification.title", comment: "")
            content.body = NSLocalizedString("breakTracker.breakFinishedNotification.body", comment: "")
            content.sound = .default

            return content
        }

        func scheduleTimerFinishedPush() {


            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(timeCounter), repeats: false)

            // Create the request
            timeFinishedNotificationID = UUID().uuidString
            let request = UNNotificationRequest(identifier: timeFinishedNotificationID!,
                                                content: notificationContent(),
                                                trigger: trigger)

            // Schedule the request with the system.
            let notificationCenter = UNUserNotificationCenter.current()
            notificationCenter.add(request) { [weak self] (error) in
                if error != nil {
                    self?.timeFinishedNotificationID = nil
                }
            }
        }

        cancelNotification()
        scheduleTimerFinishedPush()
    }
}

extension BreakTrackerViewModel: Hashable {

    static func == (lhs: BreakTrackerViewModel, rhs: BreakTrackerViewModel) -> Bool {
        lhs.setPlanGrouping == rhs.setPlanGrouping
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(setPlanGrouping)
    }
}

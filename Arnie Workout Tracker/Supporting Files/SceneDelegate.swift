//
//  SceneDelegate.swift
//  Arnie Workout Tracker
//
//  Created by Sebastian Ghetu on 13/04/2020.
//  Copyright © 2020 Sebastian Ghetu. All rights reserved.
//

import FirebaseUI
import SwiftUI
import UIKit

let kFirebaseTermsOfService = URL(string: "https://firebase.google.com/terms/")!
let kFirebasePrivacyPolicy = URL(string: "https://firebase.google.com/support/privacy/")!

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        if let windowScene = scene as? UIWindowScene {
            /// Create a window and add a landing VC until the listener returns
            
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = AuthenticationLandingViewController()
            self.window = window
            window.makeKeyAndVisible()
            
            /// Start listening for Firebase auth status
            
            guard let auth = FUIAuth.defaultAuthUI()?.auth else {
                return
            }
            auth.addStateDidChangeListener { [weak self] auth, user in
                if user != nil {
                    window.rootViewController = self?.rootVCAfterAuth()
                } else {
                    self?.authenticateUser(window: window)
                }
            }
        }
    }
    
    private func authenticateUser(window: UIWindow) {
        let authUI = FUIAuth.defaultAuthUI()
        
        authUI?.tosurl = kFirebaseTermsOfService
        authUI?.privacyPolicyURL = kFirebasePrivacyPolicy
        
        authUI?.providers = [FUIOAuth.appleAuthProvider()]
        
        // Present the auth view controller and then implement the sign in callback.
        let authViewController = AuthenticationViewController(
            nibName: "AuthenticationViewController",
            bundle: Bundle.main,
            authUI: authUI!)
        
        window.rootViewController = authViewController
    }
    
    private func rootVCAfterAuth() -> UIViewController {
        let tabBarController = UITabBarController()
        
        let homeWrapperController = UIHostingController(
            rootView: WorkoutsHomeView().environmentObject(NewDataService()))
        homeWrapperController.tabBarItem =
            UITabBarItem(
                title: NSLocalizedString("workoutPlans.home.tabBar", comment: ""),
                image: UIImage(systemName: "house"),
                tag: 0)

        let pastWorkoutsWrapperController = UIHostingController(rootView: PastWorkoutsView(viewModel: .init()))
        pastWorkoutsWrapperController.tabBarItem =
            UITabBarItem(
                title: NSLocalizedString("pastWorkouts.home.tabBar", comment: ""),
                image: UIImage(systemName: "calendar"),
                tag: 1)

        let moreWrapperController = UIHostingController(rootView: MoreView())
        moreWrapperController.tabBarItem = UITabBarItem(tabBarSystemItem: .more, tag: 2)
        
        tabBarController.addChild(homeWrapperController)
        tabBarController.addChild(pastWorkoutsWrapperController)
        tabBarController.addChild(moreWrapperController)
        
        return tabBarController
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }
    
    
}


//
//  AuthenticationViewController.swift
//  Arnie Workout Tracker
//
//  Created by Sebastian Ghetu on 04/06/2020.
//  Copyright © 2020 Sebastian Ghetu. All rights reserved.
//

import Lottie
import FirebaseUI
import UIKit

class AuthenticationViewController: FUIAuthPickerViewController {

    @IBOutlet private weak var animationViewContainer: UIView!

    private var animationView = AnimationView()

    override func viewDidLoad() {
        super.viewDidLoad()

        animationView.translatesAutoresizingMaskIntoConstraints = false
        animationViewContainer.addSubview(animationView)
        NSLayoutConstraint.activate([
            animationView
                .leadingAnchor
                .constraint(equalTo: animationViewContainer.leadingAnchor),
            animationView
                .trailingAnchor
                .constraint(equalTo: animationViewContainer.trailingAnchor),
            animationView
                .topAnchor
                .constraint(equalTo: animationViewContainer.topAnchor),
            animationView
                .bottomAnchor
                .constraint(equalTo: animationViewContainer.bottomAnchor)
        ])
        animationView.animation = Animation.named("squats")
        animationView.loopMode = .loop
        animationView.play()
    }
}

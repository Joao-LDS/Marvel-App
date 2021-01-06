//
//  AppDelegate.swift
//  Marvel App
//
//  Created by João Luis Santos on 04/08/20.
//  Copyright © 2020 João Luis Santos. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let viewModel = MainViewModel()
        let controller = MainViewController(viewModel: viewModel)
        window?.rootViewController = controller
        window?.makeKeyAndVisible()
        return true
    }

}


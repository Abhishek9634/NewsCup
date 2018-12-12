//
//  AppDelegate.swift
//  NewsCup
//
//  Created by Abhishek Thapliyal on 14/11/18.
//  Copyright © 2018 Nickelfox. All rights reserved.
//

import UIKit

var appDelegate: AppDelegate {
    return UIApplication.shared.delegate as! AppDelegate
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
       
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
       
    }

    func applicationWillEnterForeground(_ application: UIApplication) {

    }

    func applicationDidBecomeActive(_ application: UIApplication) {

    }

    func applicationWillTerminate(_ application: UIApplication) {

    }
}

extension AppDelegate {
    
    func showRootView() {
//        guard let window = self.window else { return }
//        window.rootViewController = RootViewController.newInstace
//        window.makeKeyAndVisible()
    }
    
    func setStatusBarColor() {
//        UIApplication.shared.statusBarStyle = .lightContent
    }
}


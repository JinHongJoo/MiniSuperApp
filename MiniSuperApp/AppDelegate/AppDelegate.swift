//
//  AppDelegate.swift
//  MiniSuperApp
//
//  Created by 주진홍 on 2022/11/29.
//

import UIKit
import ModernRIBs

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    private var launchRouter: LaunchRouting?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        self.window = window
        
        let result = AppRootBuilder(dependency: AppComponent()).build()
            self.launchRouter = result
            launchRouter?.launch(from: window)
        
        return true
    }
}

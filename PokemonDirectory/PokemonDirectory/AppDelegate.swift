//
//  AppDelegate.swift
//  PokemonDirectory
//
//  Created by daniele on 28/09/2020.
//  Copyright © 2020 DeeplyMadStudio. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate
{
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool
    {
        AppManager.shared.didFinishLaunching()
        AppManager.shared.logAppInfo()
        
        AppManager.shared.start()
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication)
    {
        AppManager.shared.applicationWillResignActive()
    }

    func applicationDidEnterBackground(_ application: UIApplication)
    {
        AppManager.shared.applicationDidEnterBackground()
    }

    func applicationWillEnterForeground(_ application: UIApplication)
    {
        AppManager.shared.applicationWillEnterForeground()
    }

    func applicationDidBecomeActive(_ application: UIApplication)
    {
        AppManager.shared.applicationDidBecomeActive()
    }

    func applicationWillTerminate(_ application: UIApplication)
    {
        AppManager.shared.applicationWillTerminate()
    }
    
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask
    {
        return AppManager.shared.globalDefaultSupportedOrientation
    }
}


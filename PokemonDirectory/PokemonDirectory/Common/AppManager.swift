//
//  AppManager.swift
//  PokemonDirectory
//
//  Created by daniele on 28/09/2020.
//  Copyright © 2020 DeeplyMadStudio. All rights reserved.
//

import Foundation
import UIKit

final class AppManager
{
    static let shared = AppManager()
    
    fileprivate (set) var controlFlow: ControlFlowProtocol!
    
    private init() {}
    
    func didFinishLaunching()
    {
        self.setupControlFlow()
    }
    
    func applicationDidEnterBackground()
    {
        
    }
    
    func applicationWillEnterForeground()
    {
        
    }
    
    func applicationWillResignActive()
    {
        
    }
    
    func applicationDidBecomeActive()
    {
        
    }
    
    func applicationWillTerminate()
    {
        
    }
    
    private func setupControlFlow()
    {
        self.controlFlow = ControlFlow()
    }
    
    func logAppInfo()
    {
        print("""
            
            *************** App Info ***************
            BundleIdentifier: \(Resources.AppInfo.appBundleIdentifier)
            BundleName: \(Resources.AppInfo.appBundleName)
            DisplayName: \(Resources.AppInfo.appDisplayName)
            Version: \(Resources.AppInfo.appVersion)
            BuildVersion: \(Resources.AppInfo.appBuildVersion)
            ****************************************
            
            """)
    }
    
    var globalDefaultSupportedOrientation: UIInterfaceOrientationMask
    {
        switch UIDevice.current.userInterfaceIdiom
        {
        case .phone:
            return .portrait
        case .pad:
            return .portrait
        default:
            return .all
        }
    }
    
    func start()
    {
        self.controlFlow.flowStart()
    }
}

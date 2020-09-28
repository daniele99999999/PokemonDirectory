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
    
    fileprivate (set) var controlFlow: ControlFlow!
    
    private init() {}
    
    func didFinishLaunching()
    {
        self.setupAppearance()
        self.setupControlFlow()
    }
    
    func applicationDidEnterBackground()
    {
        
    }
    
    func applicationWillEnterForeground()
    {
        
    }
    
    private func setupAppearance()
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
            BundleIdentifier: \(AppInfoUtils.getAppBundleIdentifier())
            BundleName: \(AppInfoUtils.getAppBundleName())
            DisplayName: \(AppInfoUtils.getAppDisplayName())
            Version: \(AppInfoUtils.getAppVersion())
            BuildVersion: \(AppInfoUtils.getAppBuildVersion())
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
        self.controlFlow.start()
    }
}

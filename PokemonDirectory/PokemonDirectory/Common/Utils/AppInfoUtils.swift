//
//  AppInfoUtils.swift
//  PokemonDirectory
//
//  Created by daniele on 28/09/2020.
//  Copyright © 2020 DeeplyMadStudio. All rights reserved.
//

import Foundation

class AppInfoUtils
{
    class func getAppVersion() -> String
    {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String ?? ""
    }
    
    class func getAppBuildVersion() -> String
    {
        return (Bundle.main.object(forInfoDictionaryKey: (kCFBundleVersionKey as String?) ?? "")) as? String ?? ""
    }
    
    class func getAppBundleName() -> String
    {
        return Bundle.main.infoDictionary?["CFBundleName"] as? String ?? ""
    }
    
    class func getAppDisplayName() -> String
    {
        return Bundle.main.infoDictionary?["CFBundleDisplayName"] as? String ?? self.getAppBundleName()
    }
    
    class func getAppExecutableName() -> String
    {
        return Bundle.main.infoDictionary?["CFBundleExecutable"] as? String ?? ""
    }
    
    class func getAppProcessName() -> String
    {
        return ProcessInfo.processInfo.processName
    }
    
    class func getAppFileName() -> String
    {
        let bundlePath: String = Bundle.main.bundlePath
        return FileManager.default.displayName(atPath: bundlePath)
    }
    
    class func getAppBundleIdentifier() -> String
    {
        return Bundle.main.infoDictionary?["CFBundleIdentifier"] as? String ?? ""
    }
}


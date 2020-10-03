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
    fileprivate var controlFlow: ControlFlowProtocol
    
    private init()
    {
        let networkService = NetworkService(session: URLSession(configuration: .default))
        let apiService = ApiService(baseURL: Resources.Api.baseURL,
                                    networkService: networkService)
        let persistenceService = PersistenceService()
        let repositoryService = RepositoryService(apiService: apiService,
                                                  persistenceService: persistenceService)
        self.controlFlow = ControlFlow(repositoryService: repositoryService)
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
    
    func start()
    {
        self.controlFlow.flowStart()
    }
}

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
    fileprivate var mainCoordinator: CoordinatorProtocol
    
    private init()
    {
        let networkService = NetworkService(session: URLSession(configuration: .default))
        let apiService = ApiService(baseURL: Resources.Api.baseURL,
                                    networkService: networkService)
        let persistenceService = PersistenceService()
        let repositoryService = RepositoryService(apiService: apiService,
                                                  persistenceService: persistenceService)
        self.mainCoordinator = MainCoordinator(repositoryService: repositoryService)
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
        self.mainCoordinator.start()
    }
}

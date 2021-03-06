//
//  MainCoordinator.swift
//  PokemonDirectory
//
//  Created by daniele on 28/09/2020.
//  Copyright © 2020 DeeplyMadStudio. All rights reserved.
//

import Foundation
import UIKit

struct MainCoordinator
{
    fileprivate let window: UIWindow
    fileprivate let globalNavigation: UINavigationController
    fileprivate let repositoryService: RepositoryProtocol
    
    init(repositoryService: RepositoryProtocol)
    {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.globalNavigation = UINavigationController()
        self.repositoryService = repositoryService
    }
    
    private func setupRootController(viewController: UIViewController)
    {
        self.window.rootViewController = viewController
        self.window.makeKeyAndVisible()
    }
}

extension MainCoordinator: CoordinatorProtocol
{
    func start()
    {
        let vc = self.createList()
        self.globalNavigation.setViewControllers([vc], animated: false)
        self.setupRootController(viewController: self.globalNavigation)
    }
}

private extension MainCoordinator
{// create
    func createList() -> UIViewController
    {
        let viewModel = ListViewModel(repository: self.repositoryService)
        viewModel.navigation.requestDetail = { pokemonDetail in
            self.flowDetail(model: pokemonDetail)
        }
        let vc = ListViewController.createOne(viewModel: viewModel)
        return vc
    }
    
    func createDetail(model: PokemonList.Item) -> UIViewController
    {
        let viewModel = DetailViewModel(repository: self.repositoryService, item: model)
        let vc = DetailViewController.createOne(viewModel: viewModel)
        return vc
    }
}

private extension MainCoordinator
{// flow
    func flowList(animated: Bool = true)
    {
        let vc = self.createList()
        self.globalNavigation.pushViewController(vc, animated: animated)
    }
    
    func flowDetail(animated: Bool = true, model: PokemonList.Item)
    {
        let vc = self.createDetail(model: model)
        self.globalNavigation.pushViewController(vc, animated: animated)
    }
}

//
//  ControlFlow.swift
//  PokemonDirectory
//
//  Created by daniele on 28/09/2020.
//  Copyright © 2020 DeeplyMadStudio. All rights reserved.
//

import Foundation
import UIKit

struct ControlFlow
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
    
    private var switchRootVCTransitionOptions: UIWindow.TransitionOptions
    {
        var options = UIWindow.TransitionOptions()
        options.direction = .fade
        options.duration = 0.25
        options.style = .easeOut
        return options
    }
}

extension ControlFlow: ControlFlowProtocol
{
    func flowStart()
    {
        let vc = self.createList()
        self.globalNavigation.setViewControllers([vc], animated: false)
        self.setupRootController(viewController: self.globalNavigation)
    }
}

private extension ControlFlow
{// create
    func createList() -> UIViewController
    {
        let vc = ListViewController.createOne()
        // TODO VM
        return vc
    }
    
    func createDetail(model: PokemonDetail) -> UIViewController
    {
        let vc = DetailViewController.createOne()
        // TODO VM
        return vc
    }
}

private extension ControlFlow
{// flow
    func flowList(animated: Bool = true)
    {
        let vc = self.createList()
        self.globalNavigation.pushViewController(vc, animated: animated)
    }
    
    func flowDetail(animated: Bool = true, model: PokemonDetail)
    {
        let vc = self.createDetail(model: model)
        self.globalNavigation.pushViewController(vc, animated: animated)
    }
}

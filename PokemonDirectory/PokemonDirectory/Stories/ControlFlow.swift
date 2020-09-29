//
//  ControlFlow.swift
//  PokemonDirectory
//
//  Created by daniele on 28/09/2020.
//  Copyright © 2020 DeeplyMadStudio. All rights reserved.
//

import Foundation
import UIKit

final class ControlFlow
{
    private let window: UIWindow
    private var globalNavigation: UINavigationController
    
    init()
    {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.globalNavigation = UINavigationController()
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
        let vc = self.createVC()
        self.globalNavigation.setViewControllers([vc], animated: false)
        self.setupRootController(viewController: self.globalNavigation)
    }
}

private extension ControlFlow
{// create
    func createVC() -> UIViewController
    {
        let vc = ViewController.createOne()
        return vc
    }
}

private extension ControlFlow
{// flow
    
}

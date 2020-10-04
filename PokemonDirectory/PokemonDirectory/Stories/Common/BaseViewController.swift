//
//  BaseViewController.swift
//  PokemonDirectory
//
//  Created by daniele on 28/09/2020.
//  Copyright © 2020 DeeplyMadStudio. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController
{
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator)
    {
        super.viewWillTransition(to: size, with: coordinator)
        
        let interfaceOrientation: UIInterfaceOrientation = UIApplication.shared.statusBarOrientation
        let startSize: CGSize = self.view.frame.size
        
        self.controllerWillChangeOrientation(startInterfaceOrientation: interfaceOrientation, startSize: startSize, endSize: size, context: coordinator)
        
        coordinator.animate(alongsideTransition:
        {(_ context: UIViewControllerTransitionCoordinatorContext) -> Void in
            self.controllerAlongsideChangeOrientation(startInterfaceOrientation: interfaceOrientation, startSize: startSize, endSize: size, context: coordinator)
        },
                            completion:
        {(_ context: UIViewControllerTransitionCoordinatorContext) -> Void in
            self.controllerDidChangeOrientation(startInterfaceOrientation: interfaceOrientation, startSize: startSize, endSize: size, context: coordinator)
        })
    }
    
    func controllerWillChangeOrientation(startInterfaceOrientation: UIInterfaceOrientation, startSize: CGSize, endSize: CGSize, context: UIViewControllerTransitionCoordinatorContext)
    {
        
    }
    
    func controllerAlongsideChangeOrientation(startInterfaceOrientation: UIInterfaceOrientation, startSize: CGSize, endSize: CGSize, context: UIViewControllerTransitionCoordinatorContext)
    {
        
    }
    
    func controllerDidChangeOrientation(startInterfaceOrientation: UIInterfaceOrientation, startSize: CGSize, endSize: CGSize, context: UIViewControllerTransitionCoordinatorContext)
    {
        
    }
}

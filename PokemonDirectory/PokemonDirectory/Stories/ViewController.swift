//
//  ViewController.swift
//  PokemonDirectory
//
//  Created by daniele on 28/09/2020.
//  Copyright © 2020 DeeplyMadStudio. All rights reserved.
//

import UIKit

class ViewController: BaseViewController
{
    class func createOne() -> ViewController
    {
        let vc: ViewController = self.loadFromStoryboard(storyboardName: Constants.Resources.Storyboards.main)
        return vc
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.view.backgroundColor = .red
    }
}


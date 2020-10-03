//
//  ListViewController.swift
//  PokemonDirectory
//
//  Created by daniele on 02/10/2020.
//  Copyright © 2020 DeeplyMadStudio. All rights reserved.
//

import UIKit

class ListViewController: BaseViewController
{
    class func createOne() -> ListViewController
    {
        let vc: ListViewController = self.loadFromStoryboard(storyboardName: Resources.Storyboards.main)
        return vc
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.view.backgroundColor = .green
    }
}

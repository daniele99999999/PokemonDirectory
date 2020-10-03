//
//  DetailViewController.swift
//  PokemonDirectory
//
//  Created by daniele on 02/10/2020.
//  Copyright © 2020 DeeplyMadStudio. All rights reserved.
//

import UIKit

class DetailViewController: BaseViewController
{
    class func createOne() -> DetailViewController
    {
        let vc: DetailViewController = self.loadFromStoryboard(storyboardName: Resources.Storyboards.main)
        return vc
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.view.backgroundColor = .red
    }
}

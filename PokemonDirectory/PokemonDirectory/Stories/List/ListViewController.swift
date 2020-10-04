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
    fileprivate var viewModel: ListViewModel!
    
    class func createOne(viewModel: ListViewModel) -> ListViewController
    {
        let vc: ListViewController = self.loadFromStoryboard(storyboardName: Resources.Storyboards.main)
        vc.viewModel = viewModel
        return vc
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.view.backgroundColor = .green
    }
    
    override func viewDidAppear(_ animated: Bool)
    {
        DispatchQueue.main.async
        {
            self.viewModel.navigation.requestDetail?(PokemonList.Item(name: "bulbasaur",
                                                                      url: URL(string: "https://pokeapi.co/api/v2/pokemon/1/")!))
        }
    }
}

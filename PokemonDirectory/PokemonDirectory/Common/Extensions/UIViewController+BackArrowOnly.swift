//
//  UIViewController+BackArrowOnly.swift
//  PokemonDirectory
//
//  Created by daniele on 05/10/2020.
//  Copyright © 2020 DeeplyMadStudio. All rights reserved.
//

import UIKit

extension UIViewController
{
    func showBackArrowOnly()
    {
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
}

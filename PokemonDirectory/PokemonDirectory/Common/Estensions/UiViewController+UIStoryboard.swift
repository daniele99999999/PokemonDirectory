//
//  UiViewController+UIStoryboard.swift
//  PokemonDirectory
//
//  Created by daniele on 28/09/2020.
//  Copyright © 2020 DeeplyMadStudio. All rights reserved.
//

import Foundation
import UIKit

public extension UIViewController
{
    class func loadFromStoryboard<T>(storyboardName: String, viewControllerName: String = String(describing: T.self), bundle: Bundle? = nil) -> T where T: UIViewController
    {
        let bundle = Bundle(for: self)
        
        guard let viewController = UIStoryboard(name: storyboardName, bundle: bundle).instantiateViewController(withIdentifier: viewControllerName) as? T else
        {
            fatalError("Could not load \(viewControllerName) from \(storyboardName) file.")
        }
        return viewController
    }
}

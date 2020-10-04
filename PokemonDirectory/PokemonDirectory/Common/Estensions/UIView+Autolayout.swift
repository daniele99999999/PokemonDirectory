//
//  UIView+Autolayout.swift
//  PokemonDirectory
//
//  Created by daniele on 04/10/2020.
//  Copyright © 2020 DeeplyMadStudio. All rights reserved.
//

import UIKit

extension UIView
{
    class func autoLayoutInit<T>() -> T where T: UIView
    {
        let view = T(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
}

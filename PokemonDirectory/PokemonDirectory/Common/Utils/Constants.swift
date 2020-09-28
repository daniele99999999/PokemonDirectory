//
//  Constants.swift
//  PokemonDirectory
//
//  Created by daniele on 28/09/2020.
//  Copyright © 2020 DeeplyMadStudio. All rights reserved.
//

import Foundation
import UIKit

enum Constants
{
    enum Colors
    {
        static let color000000: UIColor = UIColor.init(hex: 0x000000)!
        static let colorFFFFFF: UIColor = UIColor.init(hex: 0xFFFFFF)!
    }
    
    enum Fonts
    {
        static func systemRegular(size: CGFloat) -> UIFont { return UIFont.systemFont(ofSize: size) }
        static func systemBold(size: CGFloat) -> UIFont { return UIFont.boldSystemFont(ofSize: size) }
        static func systemItalic(size: CGFloat) -> UIFont { return UIFont.italicSystemFont(ofSize: size) }
    }
    
    enum Resources
    {
        enum Storyboards
        {
            static let main = "Main"
        }
    }
}


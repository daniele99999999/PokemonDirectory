//
//  PokemonList.swift
//  PokemonDirectory
//
//  Created by daniele on 30/09/2020.
//  Copyright © 2020 DeeplyMadStudio. All rights reserved.
//

import Foundation

public struct PokemonList: Codable, Hashable, Equatable
{
    public let count: Int
    public let next: URL?
    public let previous: URL?
    public let results: [PokemonListItem]
}

public extension PokemonList
{
    struct PokemonListItem: Codable, Hashable, Equatable
    {
        public let name: String
        public let url: URL
    }
}

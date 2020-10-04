//
//  PokemonDetail.swift
//  PokemonDirectory
//
//  Created by daniele on 30/09/2020.
//  Copyright © 2020 DeeplyMadStudio. All rights reserved.
//

import Foundation

public struct PokemonDetail: Codable, Equatable
{
    public let id: Int
    public let name: String
    public let sprites: Sprite
    public let stats: [Stat]
    public let types: [Typology]
}

public extension PokemonDetail
{
    struct Sprite: Codable, Equatable
    {
        public let frontDefault: URL
        public let frontShiny: URL?
        public let backDefault: URL?
        public let backShiny: URL?
        
        enum CodingKeys: String, CodingKey
        {
            case frontDefault = "front_default"
            case frontShiny = "front_shiny"
            case backDefault = "back_default"
            case backShiny = "back_shiny"
        }
    }
}

public extension PokemonDetail.Sprite
{
    var allSprites: [URL]
    {
        let urls: [URL?] = [self.frontDefault,
                            self.frontShiny,
                            self.backDefault,
                            self.backShiny]
        return urls.compactMap { $0 }
    }
}

public extension PokemonDetail
{
    struct Stat: Codable, Equatable
    {
        public let baseStat: Int
        public let nameStat: String
        
        enum CodingKeys: String, CodingKey
        {
            case baseStat = "base_stat"
            case stat
        }
        
        enum NameCodingKeys: String, CodingKey
        {
            case name
        }
        
        public init(from decoder: Decoder) throws
        {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.baseStat = try container.decode(Int.self, forKey: .baseStat)

            let nameContainer = try container.nestedContainer(keyedBy: NameCodingKeys.self, forKey: .stat)
            self.nameStat = try nameContainer.decode(String.self, forKey: .name)
        }
        
        public func encode(to encoder: Encoder) throws
        {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(self.baseStat, forKey: .baseStat)
            
            var nameContainer = container.nestedContainer(keyedBy: NameCodingKeys.self, forKey: .stat)
            try nameContainer.encodeIfPresent(self.nameStat, forKey: .name)
        }
    }
}

public extension PokemonDetail
{
    struct Typology: Codable, Equatable
    {
        public let nameType: String
        
        enum CodingKeys: String, CodingKey
        {
            case nameType = "type"
        }
        
        enum NameCodingKeys: String, CodingKey
        {
            case name
        }
        
        public init(from decoder: Decoder) throws
        {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            let nameContainer = try container.nestedContainer(keyedBy: NameCodingKeys.self, forKey: .nameType)
            self.nameType = try nameContainer.decode(String.self, forKey: .name)
        }
        
        public func encode(to encoder: Encoder) throws
        {
            var container = encoder.container(keyedBy: CodingKeys.self)
            var nameContainer = container.nestedContainer(keyedBy: NameCodingKeys.self, forKey: .nameType)
            try nameContainer.encodeIfPresent(self.nameType, forKey: .name)
        }
    }
}

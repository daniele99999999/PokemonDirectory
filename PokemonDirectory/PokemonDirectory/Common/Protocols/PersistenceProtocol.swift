//
//  PersistenceProtocol.swift
//  PokemonDirectory
//
//  Created by daniele on 29/09/2020.
//  Copyright © 2020 DeeplyMadStudio. All rights reserved.
//

import Foundation

public protocol PersistenceProtocol
{
    func persistanceSave<T: Codable, ID: Hashable>(_ entity: T, id: ID)
    func persistanceRetrieve<T: Codable, ID: Hashable>(_ entityType: T.Type, id: ID) -> T?
}

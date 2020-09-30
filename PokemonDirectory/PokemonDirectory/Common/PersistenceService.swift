//
//  PersistenceService.swift
//  PokemonDirectory
//
//  Created by daniele on 30/09/2020.
//  Copyright © 2020 DeeplyMadStudio. All rights reserved.
//

import Foundation

class PersistenceService: PersistenceProtocol
{
    private let userDefaults: UserDefaults
    
    init()
    {
        self.userDefaults = UserDefaults.standard
    }
    
    func persistanceSave<T: Codable, ID: Hashable>(_ entity: T, id: ID) throws
    {
        let data = try JSONEncoder().encode(entity)
        let key = String(id.hashValue)
        self.userDefaults.set(data, forKey: key)
    }
    
    func persistanceRetrieve<T: Codable, ID: Hashable>(_ entityType: T.Type, id: ID) throws -> T?
    {
        let key = String(id.hashValue)
        guard let _data = self.userDefaults.data(forKey: key) else { return nil }
        let element = try JSONDecoder().decode(T.self, from: _data)
        
        return element
    }
}

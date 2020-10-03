//
//  PersistenceService.swift
//  PokemonDirectory
//
//  Created by daniele on 30/09/2020.
//  Copyright © 2020 DeeplyMadStudio. All rights reserved.
//

import Foundation

class PersistenceService
{
    private let encoder: JSONEncoder
    private let decoder: JSONDecoder
    private let userDefaults: UserDefaults
    
    init()
    {
        self.encoder = JSONEncoder()
        self.decoder = JSONDecoder()
        self.userDefaults = UserDefaults.standard
    }
}

extension PersistenceService: PersistenceProtocol
{
    func persistanceSave<T: Codable, ID: LosslessStringConvertible>(_ entity: T, id: ID) throws
    {
        let key = id.description
        let data = try self.encoder.encode(entity)
        self.userDefaults.set(data, forKey: key)
    }
    
    func persistanceRetrieve<T: Codable, ID: LosslessStringConvertible>(_ entityType: T.Type, id: ID) throws -> T?
    {
        let key = id.description
        guard let _data = self.userDefaults.data(forKey: key) else { return nil }
        let element = try self.decoder.decode(T.self, from: _data)
        
        return element
    }
}

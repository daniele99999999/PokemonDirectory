//
//  PersistenceServiceMock.swift
//  PokemonDirectoryTests
//
//  Created by daniele on 03/10/2020.
//  Copyright © 2020 DeeplyMadStudio. All rights reserved.
//

@testable import PokemonDirectory
import Foundation

class PersistenceServiceMock<TM: Codable, IDM: LosslessStringConvertible & Hashable>: PersistenceProtocol
{
    var list = [IDM: TM]()

    func set(_ value: TM, for key: IDM)
    {
        self.list[key] = value
    }

    func persistanceSave<T: Codable, ID: LosslessStringConvertible>(_ entity: T, id: ID) throws
    {
        guard
            let entity = entity as? TM,
            let id = id as? IDM
            else { return }

//        _list.mutate{ $0[id] = entity }
        self.list[id] = entity
    }

    func persistanceRetrieve<T: Codable, ID: LosslessStringConvertible>(_ entityType: T.Type, id: ID) throws -> T?
    {
        guard
            let id = id as? IDM
            else { return nil }

        return self.list[id] as? T
    }
}

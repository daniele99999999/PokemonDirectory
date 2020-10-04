//
//  PersistenceTests.swift
//  PokemonDirectoryTests
//
//  Created by daniele on 30/09/2020.
//  Copyright © 2020 DeeplyMadStudio. All rights reserved.
//

import XCTest
@testable import PokemonDirectory

class PersistenceTests: XCTestCase
{
    func testPersistencePokemonList()
    {
        let persistence = PersistenceService()
        let data = PokemonList(count: 1,
                               next: nil,
                               previous: nil,
                               results: [])
        let id = UUID().uuidString
        try? persistence.persistanceSave(data, id: id)
        let result = try? persistence.persistanceRetrieve(PokemonList.self, id: id)
        XCTAssertEqual(result, data)
    }
    
    func testPersistencePokemonDetail()
    {
        let persistence = PersistenceService()
        let data = PokemonDetail(id: 1,
                                 name: "name",
                                 sprites: PokemonDetail.Sprite(frontDefault: nil,
                                                               frontShiny: nil,
                                                               backDefault: nil,
                                                               backShiny: nil,
                                                               officialArtwork: nil),
                                 stats: [],
                                 types: [])
        
        let id = UUID().uuidString
        try? persistence.persistanceSave(data, id: id)
        let result = try? persistence.persistanceRetrieve(PokemonDetail.self, id: id)
        XCTAssertEqual(result, data)
    }
    
    func testPersistencePokemonImage()
    {
        let persistence = PersistenceService()
        let data = "test".data(using: .utf8)
        let id = UUID().uuidString
        try? persistence.persistanceSave(data, id: id)
        let result = try? persistence.persistanceRetrieve(Data.self, id: id)
        XCTAssertEqual(result, data)
    }
}

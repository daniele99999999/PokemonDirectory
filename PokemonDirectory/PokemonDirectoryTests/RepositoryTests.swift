//
//  RepositoryTests.swift
//  PokemonDirectoryTests
//
//  Created by daniele on 30/09/2020.
//  Copyright © 2020 DeeplyMadStudio. All rights reserved.
//

import XCTest
@testable import PokemonDirectory

class RepositoryTests: XCTestCase
{
    func testRepositoryPokemonList()
    {
        let pokemonListMock = try! JSONDecoder().decode(PokemonList.self, from: StorageUtils.loadJSON(name: "pokemonListDataMock", bundle: Bundle(for: RepositoryTests.self))!)
        let limit = 20
        let offset = 0
        let id = "\(limit.description).\(offset.description)"
        
        let expectation = self.expectation(description: "testRepositoryPokemonList")
        let apiServiceMock = ApiServiceMock()
        apiServiceMock._apiGetList = { _, _, completion in
            XCTFail("ApiService should not be called")
        }
        let persistenceServiceMock = PersistenceServiceMock<PokemonList, String>()
        persistenceServiceMock.set(pokemonListMock, for: id)
        let repositoryService = RepositoryService(apiService: apiServiceMock,
                                                  persistenceService: persistenceServiceMock)
        repositoryService.repoGetList(limit: limit,
                                      offset: offset)
        { result in
            let dataOut = try! result.get()
            
            expectation.fulfill()
            XCTAssertEqual(dataOut, pokemonListMock)
        }
        
        self.waitForExpectations(timeout: 1)
    }
    
    func testRepositoryPokemonDetail()
    {
        let pokemonDetailMock = try! JSONDecoder().decode(PokemonDetail.self, from: StorageUtils.loadJSON(name: "pokemonDetailDataMock", bundle: Bundle(for: RepositoryTests.self))!)
        let url = URL(string: "https://pokeapi.co/api/v2/pokemon/1")!
        let id = url.lastPathComponent.description
        
        let expectation = self.expectation(description: "testRepositoryPokemonDetail")
        let apiServiceMock = ApiServiceMock()
        apiServiceMock._apiGetDetail = { _, completion in
            XCTFail("ApiService should not be called")
        }
        let persistenceServiceMock = PersistenceServiceMock<PokemonDetail, String>()
        persistenceServiceMock.set(pokemonDetailMock, for: id)
        let repositoryService = RepositoryService(apiService: apiServiceMock,
                                                  persistenceService: persistenceServiceMock)
        repositoryService.repoGetDetail(url: url)
        { result in
            let dataOut = try! result.get()
            
            expectation.fulfill()
            XCTAssertEqual(dataOut, pokemonDetailMock)
        }
        
        self.waitForExpectations(timeout: 1)
    }
    
    func testRepositoryImage()
    {
        let imageDataMock = "test".data(using: .utf8)!
        let url = URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png")!
        let id = url.absoluteString.description
        
        let expectation = self.expectation(description: "testRepositoryImage")
        let apiServiceMock = ApiServiceMock()
        apiServiceMock._getImage = { _, completion in
            XCTFail("ApiService should not be called")
            return {}
        }
        let persistenceServiceMock = PersistenceServiceMock<Data, String>()
        persistenceServiceMock.set(imageDataMock, for: id)
        let repositoryService = RepositoryService(apiService: apiServiceMock,
                                                  persistenceService: persistenceServiceMock)
        _ = repositoryService.repoGetImage(url: url,
                                           completion:
        { result in
            let imageDataOut = try! result.get()
            
            expectation.fulfill()
            XCTAssertEqual(imageDataOut, imageDataMock)
        })
        
        self.waitForExpectations(timeout: 1)
    }
}

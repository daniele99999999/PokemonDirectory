//
//  ListCellViewModelTests.swift
//  PokemonDirectoryTests
//
//  Created by daniele on 05/10/2020.
//  Copyright © 2020 DeeplyMadStudio. All rights reserved.
//

import XCTest
@testable import PokemonDirectory

class ListCellViewModelTests: XCTestCase
{
    let imageDataMock: Data = "test".data(using: .utf8)!
    var pokemonListItem: PokemonList.Item!
    var pokemonDetailMock: PokemonDetail!
    var repositoryServiceMock: RepositoryServiceMock!
    var listCellViewModel: ListCellViewModel!
    struct FakeError: Error {}
    let fakeError = FakeError()
    
    override func setUp()
    {
        self.pokemonListItem = PokemonList.Item(name: "test1", url: URL(string: "https://www.test1.com")!)
        
        self.pokemonDetailMock = PokemonDetail(id: 1,
                                               name: "nomeTest",
                                               sprites: .init(frontDefault: URL(string: "https://www.frontDefault.com")!,
                                                              frontShiny: URL(string: "https://www.frontShiny.com")!,
                                                              backDefault: URL(string: "https://www.backDefault.com")!,
                                                              backShiny: URL(string: "https://www.backShiny.com")!,
                                                              officialArtwork: URL(string: "https://www.officialArtwork.com")!),
                                               stats: [.init(baseStat: 1, nameStat: "stat1"),
                                                       .init(baseStat: 2, nameStat: "stat2")],
                                               types: [.init(nameType: "topology1"),
                                                       .init(nameType: "topology2")])
        
        self.repositoryServiceMock = RepositoryServiceMock()
        self.listCellViewModel = ListCellViewModel(item: self.pokemonListItem,
                                                   repository: self.repositoryServiceMock)
    }
    
    func testError()
    {
        let expectation1 = self.expectation(description: "testError p1")
        
        self.repositoryServiceMock._repoGetDetail = { _, completion in
            completion(.failure(self.fakeError))
        }
        
        self.listCellViewModel.output.error = { message in
            expectation1.fulfill()
            XCTAssertTrue(message.contains("FakeError"))
        }
        self.listCellViewModel.input.loadData?()
        
        self.waitForExpectations(timeout: 1)
        
        let expectation2 = self.expectation(description: "testError p2")
        
        self.repositoryServiceMock._repoGetDetail = { _, completion in
            completion(.success(self.pokemonDetailMock))
        }
        
        self.repositoryServiceMock._repoImage = { _, completion in
            completion(.failure(self.fakeError))
            return {}
        }
        
        self.listCellViewModel.output.error = { message in
            expectation2.fulfill()
            XCTAssertTrue(message.contains("FakeError"))
        }
        self.listCellViewModel.input.loadData?()
        
        self.waitForExpectations(timeout: 1)
    }
    
    func testReset()
    {
        let expectation = self.expectation(description: "testReset")
        
        self.listCellViewModel.output.reset = {
            expectation.fulfill()
        }
        
        self.listCellViewModel.input.reset?()
        
        self.waitForExpectations(timeout: 1)
    }
    
    func testImage()
    {
        let expectation = self.expectation(description: "testImage")
        
        self.repositoryServiceMock._repoGetDetail = { _, completion in
            completion(.success(self.pokemonDetailMock))
        }
        
        self.repositoryServiceMock._repoImage = { url, completion in
            completion(.success(url.absoluteString.data(using: .utf8)!))
            return {}
        }
        
        self.listCellViewModel.output.image = { data in
            expectation.fulfill()
            XCTAssertEqual(String(data: data, encoding: .utf8)!, "https://www.frontDefault.com")
        }
        self.listCellViewModel.input.loadData?()
        
        self.waitForExpectations(timeout: 1)
    }
    
    func testName()
    {
        let expectation = self.expectation(description: "testName")
        
        self.repositoryServiceMock._repoGetDetail = { _, completion in
            completion(.success(self.pokemonDetailMock))
        }
        
        self.repositoryServiceMock._repoImage = { _, completion in
            completion(.success(self.imageDataMock))
            return {}
        }
        
        self.listCellViewModel.output.name = { name in
            expectation.fulfill()
            XCTAssertEqual(name, "test1")
        }
        self.listCellViewModel.input.loadData?()
        
        self.waitForExpectations(timeout: 1)
    }
}


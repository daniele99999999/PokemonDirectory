//
//  DetailViewModelTests.swift
//  PokemonDirectoryTests
//
//  Created by daniele on 04/10/2020.
//  Copyright © 2020 DeeplyMadStudio. All rights reserved.
//

import XCTest
@testable import PokemonDirectory

class DetailViewModelTests: XCTestCase
{
    let imageDataMock: Data = "test".data(using: .utf8)!
    var pokemonListMock: PokemonList!
    var pokemonDetailMock: PokemonDetail!
    var repositoryServiceMock: RepositoryServiceMock!
    var detailViewModel: DetailViewModel!
    struct FakeError: Error {}
    let fakeError = FakeError()
    
    override func setUp()
    {
        self.pokemonListMock = PokemonList(count: 1,
                                           next: URL(string: "https://www.next.com")!,
                                           previous: URL(string: "https://www.previous.com")!,
                                           results: [.init(name: "test1", url: URL(string: "https://www.test1.com")!)])
        
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
        self.detailViewModel = DetailViewModel(repository: self.repositoryServiceMock,
                                               item: self.pokemonListMock.results.first!)
    }
    
    func testIsLoading()
    {
        let expectation = self.expectation(description: "testIsLoading")
        expectation.expectedFulfillmentCount = 2

        var loadingCount = 0
        self.repositoryServiceMock._repoGetDetail = { _, completion in
            completion(.success(self.pokemonDetailMock))
        }
        self.repositoryServiceMock._repoImage = { _, completion in
            completion(.success(self.imageDataMock))
            return {}
        }

        self.detailViewModel.output.isLoading = { isLoading in
            loadingCount += 1
            expectation.fulfill()
        }
        self.detailViewModel.input.loadData?()
        
        self.waitForExpectations(timeout: 1)
        XCTAssertEqual(loadingCount, 2)
    }
    
    func testError()
    {
        let expectation = self.expectation(description: "testError")
        
        self.repositoryServiceMock._repoGetDetail = { _, completion in
            completion(.failure(self.fakeError))
        }
        
        self.detailViewModel.output.error = { message in
            expectation.fulfill()
            XCTAssertTrue(message.contains("FakeError"))
        }
        self.detailViewModel.input.loadData?()
        
        self.waitForExpectations(timeout: 1)
    }
    
    func testTitle()
    {
        let expectation = self.expectation(description: "testTitle")
        
        self.detailViewModel.output.title = { title in
            expectation.fulfill()
            XCTAssertEqual(title, "TEST1")
        }
        self.detailViewModel.input.loadData?()
        
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
        
        self.detailViewModel.output.name = { name in
            expectation.fulfill()
            XCTAssertEqual(name, "nomeTest")
        }
        self.detailViewModel.input.loadData?()
        
        self.waitForExpectations(timeout: 1)
    }
    
    func testReferenceImage()
    {
        let expectation = self.expectation(description: "testReferenceImage")

        self.repositoryServiceMock._repoGetDetail = { _, completion in
            completion(.success(self.pokemonDetailMock))
        }
        self.repositoryServiceMock._repoImage = { url, completion in
            completion(.success(url.absoluteString.data(using: .utf8)!))
            return {}
        }

        self.detailViewModel.output.referenceImage = { data in
            expectation.fulfill()
            XCTAssertEqual(String(decoding: data, as: UTF8.self), "https://www.officialArtwork.com")
        }
        self.detailViewModel.input.loadData?()
        
        self.waitForExpectations(timeout: 1)
    }
    
    func testImages()
    {
        let expectation = self.expectation(description: "testImages")
        expectation.expectedFulfillmentCount = 4

        var imagesCount = 0
        self.repositoryServiceMock._repoGetDetail = { _, completion in
            completion(.success(self.pokemonDetailMock))
        }
        self.repositoryServiceMock._repoImage = { url, completion in
            completion(.success(self.imageDataMock))
            return {}
        }

        self.detailViewModel.output.images = { data in
            imagesCount += 1
            expectation.fulfill()
        }
        self.detailViewModel.input.loadData?()
        
        self.waitForExpectations(timeout: 1)
        XCTAssertEqual(imagesCount, 4)
    }
    
    func testTypologyTitle()
    {
        let expectation = self.expectation(description: "testTypologyTitle")
        
        self.detailViewModel.output.typologyTitle = { title in
            expectation.fulfill()
            XCTAssertEqual(title, NSLocalizedString("detail.typology.title", comment: ""))
        }
        self.detailViewModel.input.loadData?()
        
        self.waitForExpectations(timeout: 1)
    }
    
    func testTypology()
    {
        let expectation = self.expectation(description: "testTypology")

        self.repositoryServiceMock._repoGetDetail = { _, completion in
            completion(.success(self.pokemonDetailMock))
        }
        self.repositoryServiceMock._repoImage = { url, completion in
            completion(.success(self.imageDataMock))
            return {}
        }

        self.detailViewModel.output.typology = { typology in
            expectation.fulfill()
            XCTAssertEqual(typology.count, 2)
            XCTAssertEqual(typology[0], "topology1")
            XCTAssertEqual(typology[1], "topology2")
        }
        self.detailViewModel.input.loadData?()
        
        self.waitForExpectations(timeout: 1)
    }
    
    func testStatsTitle()
    {
        let expectation = self.expectation(description: "testStatsTitle")
        
        self.detailViewModel.output.statsTitle = { title in
            expectation.fulfill()
            XCTAssertEqual(title, NSLocalizedString("detail.stats.title", comment: ""))
        }
        self.detailViewModel.input.loadData?()
        
        self.waitForExpectations(timeout: 1)
    }
    
    func testStats()
    {
        let expectation = self.expectation(description: "testStats")

        self.repositoryServiceMock._repoGetDetail = { _, completion in
            completion(.success(self.pokemonDetailMock))
        }
        self.repositoryServiceMock._repoImage = { url, completion in
            completion(.success(self.imageDataMock))
            return {}
        }

        self.detailViewModel.output.stats = { stats in
            expectation.fulfill()
            XCTAssertEqual(stats.count, 2)
            XCTAssertEqual(stats[0], "stat1: 1")
            XCTAssertEqual(stats[1], "stat2: 2")
        }
        self.detailViewModel.input.loadData?()
        
        self.waitForExpectations(timeout: 1)
    }
}

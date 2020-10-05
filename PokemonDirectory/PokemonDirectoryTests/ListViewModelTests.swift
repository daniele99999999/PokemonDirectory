//
//  ListViewModelTests.swift
//  PokemonDirectoryTests
//
//  Created by daniele on 04/10/2020.
//  Copyright © 2020 DeeplyMadStudio. All rights reserved.
//

import XCTest
@testable import PokemonDirectory

class ListViewModelTests: XCTestCase
{
    var pokemonListMock: PokemonList!
    var repositoryServiceMock: RepositoryServiceMock!
    var listViewModel: ListViewModel!
    struct FakeError: Error {}
    let fakeError = FakeError()
    
    override func setUp()
    {
        self.pokemonListMock = PokemonList(count: 1,
                                           next: URL(string: "https://www.next.com")!,
                                           previous: URL(string: "https://www.previous.com")!,
                                           results: [.init(name: "test1", url: URL(string: "https://www.test1.com")!)])
        
        self.repositoryServiceMock = RepositoryServiceMock()
        self.listViewModel = ListViewModel(repository: self.repositoryServiceMock,
                                           limit: 20,
                                           page: 1)
    }
    
    func testIsLoading()
    {
        // TODO strutturare e consumare la logica di base
        
        XCTAssertTrue(true)
    }
    
    func testError()
    {
        let expectation = self.expectation(description: "testError")
        
        self.repositoryServiceMock._repoGetList = { _, _, completion in
            completion(.failure(self.fakeError))
        }
        
        self.listViewModel.output.error = { message in
            expectation.fulfill()
            XCTAssertTrue(message.contains("FakeError"))
        }
        self.listViewModel.input.loadData?()
        
        self.waitForExpectations(timeout: 1)
    }
    
    func testTitle()
    {
        let expectation = self.expectation(description: "testTitle")
        
        self.listViewModel.output.title = { title in
            expectation.fulfill()
            XCTAssertEqual(title, NSLocalizedString("list.title", comment: "").uppercased())
        }
        self.listViewModel.input.loadData?()
        
        self.waitForExpectations(timeout: 1)
    }
    
    func testUpdates()
    {
        let expectation = self.expectation(description: "testUpdates")
        
        self.repositoryServiceMock._repoGetList = { _, _, completion in
            completion(.success(self.pokemonListMock))
        }
        
        self.listViewModel.output.updates = { updates in
            XCTAssertEqual(updates, .insert([.init(row: 0, section: 0)]))
            XCTAssertEqual(updates.count, 1)
            expectation.fulfill()
        }
        self.listViewModel.input.loadData?()
        
        self.waitForExpectations(timeout: 1)
    }
    
    func testRequestDetail()
    {
        let expectation1 = self.expectation(description: "testRequestDetail p1")
        
        self.repositoryServiceMock._repoGetList = { _, _, completion in
            completion(.success(self.pokemonListMock))
        }
        
        self.listViewModel.output.updates = { update in
            expectation1.fulfill()
        }
        self.listViewModel.input.loadData?()
        waitForExpectations(timeout: 1)
        
        let expectation2 = expectation(description: "testRequestDetail p2")
        self.listViewModel.navigation.requestDetail = { item in
            expectation2.fulfill()
            XCTAssertEqual(item.name, "test1")
            XCTAssertEqual(item.url.absoluteString, "https://www.test1.com")
        }
        self.listViewModel.input.loadDetailForIndex?(0)

        self.waitForExpectations(timeout: 1)
    }
}

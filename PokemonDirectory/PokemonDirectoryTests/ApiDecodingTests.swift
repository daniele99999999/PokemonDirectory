//
//  ApiDecodingTests.swift
//  PokemonDirectoryTests
//
//  Created by daniele on 02/10/2020.
//  Copyright © 2020 DeeplyMadStudio. All rights reserved.
//

import XCTest
@testable import PokemonDirectory

class ApiDecodingTests: XCTestCase
{
    var pokemonListDataMock: Data = StorageUtils.loadJSON(name: "pokemonListDataMock", bundle: Bundle(for: ApiDecodingTests.self))!
    var pokemonDetailDataMock: Data = StorageUtils.loadJSON(name: "pokemonDetailDataMock", bundle: Bundle(for: ApiDecodingTests.self))!
    
    func testDecodingApiList()
    {
        let url = URL(string: "https://www.google.com")!
        let limit = 20
        let offset = 0
        
        let expectation = self.expectation(description: "testDecodingApiList")
        var networkServiceMock = NetworkServiceMock()
        networkServiceMock._networkDataTask = {_, completion in
            completion(.success(self.pokemonListDataMock))
        }
        
        let apiService:ApiService = ApiService(baseURL: url,
                                               networkService: networkServiceMock)
        apiService.apiGetList(limit: limit, offset: offset)
        { result in
            let data = try! result.get()
            
            expectation.fulfill()
            XCTAssertEqual(data.results.count, 20)
            XCTAssertEqual(data.results.first?.name, "bulbasaur")
            // TODO: controllare tutte le proprietà
        }
        
        self.waitForExpectations(timeout: 1)
    }
    
    func testDecodingApiDetail()
    {
        let url = URL(string: "https://www.google.com")!
        
        let expectation = self.expectation(description: "testDecodingApiDetail")
        var networkServiceMock = NetworkServiceMock()
        networkServiceMock._networkDataTask = {_, completion in
            completion(.success(self.pokemonDetailDataMock))
        }
        
        let apiService:ApiService = ApiService(baseURL: url,
                                               networkService: networkServiceMock)
        apiService.apiGetDetail(url: url)
        { result in
            let data = try! result.get()
            
            expectation.fulfill()
            XCTAssertEqual(data.name, "bulbasaur")
            // TODO: controllare tutte le proprietà
        }
        
        self.waitForExpectations(timeout: 1)
    }
}

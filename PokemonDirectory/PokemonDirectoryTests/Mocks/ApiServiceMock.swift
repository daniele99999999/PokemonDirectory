//
//  ApiServiceMock.swift
//  PokemonDirectoryTests
//
//  Created by daniele on 03/10/2020.
//  Copyright © 2020 DeeplyMadStudio. All rights reserved.
//

@testable import PokemonDirectory
import Foundation

struct ApiServiceMock: APIProtocol
{
    var _apiGetList:((Int, Int, @escaping (Result<PokemonList, Error>) -> Void) -> Void)?
    func apiGetList(limit: Int, offset: Int, completion: @escaping (Result<PokemonList, Error>) -> Void)
    {
        self._apiGetList?(limit, offset, completion)
    }
    
    var _apiGetDetail:((URL, @escaping (Result<PokemonDetail, Error>) -> Void) -> Void)?
    func apiGetDetail(url: URL, completion: @escaping (Result<PokemonDetail, Error>) -> Void)
    {
        self._apiGetDetail?(url, completion)
    }
    
    var _getImage:((URL, @escaping (Result<Data, Error>) -> Void) -> VoidClosure)?
    func apiGetImage(url: URL, completion: @escaping (Result<Data, Error>) -> Void) -> VoidClosure
    {
        return self._getImage!(url, completion)
    }
}

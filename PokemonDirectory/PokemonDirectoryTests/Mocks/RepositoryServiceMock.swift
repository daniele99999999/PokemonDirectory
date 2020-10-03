//
//  RepositoryServiceMock.swift
//  PokemonDirectoryTests
//
//  Created by daniele on 03/10/2020.
//  Copyright © 2020 DeeplyMadStudio. All rights reserved.
//

@testable import PokemonDirectory
import Foundation

struct RepositoryServiceMock: RepositoryProtocol
{
    var _repoGetList:((Int, Int, @escaping (Result<PokemonList, Error>) -> Void) -> Void)?
    func repoGetList(limit: Int, offset: Int, completion: @escaping (Result<PokemonList, Error>) -> Void)
    {
        self._repoGetList?(limit, offset, completion)
    }
    
    var _repoGetDetail:((URL, @escaping (Result<PokemonDetail, Error>) -> Void) -> Void)?
    func repoGetDetail(url: URL, completion: @escaping (Result<PokemonDetail, Error>) -> Void)
    {
        self._repoGetDetail?(url, completion)
    }
    
    var _repoImage:((URL, @escaping (Result<Data, Error>) -> Void) -> VoidClosure)?
    func repoGetImage(url: URL, completion: @escaping (Result<Data, Error>) -> Void) -> VoidClosure
    {
        return self._repoImage!(url, completion)
    }
}

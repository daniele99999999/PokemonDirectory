//
//  RepositoryProtocol.swift
//  PokemonDirectory
//
//  Created by daniele on 29/09/2020.
//  Copyright © 2020 DeeplyMadStudio. All rights reserved.
//

import Foundation

public protocol RepositoryProtocol
{
    func repoGetList(limit: Int, page: Int, completion: @escaping (Result<String, Error>) -> Void)
    func repoGetDetail(url: URL, completion: @escaping (Result<String, Error>) -> Void)
}

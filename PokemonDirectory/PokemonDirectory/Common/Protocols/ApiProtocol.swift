//
//  ApiProtocols.swift
//  PokemonDirectory
//
//  Created by daniele on 28/09/2020.
//  Copyright © 2020 DeeplyMadStudio. All rights reserved.
//

import Foundation

public protocol APIProtocol
{
    func apiGetList(limit: Int, page: Int, completion: @escaping (Result<String, Error>) -> Void)
    func apiGetDetails(url: URL, completion: @escaping (Result<String, Error>) -> Void)
}

public protocol APIHandleResponseProtocol
{
    func handle<T: Decodable>(completion: @escaping (Result<T, Error>) -> Void) -> (Result<Data, Error>) -> Void
}

public extension APIHandleResponseProtocol
{
    func handle<T: Decodable>(completion: @escaping (Result<T, Error>) -> Void) -> (Result<Data, Error>) -> Void
    {
        return { result in
            switch result
            {
            case .success(let data):
                do
                {
                    let decoded = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(decoded))
                }
                catch let decodeError
                {
                    completion(.failure(decodeError))
                }
            case .failure(let responseError):
                completion(.failure(responseError))
            }
        }
    }
}

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
    func apiGetList(limit: Int, offset: Int, completion: @escaping (Result<PokemonList, Error>) -> Void)
    func apiGetDetail(url: URL, completion: @escaping (Result<PokemonDetail, Error>) -> Void)
    func apiGetImage(url: URL, completion: @escaping (Result<Data, Error>) -> Void) -> VoidClosure
}

public protocol APIHandleResponseProtocol
{
    func handleResponse<T: Decodable>(completion: @escaping (Result<T, Error>) -> Void) -> (Result<Data, Error>) -> Void
}

public extension APIHandleResponseProtocol
{
    func handleResponse<T: Decodable>(completion: @escaping (Result<T, Error>) -> Void) -> (Result<Data, Error>) -> Void
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

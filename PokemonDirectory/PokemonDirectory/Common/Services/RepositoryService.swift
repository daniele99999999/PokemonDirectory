//
//  RepositoryService.swift
//  PokemonDirectory
//
//  Created by daniele on 01/10/2020.
//  Copyright © 2020 DeeplyMadStudio. All rights reserved.
//

import Foundation

struct RepositoryService
{
    let apiService: APIProtocol
    let persistenceService: PersistenceProtocol
    
    init(apiService: APIProtocol, persistenceService: PersistenceProtocol)
    {
        self.apiService = apiService
        self.persistenceService = persistenceService
    }
}

extension RepositoryService: RepositoryProtocol
{
    func repoGetList(limit: Int, offset: Int, completion: @escaping (Result<PokemonList, Error>) -> Void)
    {
        let id = "\(limit.description).\(offset.description)"
        var result: PokemonList? = nil
        do
        {
            result = try self.persistenceService.persistanceRetrieve(PokemonList.self, id: id)
        }
        catch let persistenceError { completion(.failure(persistenceError)) }
        
        switch result
        {
        case .none:
            self.apiService.apiGetList(limit: limit, offset: offset)
            { result in
                switch result
                {
                case let .success(pokemonList):
                    do
                    {
                        try self.persistenceService.persistanceSave(pokemonList, id: id)
                        completion(.success(pokemonList))
                    }
                    catch let persistenceError { completion(.failure(persistenceError)) }
                case let .failure(networkError):
                    completion(.failure(networkError))
                }
            }
        case .some(let pokemonList):
            completion(.success(pokemonList))
            return
        }
    }
    
    func repoGetDetail(url: URL, completion: @escaping (Result<PokemonDetail, Error>) -> Void)
    {
        let id = url.lastPathComponent.description
        var result: PokemonDetail? = nil
        do
        {
            result = try self.persistenceService.persistanceRetrieve(PokemonDetail.self, id: id)
        }
        catch let persistenceError { completion(.failure(persistenceError)) }
        
        switch result
        {
        case .none:
            self.apiService.apiGetDetail(url: url)
            { result in
                switch result
                {
                case let .success(pokemonDetail):
                    do
                    {
                        try self.persistenceService.persistanceSave(pokemonDetail, id: id)
                        completion(.success(pokemonDetail))
                    }
                    catch let persistenceError { completion(.failure(persistenceError)) }
                case let .failure(networkError):
                    completion(.failure(networkError))
                }
            }
        case .some(let pokemonDetail):
            completion(.success(pokemonDetail))
        }
    }
    
    func repoGetImage(url: URL, completion: @escaping (Result<Data, Error>) -> Void) -> VoidClosure
    {
        let id = url.absoluteString.description
        var result: Data? = nil
        do
        {
            result = try self.persistenceService.persistanceRetrieve(Data.self, id: id)
        }
        catch let persistenceError { completion(.failure(persistenceError)) }
        switch result
        {
        case .none:
            let cancellableTask = self.apiService.apiGetImage(url: url)
            { result in
                switch result
                {
                case let .success(imageData):
                    do
                    {
                        try self.persistenceService.persistanceSave(imageData, id: id)
                        completion(.success(imageData))
                    }
                    catch let persistenceError { completion(.failure(persistenceError)) }
                case let .failure(networkError):
                    completion(.failure(networkError))
                }
            }
            return cancellableTask
        case .some(let imageData):
            completion(.success(imageData))
            return {}
        }
    }
}

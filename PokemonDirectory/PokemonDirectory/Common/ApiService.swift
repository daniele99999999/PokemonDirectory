//
//  ApiService.swift
//  PokemonDirectory
//
//  Created by daniele on 30/09/2020.
//  Copyright © 2020 DeeplyMadStudio. All rights reserved.
//

import Foundation

struct ApiService
{
    enum Endpoints
    {
        case list
        
        var path: String
        {
            switch self
            {
            case .list:
                return "pokemon"
            }
        }
        
        func url(baseURL: URL) -> URL
        {
            switch self
            {
            case .list:
                return baseURL.appendingPathComponent(self.path)
            }
        }
    }
    
    let baseURL: URL
    let networkService: NetworkProtocol
    
    init(baseURL: URL, networkService: NetworkProtocol)
    {
        self.baseURL = baseURL
        self.networkService = networkService
    }
}

// TODO implementare il giro del cancellable
extension ApiService: APIHandleResponseProtocol {}
extension ApiService: APIProtocol
{
    func apiGetList(limit: Int, offset: Int, completion: @escaping (Result<PokemonList, Error>) -> Void)
    {
        let url = Endpoints.list.url(baseURL: self.baseURL)
        let queryItems = [URLQueryItem(name: "offset", value: String(offset)),
                          URLQueryItem(name: "limit", value: String(limit))]
        var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)
        urlComponents?.queryItems = queryItems
        guard let fullUrl = urlComponents?.url else { return }
        let request = URLRequest(url: fullUrl)
        _ = self.networkService.networkDataTask(request: request,
                                                completion: self.handleResponse(completion: completion))
    }
    
    func apiGetDetail(url: URL, completion: @escaping (Result<PokemonDetail, Error>) -> Void)
    {
        let request = URLRequest(url: url)
        _ = self.networkService.networkDataTask(request: request, completion: self.handleResponse(completion: completion))
    }
    
    func apiGetImage(url: URL, completion: @escaping (Result<Data, Error>) -> Void)
    {
        let request = URLRequest(url: url)
        _ = self.networkService.networkDataTask(request: request, completion: completion)
    }
}


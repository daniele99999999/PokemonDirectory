//
//  NetworkServiceMock.swift
//  PokemonDirectoryTests
//
//  Created by daniele on 03/10/2020.
//  Copyright © 2020 DeeplyMadStudio. All rights reserved.
//

@testable import PokemonDirectory
import Foundation

class NetworkServiceMock: NetworkProtocol
{
    var _networkDataTask: ((URLRequest, @escaping (Result<Data, Error>) -> Void) -> Void)?
    var _cancellable: VoidClosure = {}
    @discardableResult func networkDataTask(request: URLRequest, completion: @escaping (Result<Data, Error>) -> Void) -> VoidClosure
    {
        self._networkDataTask?(request, completion)
        return self._cancellable
    }
}

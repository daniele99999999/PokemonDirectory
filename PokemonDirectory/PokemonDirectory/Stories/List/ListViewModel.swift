//
//  ListViewModel.swift
//  PokemonDirectory
//
//  Created by daniele on 03/10/2020.
//  Copyright © 2020 DeeplyMadStudio. All rights reserved.
//

import Foundation

struct ListViewModel
{
    private let repository: RepositoryProtocol
    private let limit: Int
    private let page: Int
    
    let input = Input()
    let output = Output()
    let navigation = Navigation()
    
    init(repository: RepositoryProtocol, limit: Int = 20, page: Int = 1)
    {
        self.repository = repository
        self.limit = limit
        self.page = page
        
        self.input.loadNextPage = self.loadNextPage
        self.input.loadDetailForIndex = self.loadDetail(at:)
        self.input.loadData = self.loadData
    }
    
    private func loadData()
    {
        
    }
    
    private func loadDetail(at index: Int)
    {
        
    }
    
    private func loadNextPage()
    {
        
    }
}

extension ListViewModel
{
    enum DataUpdate: Equatable
    {
        case insert([IndexPath])
        case modified([IndexPath])
    }
    
    class Input
    {
        var loadNextPage: VoidClosure?
        var loadDetailForIndex: Closure<Int, Void>?
        var loadData: VoidClosure?
    }
    
    class Output
    {
        var updates: VoidOutputClosure<[DataUpdate]>?
        var error: VoidOutputClosure<String>?
    }
    
    class Navigation
    {
        var requestDetail: VoidOutputClosure<PokemonList.Item>?
    }
}

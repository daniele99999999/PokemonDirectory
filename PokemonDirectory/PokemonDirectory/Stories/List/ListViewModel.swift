//
//  ListViewModel.swift
//  PokemonDirectory
//
//  Created by daniele on 03/10/2020.
//  Copyright © 2020 DeeplyMadStudio. All rights reserved.
//

import Foundation

class ListViewModel
{
    private let repository: RepositoryProtocol
    private let limit: Int
    private var page: Int = 1
    
    private var offset: Int
    {
        self.limit * (self.page - 1)
    }
    private var list: [PokemonList.Item] = []
    
    let input = Input()
    let output = Output()
    let navigation = Navigation()
    
    init(repository: RepositoryProtocol, limit: Int = 20, page: Int = 1)
    {
        self.repository = repository
        self.limit = limit
        self.page = page
        
        self.input.loadNextPage = self.loadNextPage
        self.input.loadDetailForIndex = self.loadDetail(index:)
        self.input.loadData = self.loadData
    }
    
    private func loadData()
    {
        DispatchQueue.main.async
        {
            self.output.title?(NSLocalizedString("list.title", comment: "").uppercased())
        }
        
        self.repository.repoGetList(limit: self.limit,
                                    offset: self.offset)
        { result in
            DispatchQueue.main.async
            {
                switch result
                {
                case .success(let pokemonList):
                        let indexPaths = (self.list.count..<self.list.count + pokemonList.results.count).map
                        {
                            return IndexPath(item: $0, section: 0)
                        }
                        self.list.append(contentsOf: pokemonList.results)
                        self.output.updates?(.insert(indexPaths))
                case .failure(let error):
                    self.output.error?(error.localizedDescription)
                }
            }
        }
    }
    
    private func loadDetail(index: Int)
    {
        let item = list[index]
        DispatchQueue.main.async
        {
            self.navigation.requestDetail?(item)
        }
    }
    
    private func loadNextPage()
    {
        self.page += 1
        self.loadData()
    }
    
    private func viewModel(index: Int) -> ListCellViewModel
    {
        let item = list[index]
        let listCellViewModel = ListCellViewModel(item: item, repository: self.repository)
        return listCellViewModel
    }
}

extension ListViewModel: ListViewDatasourceProvider
{
    var itemsCount: Int
    {
        return self.list.count
    }
    
    func cellViewModel(index: Int) -> ListCellViewModel
    {
        return self.viewModel(index: index)
    }
}

extension ListViewModel
{
    enum DataUpdate: Equatable
    {
        case insert([IndexPath])
        
        var count: Int
        {
            switch self
            {
            case let .insert(indexPaths):
                return indexPaths.count
            }
        }
    }
    
    class Input
    {
        var loadNextPage: VoidClosure?
        var loadDetailForIndex: Closure<Int, Void>?
        var loadData: VoidClosure?
    }
    
    class Output
    {
        var error: VoidOutputClosure<String>?
        var title: VoidOutputClosure<String>?
        var updates: VoidOutputClosure<DataUpdate>?
        var isLastPage: VoidOutputClosure<Bool>? // TODO
    }
    
    class Navigation
    {
        var requestDetail: VoidOutputClosure<PokemonList.Item>?
    }
}

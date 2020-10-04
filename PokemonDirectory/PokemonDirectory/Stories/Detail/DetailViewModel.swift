//
//  DetailViewModel.swift
//  PokemonDirectory
//
//  Created by daniele on 04/10/2020.
//  Copyright © 2020 DeeplyMadStudio. All rights reserved.
//

import Foundation

struct DetailViewModel
{
    private let repository: RepositoryProtocol
    private let url: URL
    private let title: String
    
    let input = Input()
    let output = Output()
    
    init(repository: RepositoryProtocol, item: PokemonList.Item)
    {
        self.repository = repository
        self.url = item.url
        self.title = item.name
        
        self.input.loadData = self.loadData
    }
    
    private func loadData()
    {
        DispatchQueue.main.async
        {
            self.output.isLoading?(true)
            self.output.title?(self.title.uppercased())
            self.output.typologyTitle?(NSLocalizedString("detail.typology.title", comment: ""))
            self.output.statsTitle?(NSLocalizedString("detail.stats.title", comment: ""))
        }
        
        self.repository.repoGetDetail(url: self.url)
        { result in
            DispatchQueue.main.async
            {
                defer { self.output.isLoading?(false) }
                
                switch result
                {
                case .success(let pokemonDetail):
                    let stats = pokemonDetail.stats.map{ "\($0.nameStat): \($0.baseStat)" }
                    self.output.stats?(stats)
                    
                    let types = pokemonDetail.types.map{$0.nameType}
                    self.output.typology?(types)
                    
                    pokemonDetail.sprites.allSprites.enumerated().forEach
                    { index, url in
                        self.loadImage(url: url, index: index)
                    }
                    
                    self.output.name?(pokemonDetail.name)
                case .failure(let error):
                    self.output.error?(error.localizedDescription)
                }
            }
        }
    }
    
    private func loadImage(url: URL, index: Int)
    {
        _ = self.repository.repoGetImage(url: url)
        { result in
            DispatchQueue.main.async
            {
                switch result
                {
                case .success(let imageData):
                    if index == 0
                    {
                        self.output.referenceImage?(imageData)
                    }
                    else
                    {
                        self.output.images?((index, imageData))
                    }
                case .failure(let error):
                    self.output.error?(error.localizedDescription)
                }
            }
        }
    }
}

extension DetailViewModel
{
    class Input
    {
        var loadData: VoidClosure?
    }
    
    class Output
    {
        var isLoading: VoidOutputClosure<Bool>?
        var error: VoidOutputClosure<String>?
        var title: VoidOutputClosure<String>?
        var name: VoidOutputClosure<String>?
        var referenceImage: VoidOutputClosure<Data>?
        var images: VoidOutputClosure<(Int, Data)>?
        var typologyTitle: VoidOutputClosure<String>?
        var typology: VoidOutputClosure<[String]>?
        var statsTitle: VoidOutputClosure<String>?
        var stats: VoidOutputClosure<[String]>?
    }
}


//
//  ListCellViewModel.swift
//  PokemonDirectory
//
//  Created by daniele on 04/10/2020.
//  Copyright © 2020 DeeplyMadStudio. All rights reserved.
//

import Foundation

class ListCellViewModel
{
    private let repository: RepositoryProtocol
    private let url: URL
    private let name: String
    
    private var cancelImageClosure: VoidClosure?
    
    let input = Input()
    let output = Output()
    
    init(item: PokemonList.Item, repository: RepositoryProtocol)
    {
        self.repository = repository
        self.url = item.url
        self.name = item.name
        
        self.input.loadData = self.loadData
        self.input.reset = self.reset
    }

    private func loadData()
    {
        DispatchQueue.main.async
        {
            self.output.name?(self.name)
        }
        
        self.repository.repoGetDetail(url: self.url)
        { result in
            switch result
            {
            case .success(let pokemonDetail):
                self.loadImage(url: pokemonDetail.sprites.iconSprite)
            case .failure(let error):
                DispatchQueue.main.async
                {
                    self.output.error?(error.localizedDescription)
                }
            }
        }
    }
    
    private func loadImage(url: URL)
    {
        self.cancelImageClosure = self.repository.repoGetImage(url: url)
        { result in
            DispatchQueue.main.async
            {
                switch result
                {
                case .success(let imageData):
                    self.output.image?(imageData)
                case .failure(let error):
                    self.output.error?(error.localizedDescription)
                }
            }
        }
    }
    
    private func reset()
    {
        self.cancelDownload()
        DispatchQueue.main.async
        {
            self.output.reset?()
        }
    }
    
    private func cancelDownload()
    {
        self.cancelImageClosure?()
    }
}

extension ListCellViewModel
{
    class Input
    {
        var loadData: VoidClosure?
        var reset: VoidClosure?
    }
    
    class Output
    {
        var error: VoidOutputClosure<String>?
        var reset: VoidClosure?
        var image: VoidOutputClosure<Data>?
        var name: VoidOutputClosure<String>?
    }
}

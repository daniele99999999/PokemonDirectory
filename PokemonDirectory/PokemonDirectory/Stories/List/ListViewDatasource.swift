//
//  ListViewDatasource.swift
//  PokemonDirectory
//
//  Created by daniele on 04/10/2020.
//  Copyright © 2020 DeeplyMadStudio. All rights reserved.
//

import UIKit

protocol ListViewDatasourceProvider
{
    var itemsCount: Int { get }
    func cellViewModel(index: Int) -> ListCellViewModel
}

class DataSource: NSObject
{
    fileprivate let provider: ListViewDatasourceProvider
    
    init(provider: ListViewDatasourceProvider)
    {
        self.provider = provider
    }
}

extension DataSource: UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        self.provider.itemsCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: Resources.Interface.listCellIdentifier, for: indexPath) as! ListCell
        let cellViewModel = self.provider.cellViewModel(index: indexPath.row)
        cell.set(viewModel: cellViewModel)
        return cell
    }
}

extension DataSource
{
    func isLast(index: Int) -> Bool
    {
        return index == (self.provider.itemsCount - 1)
    }
}

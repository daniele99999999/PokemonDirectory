//
//  ListViewController.swift
//  PokemonDirectory
//
//  Created by daniele on 02/10/2020.
//  Copyright © 2020 DeeplyMadStudio. All rights reserved.
//

import UIKit

class ListViewController: UIViewController
{
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityPageIndicator: UIActivityIndicatorView!
    
    fileprivate var viewModel: ListViewModel!
    fileprivate var dataSource: DataSource!
    
    class func createOne(viewModel: ListViewModel) -> ListViewController
    {
        let vc: ListViewController = self.loadFromStoryboard(storyboardName: Resources.Interface.main)
        vc.viewModel = viewModel
        vc.dataSource = DataSource(provider: viewModel)
        return vc
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.setupUI()
        self.setupBindings()
        
        self.viewModel.input.loadData?()
    }
}

private extension ListViewController
{
    private func setupUI()
    {
        self.view.backgroundColor = .white
        
        self.tableView.dataSource = dataSource
        self.tableView.delegate = self
        self.tableView.contentInset = .init(top: 0, left: 0, bottom: 100, right: 0)
        self.activityPageIndicator.startAnimating()
    }
    
    private func setupBindings()
    {
        self.viewModel.output.error = { error in
            print("error: \(error)")
            // TODO gestire l'eventuale alert a schermo
        }
        
        self.viewModel.output.title = { [weak self] title in
            self?.navigationItem.title = title
            self?.view.setNeedsLayout()
        }
        
        self.viewModel.output.updates = { [weak self] updates in
            self?.tableView.beginUpdates()
            switch updates
            {
            case .insert(let indexPaths):
                self?.tableView.insertRows(at: indexPaths, with: .fade)
            }
            self?.tableView.endUpdates()
            self?.view.setNeedsLayout()
        }
        
        self.viewModel.output.isLastPage = { [weak self] isLastPage in
            // TODO
            self?.view.setNeedsLayout()
        }
    }
}

extension ListViewController: UITableViewDelegate
{
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath)
    {
        guard self.dataSource.isLast(index: indexPath.row) else { return }
            
        // Added fake delay for show activity
        DispatchQueue.main.asyncAfter(deadline: .now() + 1)
        { [weak self] in
            self?.viewModel.input.loadNextPage?()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        self.viewModel.input.loadDetailForIndex?(indexPath.row)
    }
}

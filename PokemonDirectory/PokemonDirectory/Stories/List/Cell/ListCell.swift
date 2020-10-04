//
//  ListCell.swift
//  PokemonDirectory
//
//  Created by daniele on 04/10/2020.
//  Copyright © 2020 DeeplyMadStudio. All rights reserved.
//

import UIKit

final class ListCell: UITableViewCell
{
    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var itemTitleLabel: UILabel!
 
    private var viewModel: ListCellViewModel?
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        
        self.setupUI()
    }
    
    override func prepareForReuse()
    {
        super.prepareForReuse()
        
        self.viewModel?.input.reset?()
    }
    
    func set(viewModel: ListCellViewModel)
    {
        self.viewModel = viewModel
        self.setupBindings()
        self.viewModel?.input.loadData?()
    }
}

private extension ListCell
{
    private func setupUI()
    {
        self.contentView.backgroundColor = .white
    }
    
    private func setupBindings()
    {
        self.viewModel?.output.error = { error in
            print("error: \(error)")
            // TODO gestire l'eventuale alert a schermo
        }
        
        self.viewModel?.output.reset = { [weak self] in
            self?.itemTitleLabel.text = nil
            self?.itemImageView.image = nil
            self?.setNeedsLayout()
            self?.setNeedsDisplay()
        }
        
        self.viewModel?.output.image = { [weak self] imageData in
            self?.imageView?.image = UIImage(data: imageData)
            self?.setNeedsLayout()
            self?.setNeedsDisplay()
        }
        
        self.viewModel?.output.name = { [weak self] name in
            self?.itemTitleLabel.text = name
            self?.setNeedsDisplay()
        }
    }
}

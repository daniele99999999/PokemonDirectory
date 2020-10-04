//
//  DetailViewController.swift
//  PokemonDirectory
//
//  Created by daniele on 02/10/2020.
//  Copyright © 2020 DeeplyMadStudio. All rights reserved.
//

import UIKit

class DetailViewController: BaseViewController
{
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var referenceImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imagesContainerStackView: UIStackView!
    @IBOutlet weak var typologyTitleLabel: UILabel!
    @IBOutlet weak var typologyLabel: UILabel!
    @IBOutlet weak var statsTitleLabel: UILabel!
    @IBOutlet weak var statsLabel: UILabel!
    
    fileprivate var viewModel: DetailViewModel!
    
    class func createOne(viewModel: DetailViewModel) -> DetailViewController
    {
        let vc: DetailViewController = self.loadFromStoryboard(storyboardName: Resources.Storyboards.main)
        vc.viewModel = viewModel
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

private extension DetailViewController
{
    private func setupUI()
    {
        self.view.backgroundColor = .white
    }
    
    private func setupBindings()
    {
        self.viewModel.output.isLoading = { [weak self] isLoading in
            if isLoading
            {
                self?.activityIndicator.startAnimating()
            }
            else
            {
                self?.activityIndicator.stopAnimating()
            }
        }
        
        self.viewModel.output.error = { error in
            print("error: \(error)")
            // TODO gestire l'eventuale alert a schermo
        }
        
        self.viewModel.output.title = { [weak self] title in
            self?.navigationItem.title = title
        }
        
        self.viewModel.output.name = { [weak self] name in
            self?.nameLabel.text = name
        }
        
        self.viewModel.output.referenceImage = { [weak self] data in
            self?.referenceImageView.image = UIImage(data: data)
        }
        
        self.viewModel.output.images = { [weak self] item in
            let imageData = UIImage(data: item.1)
            let imageView = UIImageView(image: imageData)
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.contentMode = .scaleAspectFit
            imageView.clipsToBounds = true
            self?.imagesContainerStackView.addArrangedSubview(imageView)
        }

        self.viewModel.output.statsTitle = { [weak self] title in
            self?.statsTitleLabel.text = title
        }
        
        self.viewModel.output.stats = { [weak self] stats in
            self?.statsLabel.text = stats.joined(separator: "\n")
        }

        self.viewModel.output.typologyTitle = { [weak self] title in
            self?.typologyTitleLabel.text = title
        }
        
        self.viewModel.output.typology = { [weak self] typology in
            self?.typologyLabel.text = typology.joined(separator: "\n")
        }
    }
}

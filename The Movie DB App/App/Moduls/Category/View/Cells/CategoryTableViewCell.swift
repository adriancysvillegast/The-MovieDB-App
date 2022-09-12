//
//  CategoryTableViewCell.swift
//  The Movie DB App
//
//  Created by Adriancys Jesus Villegas Toro on 10/9/22.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {

    // MARK: - properties
    
    let identifier = "CategoryTableViewCell"
    
    private lazy var containerView: UIView = {
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        return containerView
    }()
    
    private lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.textColor = .black
        nameLabel.textAlignment = .left
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        return nameLabel
    }()
    
    // MARK: - setupView
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = UIColor(named: Constants.ColorBackground.viewBackControllers)
        addSubview(containerView)
        containerView.addSubview(nameLabel)
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 5),
            nameLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 5),
            nameLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -5),
            nameLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -5)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - configureCell
    func configureCell(model: GenreMovieListResponse) {
        self.nameLabel.text = model.name
    }
}

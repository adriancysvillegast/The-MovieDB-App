//
//  InfoCollectionViewCell.swift
//  The Movie DB App
//
//  Created by Adriancys Jesus Villegas Toro on 17/8/22.
//

import UIKit

class InfoCollectionViewCell: UICollectionViewCell {
    //MARK: - properties
    let identifier = "InfoCollectionViewCell"
    private let baseImage = ProcessInfo.processInfo.environment["baseImage"]!
    lazy var aView: UIView = {
       let view = UIView()
        view.backgroundColor = UIColor(named: Constants.ColorBackground.viewBackColorCell)
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 20
        imageView.image = UIImage(systemName: "photo")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var nameMovie: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.textColor = .white
        label.textAlignment = .left
        label.numberOfLines = 4
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .light)
        label.textAlignment = .justified
        label.textColor = .white
        label.numberOfLines = 4
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var releaseDate: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .light)
        label.textAlignment = .justified
        label.textColor = .white
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    //MARK: - setupView
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(aView)
        [imageView, nameMovie, descriptionLabel, releaseDate].forEach {
            aView.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            aView.topAnchor.constraint(equalTo: topAnchor),
            aView.leadingAnchor.constraint(equalTo: leadingAnchor),
            aView.trailingAnchor.constraint(equalTo: trailingAnchor),
            aView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            imageView.topAnchor.constraint(equalTo: aView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: aView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: aView.trailingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 250),
            
            nameMovie.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 5),
            nameMovie.leadingAnchor.constraint(equalTo: aView.leadingAnchor, constant: 5),
            nameMovie.trailingAnchor.constraint(equalTo: aView.trailingAnchor, constant: -5),
            
            releaseDate.topAnchor.constraint(equalTo: nameMovie.bottomAnchor, constant: 5),
            releaseDate.leadingAnchor.constraint(equalTo: aView.leadingAnchor, constant: 5),
            
            descriptionLabel.topAnchor.constraint(equalTo: releaseDate.bottomAnchor, constant: 5),
            descriptionLabel.leadingAnchor.constraint(equalTo: aView.leadingAnchor, constant: 5),
            descriptionLabel.trailingAnchor.constraint(equalTo: aView.trailingAnchor, constant: -5),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - configureCells
    
    func configureMovieCell(model: MovieResponse) {
        guard let imagePath = model.posterPath else { return }
        guard let imageURL = URL(string:"\(baseImage)\(imagePath)") else { return }
        self.imageView.loadImage(at: imageURL)
        self.nameMovie.text = model.originalTitle
        self.descriptionLabel.text = model.overview
        self.releaseDate.text = model.releaseDate
    }
    
    //Recive data from coreData
    func configureMovieDB(model: MovieModel) {
        guard let imageData = model.imageData else { return }
        self.imageView.image = UIImage(data: imageData)
        self.nameMovie.text = model.originalTitle
        self.descriptionLabel.text = model.overview
        self.releaseDate.text = model.releaseDate
    }
    
    func configureTVCell(model: TVShowResponse) {
        guard let imagePath = model.posterPath else { return }
        guard let imageURL = URL(string:"\(baseImage)\(imagePath)") else { return }
        self.imageView.loadImage(at: imageURL)
        self.nameMovie.text = model.originalName
        self.releaseDate.text = model.firstAirDate
        self.descriptionLabel.text = model.overview
    }
}

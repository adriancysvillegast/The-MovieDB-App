//
//  ImageCollectionViewCell.swift
//  The Movie DB App
//
//  Created by Adriancys Jesus Villegas Toro on 18/8/22.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    //MARK: - properties
    let identifier = "ImageCollectionViewCell"
    private let baseImage = ProcessInfo.processInfo.environment["baseImage"]!
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 0
        imageView.image = UIImage(systemName: "photo")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    //MARK: - setupView
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        [imageView].forEach {
            addSubview($0)
        }

        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(model: CompaniesResponse) {
        guard let link = model.logoPath else { return }
        guard let url = URL(string: "\(baseImage)\(link)") else { return }
        self.imageView.loadImage(at: url)
    }
}

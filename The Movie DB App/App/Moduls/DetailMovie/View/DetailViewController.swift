//
//  DetailViewController.swift
//  The Movie DB App
//
//  Created by Adriancys Jesus Villegas Toro on 17/8/22.
//

import UIKit

class DetailViewController: UIViewController {
    
    //MARK: - Properties
    
    var idObject: Int?
    
    lazy var contentSize = CGSize(width: view.frame.size.width, height: 1100)
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = UIColor(named: Constants.ColorBackground.viewBackControllers)
        scrollView.contentSize = contentSize
        scrollView.frame = self.view.bounds
        scrollView.autoresizingMask = .flexibleHeight
        scrollView.showsHorizontalScrollIndicator = true
        scrollView.bounces = true
        return scrollView
    }()
    
    private lazy var containerView: UIView = {
        let aView = UIView()
        aView.backgroundColor = UIColor(named: Constants.ColorBackground.viewBackControllers)
        aView.frame.size = contentSize
        return aView
    }()
    
    private lazy var viewModel: DetailViewModel = {
        let viewModel = DetailViewModel()
        viewModel.delegate = self
        viewModel.delegateSpinner = self
        viewModel.delegateError = self
        return viewModel
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = .white
        label.numberOfLines = 5
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var imageView : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 20
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 15, weight: .light)
        label.textAlignment = .justified
        label.numberOfLines = 80
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var adultLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = "Adult:"
        label.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var adultValue: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 15, weight: .light)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var genreLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = "Genre:"
        label.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var genreValue: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 15, weight: .light)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var lenguageLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = "Lenguage:"
        label.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var lenguageValue: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 15, weight: .light)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var popularityLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = "Popularity:"
        label.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var popularityValue: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 15, weight: .light)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var releaseLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = "Release Date:"
        label.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var releaseValue: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 15, weight: .light)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var productCompanies: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = .white
        label.text = "Production Companies"
        label.numberOfLines = 1
        label.textAlignment = .center
        label.baselineAdjustment = .alignBaselines
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var aCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(ImageCollectionViewCell.self, forCellWithReuseIdentifier: ImageCollectionViewCell().identifier)
        collectionView.backgroundColor = UIColor(named: Constants.ColorBackground.viewBackControllers)
        collectionView.showsHorizontalScrollIndicator = true
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private lazy var spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        spinner.style = .medium
        spinner.color = .white
        spinner.isHidden = true
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    }()
    
    private lazy var addFavorite: UIBarButtonItem = {
        let button = UIBarButtonItem(image: UIImage(systemName: "star"), style: .done, target: self, action: #selector(saveMovie))
        return button
    }()
    
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraints()
        viewModel.getdetails(idMovie: idObject)
        
//        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
    }
    
    //MARK: - SetupView
    
    private func setupView() {
        view.backgroundColor = UIColor(named: Constants.ColorBackground.viewBackControllers)
        self.navigationItem.rightBarButtonItem = addFavorite
        view.addSubview(scrollView)
        scrollView.addSubview(containerView)
        
        [imageView, titleLabel, descriptionLabel, adultLabel, adultValue, genreLabel, genreValue, lenguageLabel, lenguageValue, popularityLabel, popularityValue, releaseLabel, releaseValue,productCompanies,  aCollectionView, spinner].forEach {
            containerView.addSubview($0)
        }
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.trailingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 290),
            
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.trailingAnchor, constant: -15),
            titleLabel.heightAnchor.constraint(equalToConstant: 50),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            descriptionLabel.leadingAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            descriptionLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 60),
            
            adultLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 10),
            adultLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            
            adultValue.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 10),
            adultValue.leadingAnchor.constraint(equalTo: adultLabel.trailingAnchor, constant: 2),
            
            genreLabel.topAnchor.constraint(equalTo: adultLabel.bottomAnchor, constant: 10),
            genreLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            
            genreValue.topAnchor.constraint(equalTo: adultValue.bottomAnchor, constant: 10),
            genreValue.leadingAnchor.constraint(equalTo: genreLabel.trailingAnchor, constant: 2),
            
            lenguageLabel.topAnchor.constraint(equalTo: genreLabel.bottomAnchor, constant: 10),
            lenguageLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            
            lenguageValue.topAnchor.constraint(equalTo: genreValue.bottomAnchor, constant: 10),
            lenguageValue.leadingAnchor.constraint(equalTo: lenguageLabel.trailingAnchor, constant: 2),
            
            popularityLabel.topAnchor.constraint(equalTo: lenguageLabel.bottomAnchor, constant: 10),
            popularityLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            
            popularityValue.topAnchor.constraint(equalTo: lenguageValue.bottomAnchor, constant: 10),
            popularityValue.leadingAnchor.constraint(equalTo: popularityLabel.trailingAnchor, constant: 2),
            
            releaseLabel.topAnchor.constraint(equalTo: popularityLabel.bottomAnchor, constant: 10),
            releaseLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            
            releaseValue.topAnchor.constraint(equalTo: popularityValue.bottomAnchor, constant: 10),
            releaseValue.leadingAnchor.constraint(equalTo: releaseLabel.trailingAnchor, constant: 2),
            
            
            productCompanies.topAnchor.constraint(equalTo: releaseLabel.bottomAnchor, constant: 20),
            productCompanies.leadingAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            
            aCollectionView.topAnchor.constraint(equalTo: productCompanies.bottomAnchor, constant: 10),
            aCollectionView.leadingAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            aCollectionView.trailingAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            aCollectionView.heightAnchor.constraint(equalToConstant: 250),
            
//            aCollectionView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -10),
            
            spinner.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
        ])
    }
    
    //MARK: - Add target and acctions
    
    @objc func saveMovie() {
        viewModel.saveMovie()
    }
    
}

//MARK: - DetailViewModelDelegate

extension DetailViewController: DetailViewModelDelegate {
    func updateView(data: DetailModel) {
        DispatchQueue.main.async {
            guard let image = data.posterPath else { return }
            self.titleLabel.text = data.originalTitle
            self.descriptionLabel.text = data.overview
            self.adultValue.text = String(describing: data.adult)
            self.genreValue.text = data.genres.joined(separator: ",")
            self.lenguageValue.text = data.originalLanguage
            self.popularityValue.text = String(data.popularity)
            self.releaseValue.text = data.releaseDate
            self.imageView.load(url: image)
        }
    }
}

//MARK: - SpinnerLoadDelegate

extension DetailViewController: SpinnerLoadDelegate {
    func showSpinner() {
        DispatchQueue.main.async{
            self.spinner.isHidden = false
            self.spinner.startAnimating()
        }
    }
    
    func hideSpinner() {
        DispatchQueue.main.async {
            self.spinner.isHidden = true
            self.spinner.stopAnimating()
        }
    }
}

//MARK: - ShowErrorDelegate

extension DetailViewController: ShowErrorDelegate {
    func showError(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel))
        present(alert, animated: true)
    }
}

//MARK: - UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout

extension  DetailViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.companiesCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCollectionViewCell().identifier, for: indexPath) as? ImageCollectionViewCell  else { return UICollectionViewCell() }
        cell.configureCell(model: viewModel.showCompaniesData(index: indexPath.row))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width/3.5, height: view.frame.height/1.2)
    }
    
}

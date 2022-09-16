//
//  ProfileViewController.swift
//  The Movie DB App
//
//  Created by Adriancys Jesus Villegas Toro on 18/8/22.
//

import UIKit

class ProfileViewController: UIViewController {

    //MARK: - Properties
    
    private lazy var viewModel: ProfileViewModel = {
        let viewModel = ProfileViewModel()
        viewModel.delegate = self
        viewModel.delegateSpinner = self
        viewModel.delegateError = self
        return viewModel
    }()
    
    lazy var contentSize = CGSize(width: view.frame.size.width, height: 1200)
    
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
    
    private lazy var welcome: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textColor = .white
        label.numberOfLines = 5
        label.text = "Welcome to MovieDB,"
        label.textAlignment = .center
        label.baselineAdjustment = .alignBaselines
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var nameUser: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textColor = .white
        label.numberOfLines = 5
        label.textAlignment = .center
        label.baselineAdjustment = .alignBaselines
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var favoriteMovie: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = .white
        label.text = "Favorite Movies"
        label.numberOfLines = 1
        label.textAlignment = .left
        label.baselineAdjustment = .alignBaselines
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var aCollectionViewMovie: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(InfoCollectionViewCell.self, forCellWithReuseIdentifier: InfoCollectionViewCell().identifier)
        collectionView.backgroundColor = UIColor(named: Constants.ColorBackground.viewBackControllers)
        collectionView.showsHorizontalScrollIndicator = true
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private lazy var favoriteTVShow: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = .white
        label.text = "Favorite TV Shows"
        label.numberOfLines = 1
        label.textAlignment = .left
        label.baselineAdjustment = .alignBaselines
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var aCollectionViewTV: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(InfoCollectionViewCell.self, forCellWithReuseIdentifier: InfoCollectionViewCell().identifier)
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
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        setupView()
        setupConstraints()
        viewModel.getUserName()
        viewModel.getMoviesFavorite()
        viewModel.getTVShowFavorite()
    }
    //MARK: - setUpView
    
    private func setupView() {
        view.backgroundColor = UIColor(named: Constants.ColorBackground.viewBackControllers)
        
        view.addSubview(scrollView)
        scrollView.addSubview(containerView)
        
        [welcome, nameUser, favoriteMovie, aCollectionViewMovie, favoriteTVShow, aCollectionViewTV].forEach {
            containerView.addSubview($0)
        }
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            welcome.topAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.topAnchor, constant: 20),
            welcome.leadingAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            
            nameUser.topAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.topAnchor, constant: 20),
            nameUser.leadingAnchor.constraint(equalTo: welcome.trailingAnchor, constant: 5),
            nameUser.trailingAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            favoriteMovie.topAnchor.constraint(equalTo: nameUser.bottomAnchor, constant: 30),
            favoriteMovie.leadingAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            favoriteMovie.trailingAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            aCollectionViewMovie.topAnchor.constraint(equalTo: favoriteMovie.bottomAnchor, constant: 5),
            aCollectionViewMovie.leadingAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            aCollectionViewMovie.trailingAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            
            aCollectionViewMovie.heightAnchor.constraint(equalToConstant: 500),
            
            favoriteTVShow.topAnchor.constraint(equalTo: aCollectionViewMovie.bottomAnchor, constant: 30),
            favoriteTVShow.leadingAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            favoriteTVShow.trailingAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            aCollectionViewTV.topAnchor.constraint(equalTo: favoriteTVShow.bottomAnchor, constant: 5),
            aCollectionViewTV.leadingAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            aCollectionViewTV.trailingAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            aCollectionViewTV.heightAnchor.constraint(equalToConstant: 500),
        ])
    }
    
}

//MARK: - ProfileViewModelDelegate

extension ProfileViewController: ProfileViewModelDelegate {
    func hideMovieProperties() {
        self.favoriteMovie.isHidden = true
        self.aCollectionViewMovie.isHidden = true
    }
    
    func reloadTVCollection() {
        DispatchQueue.main.async {
            self.aCollectionViewTV.reloadData()
        }
    }
    
    func reloadMovieCollection() {
        DispatchQueue.main.async {
            self.aCollectionViewMovie.reloadData()
        }
    }
    
    func hideTVProperties() {
        self.favoriteTVShow.isHidden = true
        self.aCollectionViewTV.isHidden = true
    }
    
    func updateName(name: String?) {
        self.nameUser.text = name ?? "" 
    }
}

//MARK: - SpinnerLoadDelegate

extension ProfileViewController: SpinnerLoadDelegate {
    func showSpinner() {
        spinner.isHidden = false
        spinner.startAnimating()
    }
    
    func hideSpinner() {
        spinner.isHidden = true
        spinner.stopAnimating()
    }
}

//MARK: - SpinnerLoadDelegate

extension ProfileViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout  {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == aCollectionViewMovie {
            return viewModel.getMovieCount()
        }
        return viewModel.getTVShowCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: InfoCollectionViewCell().identifier, for: indexPath) as? InfoCollectionViewCell else { return UICollectionViewCell() }
        if collectionView == aCollectionViewMovie {
            let movie = viewModel.getMovieData(index: indexPath.row)
            cell.configureMovieDB(model: movie)
        }else{
            let tv = viewModel.getTVShowData(index: indexPath.row)
            cell.configureTVShowDB(model: tv)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width/2.2, height: view.frame.height/2)
    }
}

//MARK: - SpinnerLoadDelegate

extension ProfileViewController: ShowErrorDelegate {
    func showError(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel))
        present(alert, animated: true)
    }
}

//
//  MovieViewController.swift
//  The Movie DB App
//
//  Created by Adriancys Jesus Villegas Toro on 17/8/22.
//

import UIKit

class MovieViewController: UIViewController {
    
    //MARK: - Properties

    private lazy var viewModel: MovieViewModel = {
        let viewModel = MovieViewModel()
        viewModel.delegate = self
        viewModel.delegateError = self
        viewModel.delegateSpinner = self
        return viewModel
    }()
    
    lazy var contentSize = CGSize(width: view.frame.size.width, height: 1700)
    
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
    
    private lazy var aImageView: UIImageView = {
        let aImageView = UIImageView()
        aImageView.contentMode = .scaleAspectFit
        aImageView.image = UIImage(systemName: Constants.ImageDefault.image)
        aImageView.translatesAutoresizingMaskIntoConstraints = false
        return aImageView
    }()
    
    private lazy var topRateLabel: UILabel = {
        let label = UILabel()
        label.text = "Top Rate"
        label.font = UIFont.systemFont(ofSize: 20, weight: .heavy)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var aCollectionViewTR: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(InfoCollectionViewCell.self, forCellWithReuseIdentifier: InfoCollectionViewCell().identifier)
        collectionView.showsHorizontalScrollIndicator = true
        collectionView.backgroundColor = UIColor(named: Constants.ColorBackground.viewBackControllers)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private lazy var popularLabel: UILabel = {
        let label = UILabel()
        label.text = "Popular Movies"
        label.font = UIFont.systemFont(ofSize: 20, weight: .heavy)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var aCollectionViewPM: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(InfoCollectionViewCell.self, forCellWithReuseIdentifier: InfoCollectionViewCell().identifier)
        collectionView.showsHorizontalScrollIndicator = true
        collectionView.backgroundColor = UIColor(named: Constants.ColorBackground.viewBackControllers)
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
        super.viewDidLoad()
        setupView()
        setupConstraints()
        viewModel.getTopRateMovies()
        viewModel.getLastMovie()
        viewModel.getPopularMovie()
    }

    //MARK: - SetupView
    
    private func setupView() {
        
        view.backgroundColor = UIColor(named: Constants.ColorBackground.viewBackControllers)
        view.addSubview(scrollView)
        scrollView.addSubview(containerView)
        [aImageView, topRateLabel, aCollectionViewTR, popularLabel, aCollectionViewPM, spinner].forEach {
            containerView.addSubview($0)
        }
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            aImageView.topAnchor.constraint(equalTo: containerView.topAnchor),
            aImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            aImageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            aImageView.heightAnchor.constraint(equalToConstant: 600),
            
            topRateLabel.topAnchor.constraint(equalTo: aImageView.bottomAnchor, constant: 5),
            topRateLabel.leadingAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide
                .leadingAnchor, constant: 10),
            
            aCollectionViewTR.topAnchor.constraint(equalTo: topRateLabel.bottomAnchor),
            aCollectionViewTR.leadingAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            aCollectionViewTR.trailingAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            aCollectionViewTR.heightAnchor.constraint(equalToConstant: 500),
         
            popularLabel.topAnchor.constraint(equalTo: aCollectionViewTR.bottomAnchor, constant: 5),
            popularLabel.leadingAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            popularLabel.trailingAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            
            aCollectionViewPM.topAnchor.constraint(equalTo: popularLabel.bottomAnchor),
            aCollectionViewPM.leadingAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            aCollectionViewPM.trailingAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            aCollectionViewPM.heightAnchor.constraint(equalToConstant: 500),
            
            spinner.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
        ])
    }
    
// MARK: - add targets
    
    
}
//MARK: - UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout

extension  MovieViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == aCollectionViewTR {
            return viewModel.getTopRateMovieCount()
        }
        
        return viewModel.popularMoviesCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: InfoCollectionViewCell().identifier, for: indexPath) as? InfoCollectionViewCell else { return UICollectionViewCell() }
        if collectionView == aCollectionViewTR {
            cell.configureTopRateMovieCell(model: viewModel.getTopRateMovieData(index: indexPath.row))
        } else {
            cell.configurePopularMovieCell(model: viewModel.getPopularMovieData(index: indexPath.row))
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width/2.2, height: view.frame.height/2)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == aCollectionViewTR {
            let detailVC = MovieDetailViewController()
            detailVC.idObject = viewModel.getTopRateMovieData(index: indexPath.row).id
            self.navigationController?.pushViewController(detailVC, animated: true)
        }else {
            let detailVC = MovieDetailViewController()
            detailVC.idObject = viewModel.getPopularMovieData(index: indexPath.row).id
            self.navigationController?.pushViewController(detailVC, animated: true)
        }
        
    }
    
}
//MARK: - MovieViewModelDelegate

extension MovieViewController: MovieViewModelDelegate {
    func updatePopularCollection() {
        DispatchQueue.main.async {
            self.aCollectionViewPM.reloadData()
        }
    }
    
    func updateLastMovie(url: URL) {
        DispatchQueue.main.async {
            self.aImageView.loadImage(at: url)
        }
    }
    
    func updateTopRateCollection() {
        DispatchQueue.main.async {
            self.aCollectionViewTR.reloadData()
        }
    }
}

//MARK: - ShowErrorDelegate

extension MovieViewController: ShowErrorDelegate {
    func showError(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let acction = UIAlertAction(title: "Try agrain!", style: .default) { _ in
            self.viewModel.getTopRateMovies()
        }
        alert.addAction(acction)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel))
        present(alert, animated: true)
    }

}

//MARK: - SpinnerLoadDelegate

extension MovieViewController: SpinnerLoadDelegate {
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

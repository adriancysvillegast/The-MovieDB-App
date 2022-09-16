//
//  TVViewController.swift
//  The Movie DB App
//
//  Created by Adriancys Jesus Villegas Toro on 17/8/22.
//

import UIKit

class TVViewController: UIViewController {
    
    //MARK: - Properties
    
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
    
    private lazy var viewModel: TVViewModel = {
        let viewModel = TVViewModel()
        viewModel.delegate = self
        viewModel.delegateSpinner = self
        viewModel.delegateError = self
        return viewModel
    }()
    
    private lazy var aImageView: UIImageView = {
        let aImageView = UIImageView()
        aImageView.contentMode = .scaleAspectFit
        aImageView.image = UIImage(systemName: Constants.ImageDefault.image)
        aImageView.translatesAutoresizingMaskIntoConstraints = false
        return aImageView
    }()
    
    private lazy var popularLabel: UILabel = {
        let label = UILabel()
        label.text = "Popular TV Shows"
        label.font = UIFont.systemFont(ofSize: 20, weight: .heavy)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var aCollectionViewPopular: UICollectionView = {
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
    
    private lazy var topRateLabel: UILabel = {
        let label = UILabel()
        label.text = "Top Rate TV Shows"
        label.font = UIFont.systemFont(ofSize: 20, weight: .heavy)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var aCollectionViewTopRate: UICollectionView = {
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
        viewModel.getPopularTVShows()
        viewModel.getTopRateTVShows()
        viewModel.getLastTVShow()
    }
    
    //MARK: - setupView
    
    private func setupView() {
        view.backgroundColor = UIColor(named: Constants.ColorBackground.viewBackControllers)
        view.addSubview(scrollView)
        scrollView.addSubview(containerView)
        [aImageView, popularLabel, aCollectionViewPopular, topRateLabel, aCollectionViewTopRate, spinner].forEach {
            containerView.addSubview($0)
        }
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            
            aImageView.topAnchor.constraint(equalTo: containerView.topAnchor),
            aImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            aImageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            aImageView.heightAnchor.constraint(equalToConstant: 600),
            
            popularLabel.topAnchor.constraint(equalTo: aImageView.bottomAnchor, constant: 5),
            popularLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
            popularLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10),
            
            aCollectionViewPopular.topAnchor.constraint(equalTo: popularLabel.bottomAnchor),
            aCollectionViewPopular.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            aCollectionViewPopular.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            aCollectionViewPopular.heightAnchor.constraint(equalToConstant: 500),
            
            topRateLabel.topAnchor.constraint(equalTo: aCollectionViewPopular.bottomAnchor, constant: 10),
            topRateLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
            topRateLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10),
            
            aCollectionViewTopRate.topAnchor.constraint(equalTo: topRateLabel.bottomAnchor),
            aCollectionViewTopRate.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
            aCollectionViewTopRate.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10),
            aCollectionViewTopRate.heightAnchor.constraint(equalToConstant: 500),
            
            spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }

}

//MARK: - UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout

extension TVViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == aCollectionViewPopular{
            return viewModel.getPopularCount()
        }
        return viewModel.getTopRateCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: InfoCollectionViewCell().identifier, for: indexPath) as? InfoCollectionViewCell else { return UICollectionViewCell() }
        if collectionView == aCollectionViewPopular {
            let tvShow = viewModel.getPopularData(index: indexPath.row)
            cell.configureTVCell(model: tvShow)
        }else{
            let tvShow = viewModel.getTopRateData(index: indexPath.row)
            cell.configurePopularMovieCell(model: tvShow)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width/2.2, height: view.frame.height/2)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == aCollectionViewPopular{
            let tvDetailController = TVDetailViewController()
            tvDetailController.idObject = viewModel.getPopularData(index: indexPath.row).id
            self.navigationController?.pushViewController(tvDetailController, animated: true)
        }else{
            let tvDetailController = TVDetailViewController()
            tvDetailController.idObject = viewModel.getTopRateData(index: indexPath.row).id
            self.navigationController?.pushViewController(tvDetailController, animated: true)
        }
        
    }
    
}

//MARK: - TVViewModelDelegate

extension TVViewController: TVViewModelDelegate {
    func updateTopRateCollection() {
        DispatchQueue.main.async {
            self.aCollectionViewTopRate.reloadData()
        }
    }
    
    func updateLastShow(url: URL) {
        DispatchQueue.main.async {
            self.aImageView.loadImage(at: url)
        }
    }
    
    func updatePopularCollection() {
        DispatchQueue.main.async {
            self.aCollectionViewPopular.reloadData()
        }
    }
}

//MARK: - SpinnerLoadDelegate

extension TVViewController: SpinnerLoadDelegate {
    func showSpinner() {
        DispatchQueue.main.async {
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

//MARK: - Section Heading

extension TVViewController: ShowErrorDelegate {
    func showError(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Try Again", style: .default) { _ in
            self.viewModel.getPopularTVShows()
            self.viewModel.getTopRateTVShows()
            self.viewModel.getLastTVShow()
        }
        alert.addAction(action)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel))
        present(alert, animated: true)
    }
    
    
}

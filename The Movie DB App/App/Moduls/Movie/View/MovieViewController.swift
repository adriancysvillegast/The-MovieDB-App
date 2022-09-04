//
//  MovieViewController.swift
//  The Movie DB App
//
//  Created by Adriancys Jesus Villegas Toro on 17/8/22.
//

import UIKit

class MovieViewController: UIViewController {
    
    //MARK: - Properties
    let userRepository = UserRepository()
    
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
    
    private lazy var aCollectionView: UICollectionView = {
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
    
    private lazy var profileBotton: UIBarButtonItem = {
        let button = UIBarButtonItem(image: UIImage(systemName: "person"), style: .done, target: self, action: #selector(goToProfile))
        return button
    }()
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraints()
        viewModel.getLastMovie()
        viewModel.getMovies()
    }

    //MARK: - SetupView
    
    private func setupView() {
        self.navigationItem.rightBarButtonItem = profileBotton
        view.backgroundColor = UIColor(named: Constants.ColorBackground.viewBackControllers)
        view.addSubview(scrollView)
        scrollView.addSubview(containerView)
        [aCollectionView, topRateLabel, aImageView, spinner].forEach {
            containerView.addSubview($0)
        }
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            aImageView.topAnchor.constraint(equalTo: containerView.topAnchor),
            aImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            aImageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            aImageView.heightAnchor.constraint(equalToConstant: 600),
            
            topRateLabel.topAnchor.constraint(equalTo: aImageView.bottomAnchor, constant: 10),
            topRateLabel.leadingAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide
                .leadingAnchor, constant: 10),
            
            aCollectionView.topAnchor.constraint(equalTo: topRateLabel.bottomAnchor, constant: 5),
            aCollectionView.leadingAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            aCollectionView.trailingAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            aCollectionView.heightAnchor.constraint(equalToConstant: 500),
         
            spinner.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
        ])
    }
    
// MARK: - add targets
    
    @objc func goToProfile() {
        
        let alert = UIAlertController(title: "What do you want to do?", message: "", preferredStyle: .actionSheet)
        let navigateProfile = UIAlertAction(title: "View Profile", style: .default) { _ in
            let vc = ProfileViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        let navigateHome = UIAlertAction(title: "Log Out", style: .default) { _ in
            self.userRepository.logOut()
            let vc = LogInViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(navigateProfile)
        alert.addAction(navigateHome)
        alert.addAction(cancel)
        present(alert, animated: true)
    }
    
}
//MARK: - UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout

extension  MovieViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.getMovieCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: InfoCollectionViewCell().identifier, for: indexPath) as? InfoCollectionViewCell else { return UICollectionViewCell() }
        cell.configureMovieCell(model: viewModel.getMovieData(index: indexPath.row))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width/2.2, height: view.frame.height/2)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailVC = DetailViewController()
        detailVC.idObject = viewModel.getMovieData(index: indexPath.row).id
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    
}
//MARK: - MovieViewModelDelegate

extension MovieViewController: MovieViewModelDelegate {
    func updateLastMovie(url: URL) {
        DispatchQueue.main.async {
            self.aImageView.loadImage(at: url)
        }
    }
    
    func updateView() {
        DispatchQueue.main.async {
            self.aCollectionView.reloadData()
        }
    }
}

//MARK: - ShowErrorDelegate

extension MovieViewController: ShowErrorDelegate {
    func showError(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let acction = UIAlertAction(title: "Try agrain!", style: .default) { _ in
            self.viewModel.getMovies()
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

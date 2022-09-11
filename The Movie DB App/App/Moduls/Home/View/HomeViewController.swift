//
//  HomeViewController.swift
//  The Movie DB App
//
//  Created by Adriancys Jesus Villegas Toro on 8/9/22.
//

import UIKit

class HomeViewController: UIViewController {
    
    // MARK: - Properties
    
    lazy var contentSize = CGSize(width: view.frame.size.width, height: 2800)
    
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
    
    private lazy var viewModel: HomeViewModel = {
        let viewModel = HomeViewModel()
        viewModel.delegate = self
        viewModel.delegateError = self
        return viewModel
    }()
    
    //Menu properties
    private lazy var movieButton: UIButton = {
        let movieButton = UIButton()
        movieButton.setTitle("Movies", for: .normal)
        movieButton.setTitleColor(UIColor.white, for: .normal)
        movieButton.translatesAutoresizingMaskIntoConstraints =  false
        return movieButton
    }()
    
    private lazy var TVShowButton: UIButton = {
        let movieButton = UIButton()
        movieButton.setTitle("TV Shows", for: .normal)
        movieButton.setTitleColor(UIColor.white, for: .normal)
        movieButton.translatesAutoresizingMaskIntoConstraints =  false
        return movieButton
    }()
    
    private lazy var categoriesButton: UIButton = {
        let movieButton = UIButton()
        movieButton.setTitle("Categories", for: .normal)
        movieButton.setTitleColor(UIColor.white, for: .normal)
        movieButton.translatesAutoresizingMaskIntoConstraints =  false
        return movieButton
    }()
    //Session properties
    private lazy var aImageViewLastMovie: UIImageView = {
        let aImageView = UIImageView()
        aImageView.contentMode = .scaleAspectFit
        aImageView.image = UIImage(systemName: Constants.ImageDefault.image)
        aImageView.translatesAutoresizingMaskIntoConstraints = false
        return aImageView
    }()
    
    private lazy var topRateTVLabel: UILabel = {
        let label = UILabel()
        label.text = "Top Rate TV Shows"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 20, weight: .heavy)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var aCollectionViewTopRateTV: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(ImageCollectionViewCell.self, forCellWithReuseIdentifier: ImageCollectionViewCell().identifier)
        collectionView.showsHorizontalScrollIndicator = true
        collectionView.backgroundColor = UIColor(named: Constants.ColorBackground.viewBackControllers)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private lazy var topRateMovieLabel: UILabel = {
        let label = UILabel()
        label.text = "Top Rate Movies"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 20, weight: .heavy)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var aCollectionViewTopRateMovie: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(ImageCollectionViewCell.self, forCellWithReuseIdentifier: ImageCollectionViewCell().identifier)
        collectionView.showsHorizontalScrollIndicator = true
        collectionView.backgroundColor = UIColor(named: Constants.ColorBackground.viewBackControllers)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private lazy var favotiteMovieLabel: UILabel = {
        let label = UILabel()
        label.text = "Your favorite Movies"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 20, weight: .heavy)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var aCollectionViewFavoriteMovie: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(ImageCollectionViewCell.self, forCellWithReuseIdentifier: ImageCollectionViewCell().identifier)
        collectionView.showsHorizontalScrollIndicator = true
        collectionView.backgroundColor = UIColor(named: Constants.ColorBackground.viewBackControllers)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.isHidden = true
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private lazy var aImageViewLastTV: UIImageView = {
        let aImageView = UIImageView()
        aImageView.contentMode = .scaleAspectFit
        aImageView.image = UIImage(systemName: Constants.ImageDefault.image)
        aImageView.translatesAutoresizingMaskIntoConstraints = false
        return aImageView
    }()
    
    private lazy var aCollectionViewFavoriteTV: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(ImageCollectionViewCell.self, forCellWithReuseIdentifier: ImageCollectionViewCell().identifier)
        collectionView.showsHorizontalScrollIndicator = true
        collectionView.backgroundColor = UIColor(named: Constants.ColorBackground.viewBackControllers)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.isHidden = true
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()

    // MARK: - lifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        addTarget()
        viewModel.getFavoriteMovies()
        viewModel.getLastMovie()
        viewModel.getTopRateTv()
        viewModel.getTopRateMovie()
        viewModel.getLastTv()
    }
    
    // MARK: - setupView
    
    func setupView() {
        view.addSubview(scrollView)
        scrollView.addSubview(containerView)
        let buttons = [movieButton, TVShowButton, categoriesButton]
        let stackView = UIStackView(arrangedSubviews: buttons)
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(stackView)
        
        [aImageViewLastMovie, topRateTVLabel, aCollectionViewTopRateTV, topRateMovieLabel, aCollectionViewTopRateMovie, favotiteMovieLabel, aCollectionViewFavoriteMovie, aImageViewLastTV].forEach {
            containerView.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: containerView.topAnchor),
            stackView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            
            aImageViewLastMovie.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 30),
            aImageViewLastMovie.leadingAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.leadingAnchor),
            aImageViewLastMovie.trailingAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.trailingAnchor),
            aImageViewLastMovie.heightAnchor.constraint(equalToConstant: 600),
            
            topRateTVLabel.topAnchor.constraint(equalTo: aImageViewLastMovie.bottomAnchor, constant: 5),
            topRateTVLabel.leadingAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            topRateTVLabel.trailingAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            
            aCollectionViewTopRateTV.topAnchor.constraint(equalTo: topRateTVLabel.bottomAnchor),
            aCollectionViewTopRateTV.leadingAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            aCollectionViewTopRateTV.trailingAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            aCollectionViewTopRateTV.heightAnchor.constraint(equalToConstant: 330),
            
            topRateMovieLabel.topAnchor.constraint(equalTo: aCollectionViewTopRateTV.bottomAnchor, constant: 5),
            topRateMovieLabel.leadingAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            topRateMovieLabel.trailingAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            
            aCollectionViewTopRateMovie.topAnchor.constraint(equalTo: topRateMovieLabel.bottomAnchor),
            aCollectionViewTopRateMovie.leadingAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            aCollectionViewTopRateMovie.trailingAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            aCollectionViewTopRateMovie.heightAnchor.constraint(equalToConstant: 330),
            
            favotiteMovieLabel.topAnchor.constraint(equalTo: aCollectionViewTopRateMovie.bottomAnchor, constant: 5),
            favotiteMovieLabel.leadingAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            favotiteMovieLabel.trailingAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            
            aCollectionViewFavoriteMovie.topAnchor.constraint(equalTo: favotiteMovieLabel.bottomAnchor),
            aCollectionViewFavoriteMovie.leadingAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            aCollectionViewFavoriteMovie.trailingAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            aCollectionViewFavoriteMovie.heightAnchor.constraint(equalToConstant: 330),
            
            aImageViewLastTV.topAnchor.constraint(equalTo: aCollectionViewFavoriteMovie.bottomAnchor),
            aImageViewLastTV.leadingAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.leadingAnchor),
            aImageViewLastTV.trailingAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.trailingAnchor),
            aImageViewLastTV.heightAnchor.constraint(equalToConstant: 600),

        ])
    }
    
    // MARK: - Add target
    
    func addTarget() {
        movieButton.addTarget(self, action: #selector(goToMovie), for: .touchUpInside)
        TVShowButton.addTarget(self, action: #selector(goToTVShow), for: .touchUpInside)
        categoriesButton.addTarget(self, action: #selector(goToCategories), for: .touchUpInside)
    }
    
    
    @objc private func goToMovie() {
        let movieVC = MovieViewController()
        self.navigationController?.pushViewController(movieVC, animated: true)
    }
    
    @objc private func goToTVShow() {
        let tvShowVC = TVViewController()
        self.navigationController?.pushViewController(tvShowVC, animated: true)
    }
    
    @objc private func goToCategories() {
        
    }
    
    
}
// MARK: - UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView{
        case aCollectionViewTopRateTV:
            return viewModel.getTopRateTVCount()
        case aCollectionViewTopRateMovie:
            return viewModel.getTopRateMovieCount()
        default:
            break
        }
        return viewModel.getFavoriteMovieCount()

    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCollectionViewCell().identifier, for: indexPath) as? ImageCollectionViewCell else { return UICollectionViewCell() }
        switch collectionView {
        case aCollectionViewTopRateTV:
            cell.configureCellTopRateTV(model: viewModel.getTopRateTVData(index: indexPath.row))
        case aCollectionViewTopRateMovie:
            cell.configureCellTopRateMovie(model: viewModel.getTopRateMovieData(index: indexPath.row))
        case aCollectionViewFavoriteMovie:
            cell.configureCellFavoriteMovie(model: viewModel.getFavoriteMoviData(index: indexPath.row))
        default:
            break
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width/2, height: view.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView {
        case aCollectionViewTopRateTV:
            let detailVC = TVDetailViewController()
            detailVC.idObject = viewModel.getTopRateTVData(index: indexPath.row).id
            self.navigationController?.pushViewController(detailVC, animated: true)
        case aCollectionViewTopRateMovie:
            let detailVC = MovieDetailViewController()
            detailVC.idObject = viewModel.getTopRateMovieData(index: indexPath.row).id
            self.navigationController?.pushViewController(detailVC, animated: true)
        case aCollectionViewFavoriteMovie:
            let detailVC = MovieDetailViewController()
            detailVC.idObject = Int(viewModel.getFavoriteMoviData(index: indexPath.row).id)
            self.navigationController?.pushViewController(detailVC, animated: true)
        default:
            break
        }
    }
    
}
// MARK: - HomeViewModelDelegate

extension HomeViewController: HomeViewModelDelegate {
    func updateDefaultImageLastTV() {
        DispatchQueue.main.async {
            self.aImageViewLastTV.image = UIImage(named: Constants.ImageDefault.logo)
        }
    }
    
    func updateLastTV(url: URL) {
        DispatchQueue.main.async {
            self.aImageViewLastTV.loadImage(at: url)
        }
    }
    
    func hideCollectionViewFavoriteMovie() {
        self.aCollectionViewFavoriteMovie.isHidden = true
    }
    
    func updateCollectionViewFavoriteMovie() {
        self.aCollectionViewFavoriteMovie.isHidden = false
        self.aCollectionViewFavoriteMovie.reloadData()
    }
    
    func updateCollectionViewTopRateMovie() {
        DispatchQueue.main.async {
            self.aCollectionViewTopRateMovie.reloadData()
        }
    }
    
    func updateLastMovie(url: URL) {
        DispatchQueue.main.async {
            self.aImageViewLastMovie.loadImage(at: url)
        }
    }
    
    func updateDefaultImageLastMovie() {
        DispatchQueue.main.async {
            self.aImageViewLastMovie.image = UIImage(named: Constants.ImageDefault.logo)
        }
       
    }
    
    func updateCollectionViewTopRateTV() {
        DispatchQueue.main.async {
            self.aCollectionViewTopRateTV.reloadData()
        }
    }
    
}

// MARK: - ShowErrorDelegate

extension HomeViewController: ShowErrorDelegate {
    func showError(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let acction = UIAlertAction(title: "Try agrain!", style: .default) { _ in
            self.viewModel.getLastMovie()
            self.viewModel.getTopRateTv()
            self.viewModel.getTopRateMovie()
            self.viewModel.getLastTv()
        }
        alert.addAction(acction)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(alert, animated: true)
    }

}

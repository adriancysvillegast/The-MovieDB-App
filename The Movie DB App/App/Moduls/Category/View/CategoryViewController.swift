//
//  CategoryViewController.swift
//  The Movie DB App
//
//  Created by Adriancys Jesus Villegas Toro on 10/9/22.
//

import UIKit

class CategoryViewController: UIViewController {
    // MARK: - Properties
    
    private lazy var viewModel: CategoryViewModel = {
        let viewModel = CategoryViewModel()
        viewModel.delegate = self
        viewModel.delegateError = self
        return viewModel
    }()
    
    private lazy var aTableView: UITableView = {
        let aTableView = UITableView()
        aTableView.register(CategoryTableViewCell.self, forCellReuseIdentifier: CategoryTableViewCell().identifier)
        aTableView.delegate = self
        aTableView.dataSource = self
        aTableView.translatesAutoresizingMaskIntoConstraints = false
        return aTableView
    }()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraints()
        viewModel.getCategories()
    }
    
    // MARK: - setupView
    
    private func setupView() {
        view.backgroundColor = UIColor(named: Constants.ColorBackground.viewBackControllers)
        view.addSubview(aTableView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            aTableView.topAnchor.constraint(equalTo: view.topAnchor),
            aTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            aTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            aTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

// MARK: - CategoryViewModelDelegate

extension CategoryViewController: CategoryViewModelDelegate {
    func reloadTable() {
        DispatchQueue.main.async {
            self.aTableView.reloadData()
        }
    }
    
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension CategoryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getCategoryCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CategoryTableViewCell().identifier, for: indexPath) as? CategoryTableViewCell else{ return UITableViewCell() }
        cell.configureCell(model: viewModel.getCategoryData(index: indexPath.row))
        return cell
    }
    
}

extension CategoryViewController: ShowErrorDelegate {
    func showError(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let acction = UIAlertAction(title: "Try agrain!", style: .default) { _ in
            self.viewModel.getCategories()
        }
        alert.addAction(acction)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel))
        present(alert, animated: true)
    }
    
    
}

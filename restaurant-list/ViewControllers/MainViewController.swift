//
//  ViewController.swift
//  restaurant-list
//
//  Created by Guadalupe Vlček on 27/11/2022.
//

import UIKit

protocol MainViewControllerPresenterProtocol {
    func fetchRestaurants()
    func updateFavorite(uuid: String, isFavorite: Bool)
    func getFavoriteStatus(uuid: String) -> Bool
}

class MainViewController: UIViewController, MainViewControllerProtocol, UITableViewDataSource, UITableViewDelegate, MainTableViewCellDelegate {
    private var viewData = MainViewControllerData()
    private var presenter: MainViewControllerPresenterProtocol
    private let tableView = UITableView()
    
    init(presenter: MainViewControllerPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        let view = UIView()
        self.view = view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        
        title = "MainView_title".localized()
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
        ])
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(MainTableViewCell.self, forCellReuseIdentifier: MainTableViewCell.identifier)
        
        presenter.fetchRestaurants()
    }
    
    // MARK: - MainViewControllerProtocol
    
    func loadRestaurants(restaurants: [Restaurant]) {
        viewData = MainViewControllerData(restaurants: restaurants)
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewData.restaurants.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MainTableViewCell.identifier, for: indexPath) as! MainTableViewCell
        cell.isFavorite = presenter.getFavoriteStatus(uuid: viewData.restaurants[indexPath.row].uuid)
        cell.restaurant = viewData.restaurants[indexPath.row]
        cell.delegate = self
        return cell
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.Constraints.mainTableViewCellHeight
    }
    
    // MARK: - MainTableViewCellDelegate
    
    func userDidSelectFavorite(uuid: String, isFavorite: Bool) {
        presenter.updateFavorite(uuid: uuid, isFavorite: isFavorite)
        
        //After updating the database I only update the cell that changed the favorite status
        if let index = viewData.restaurants.firstIndex(where: { $0.uuid == uuid }) {
            tableView.reloadRows(at: [IndexPath(row: index, section: .zero)], with: .none)
        }
    }
}


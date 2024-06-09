//
//  ProductListViewController.swift
//  MELIApp
//
//  Created by Jorge Menco on 7/06/24.
//

import UIKit
import MELIAppDomain
import MELIAppData

final class ProductListViewController: UIViewController, ProductListViewType {
    
    private struct Constants {
        static let paddingTop: CGFloat = 10
        static let paddingLeft: CGFloat = 10
        static let paddingRight: CGFloat = 10
        static let paddingBottom: CGFloat = 10
        static let contentViewCornerRadius: CGFloat = 10
        static let contentViewPaddingTop: CGFloat = 30
        static let contentViewShadowRadius: CGFloat = 4
        static let shadowOpacity: Float = 0.3
        static let searchViewHeight: CGFloat = 150
        static let productRowHeight: CGFloat = 140
    }
    
    // MARK: - Private properties -
    
    private lazy var searchView: UIView = {
        let view = UIView()
        view.backgroundColor = .meliYellowColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.placeholder = "Buscar en mercado libre"
        searchBar.searchBarStyle = .minimal
        searchBar.backgroundImage = UIImage()
        searchBar.layer.cornerRadius = 20
        searchBar.delegate = self
        searchBar.layer.masksToBounds = true
        return searchBar
    }()
    
    private lazy var ContentView: UIView = {
        let view = UIView()
        view.backgroundColor = .meliGrayBackground
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ProductListTableViewCell.self, forCellReuseIdentifier: ProductListTableViewCell.reuseIdentifier)
        tableView.separatorStyle = .none
        return tableView
    }()

    private lazy var loadingView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        return activityIndicator
    }()
    
    // MARK: - internal Properties -

    
    var items: [ProductInformation] = [] {
        didSet {
            if items.isEmpty {
                productListState = .emptyResults
            }
            tableView.reloadData()
        }
    }

    var productListState: ProductListState = .initialEmpty {
        didSet {
            checkEmptyState()
        }
    }
    
    var presenter: ProductListPresenterType?
    
    // MARK: - Lifecycle -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.meliGrayBackground
        setupSearchBar()
        setupContentView()
        setupTableView()
        checkEmptyState()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    // MARK: - internal methods -

    func removeLoadingView() {
        activityIndicator.stopAnimating()
        activityIndicator.isHidden = true
    }
    
    // MARK: - Private methods -
    
    private func setupSearchBar() {
        view.addSubview(searchView)
        searchView.addSubview(searchBar)
        
        searchView.addConstraints(
            top: view.topAnchor,
            leading: view.leadingAnchor,
            trailing: view.trailingAnchor,
            height: Constants.searchViewHeight)
        
        searchBar.addConstraints(
            top: view.safeAreaLayoutGuide.topAnchor,
            leading: searchView.leadingAnchor,
            bottom: searchView.bottomAnchor,
            trailing: searchView.trailingAnchor,
            paddingLeft: Constants.paddingLeft,
            paddingBottom: Constants.paddingBottom,
            paddingRight: Constants.paddingRight)
    }
    
    private func setupContentView() {
        view.addSubview(ContentView)
        ContentView.backgroundColor = .white
        ContentView.layer.cornerRadius = Constants.contentViewCornerRadius
        ContentView.layer.shadowColor = UIColor.black.cgColor
        ContentView.layer.shadowOpacity = Constants.shadowOpacity
        ContentView.layer.shadowOffset = CGSize(width: 0, height: 2)
        ContentView.layer.shadowRadius = Constants.contentViewShadowRadius
        
        ContentView.addConstraints(
            top: searchView.bottomAnchor,
            leading: view.leadingAnchor,
            bottom: view.bottomAnchor,
            trailing: view.trailingAnchor,
            paddingTop: Constants.contentViewPaddingTop,
            paddingLeft: Constants.paddingLeft,
            paddingBottom: Constants.paddingBottom,
            paddingRight: Constants.paddingRight)
    }
    
    private func setupTableView() {
        ContentView.addSubview(tableView)
        tableView.addConstraints(
            top: searchView.bottomAnchor,
            leading: ContentView.leadingAnchor,
            bottom: ContentView.bottomAnchor,
            trailing: ContentView.trailingAnchor)
    }
    
    private func showLoadingView() {
        loadingView.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        loadingView.backgroundColor = .meliLighBlue
        activityIndicator.center = self.view.center
        activityIndicator.color = .meliBlue
        loadingView.addSubview(activityIndicator)
        view.addSubview(loadingView)
        activityIndicator.startAnimating()
    }
    
    private func checkEmptyState() {
        switch productListState {
        case .initialEmpty:
            tableView.setEmptyState(
                text: "Realiza una buesqueda y descubre prodctos increibles",
                image: "magnifyingglass.circle")
        case .emptyResults:
            tableView.setEmptyState(
                text: "No encontramos resultados para tu bsuqueda intenta de nuevo",
                image: "magnifyingglass.circle")
        case .NetworkError:
            tableView.setEmptyState(text: "hubo un error de conexion intenta más tarde", image: "wifi.slash")
        case .filled, .searchring:
            tableView.backgroundView = nil
        }
    }
}

// MARK: - UITableViewDelegate -

extension ProductListViewController: UITableViewDelegate  {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = items[indexPath.row]
        presenter?.goToProductDeatil(item)
    }
}

// MARK: - UITableViewDataSource -

extension ProductListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ProductListTableViewCell.reuseIdentifier, for: indexPath) as! ProductListTableViewCell
        let item = items[indexPath.row]
        cell.configure(with: item)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.productRowHeight
    }
}

// MARK: - UITableViewDataSource -

extension ProductListViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let searchText = searchBar.text, !searchText.isEmpty {
            productListState = .searchring
            showLoadingView()
            presenter?.searchProducts(query: searchText)
        } else {
            items = []
        }
    }
}

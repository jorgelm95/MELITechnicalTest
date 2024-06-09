//
//  ProductDetailViewController.swift
//  MELIApp
//
//  Created by Jorge Menco on 7/06/24.
//

import UIKit
import MELIAppDomain

enum DetailSections: Int {
    case primaryInformation = 0
    case productBullets = 1
}

class ProductDetailViewController: UIViewController, ProductDetailViewType {
    
    private struct Constants {
        static let primaryInformationHeight: CGFloat = 450
        static let bulletInformationCellHeight: CGFloat = 30
        static let heightForHeaderInSection: CGFloat = 70
        static let numberOfRowsForPrimaryInformation = 1
        static let detailProductNumberOfSections = 2
        
    }
    
    // MARK: - Private properties -
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ProductDetailTableViewCell.self, forCellReuseIdentifier: ProductDetailTableViewCell.reuseIdentifier)
        tableView.register(BulletPointTableViewCell.self, forCellReuseIdentifier: BulletPointTableViewCell.reuseIdentifier)
        tableView.register(SectionHeaderView.self, forHeaderFooterViewReuseIdentifier: SectionHeaderView.reuseIdentifier)
        tableView.separatorStyle = .none
        return tableView
    }()

    // MARK: - Internal properties -
    
    var presenter: ProductDetailPresenter?
    var product: ProductInformation = ProductInformation(
        title: .empty,
        condition: .empty,
        thumbnail: .empty,
        price: nil,
        seller: Seller(nickName: .empty),
        attributes: [],
        accepts_mercadopago: false) {
        didSet {
            tableView.reloadData()
        }
    }
    
    // MARK: - LifeCycle -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        presenter?.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        title = "Detalle Producto"
        setupNavigationBarAppearance()
    }
    
    // MARK: - Private methods -
    
    private func setupNavigationBarAppearance() {
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .meliYellowColor
        appearance.titleTextAttributes = [.foregroundColor: UIColor.black]
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.addConstraints(
            top: view.topAnchor,
            leading: view.leadingAnchor,
            bottom: view.bottomAnchor,
            trailing: view.trailingAnchor)
    }
}

// MARK: - UITableViewDataSource -

extension ProductDetailViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return Constants.detailProductNumberOfSections
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case DetailSections.primaryInformation.rawValue:
            return Constants.numberOfRowsForPrimaryInformation // 1 celda para la información primaria
        case DetailSections.productBullets.rawValue:
            return product.attributes.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case DetailSections.primaryInformation.rawValue:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ProductDetailTableViewCell.reuseIdentifier, for: indexPath) as? ProductDetailTableViewCell else { return UITableViewCell() }
            cell.configure(
                title: product.title,
                imageUrl: product.thumbnail,
                price: product.price?.convertToString() ?? .empty,
                availableCuantity: product.condition,
                sellerName: product.seller.nickName)
            return cell
        case DetailSections.productBullets.rawValue:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: BulletPointTableViewCell.reuseIdentifier, for: indexPath) as? BulletPointTableViewCell else { return UITableViewCell() }
            let item = product.attributes[indexPath.row]
            cell.configure(title: item.name ?? .empty, value: item.value ?? .empty)
            return cell
        default:
            return UITableViewCell()
        }
    }
}

// MARK: - UITableViewDelegate -

extension ProductDetailViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case DetailSections.primaryInformation.rawValue:
            return Constants.primaryInformationHeight
        case DetailSections.productBullets.rawValue:
            return Constants.bulletInformationCellHeight
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: SectionHeaderView.reuseIdentifier) as? SectionHeaderView else { return UIView() }
        if section == 1 {
            headerView.setup(title: "Lo que tienes que saber de este producto")
        }
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == DetailSections.productBullets.rawValue {
            return 75
        }
        return 0.0
    }
}

//
//  ProductListRouter.swift
//  MELIApp
//
//  Created by Jorge Menco on 8/06/24.
//

import Foundation
import UIKit
import MELIAppDomain
import MELIAppData

final class ProductListRouter: ProductListRouterType {
    
    var viewControllerRef: UIViewController?
    
    static func buildModule() -> ProductListViewController {

        let repository: SearchProductsRepositoryType = SearchProductsRepository()
        let interactor = ProductListInteractor(repository: repository)
        let view = ProductListViewController()
        let presenter = ProductListPresenter(interactor: interactor, view: view)
        let router = ProductListRouter()
        view.presenter = presenter
        router.viewControllerRef = view
        presenter.router = router
        interactor.presenter = presenter
        
        return view
    }
    
    func goToDetailProductModule(_ product: ProductInformation) {
        guard let navigationController = viewControllerRef?.navigationController else { return }
        let viewController = ProductDetailRouter.buildModule(product: product)
        navigationController.pushViewController(viewController, animated: true)
    }
}

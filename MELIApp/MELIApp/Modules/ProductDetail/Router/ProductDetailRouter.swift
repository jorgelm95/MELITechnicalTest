//
//  ProductDetailRouter.swift
//  MELIApp
//
//  Created by Jorge Menco on 9/06/24.
//

import UIKit
import MELIAppDomain

final class ProductDetailRouter: ProductDetailRouterType {
    
    var viewControllerRef: UIViewController?
    
    static func buildModule(product: ProductInformation) -> ProductDetailViewController {
        let view = ProductDetailViewController()
        let presenter = ProductDetailPresenter(view: view)
        let router = ProductDetailRouter()
        view.presenter = presenter
        router.viewControllerRef = view
        presenter.router = router
        presenter.product = product
        
        return view
    }
}

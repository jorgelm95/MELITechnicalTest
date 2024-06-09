//
//  ProductDetailProtocols.swift
//  MELIApp
//
//  Created by Jorge Menco on 8/06/24.
//

import UIKit
import MELIAppDomain

protocol ProductDetailPresenterType: AnyObject {
    var view: ProductDetailViewType { get set }
    var router: ProductDetailRouterType? { get set }
    var product: ProductInformation? { get set }
    
    func viewDidLoad()
}

protocol ProductDetailViewType: AnyObject {
    var presenter: ProductDetailPresenter? { get set }
    var product: ProductInformation { get set }
}

protocol ProductDetailRouterType {
    var viewControllerRef: UIViewController? { get set }
}

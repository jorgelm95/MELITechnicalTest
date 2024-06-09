//
//  ProductListPresenter.swift
//  MELIApp
//
//  Created by Jorge Menco on 8/06/24.
//

import Foundation
import Combine
import MELIAppDomain

final class ProductListPresenter: ProductListPresenterType {

    // MARK: - Internal properties -
    
    var interactor: ProductListInteractorType
    var router: ProductListRouterType?
    unowned var view: ProductListViewType
    
    // MARK: - LifeCycle -
    
    init(interactor: ProductListInteractorType, view: ProductListViewType) {
        self.interactor = interactor
        self.view = view
    }
    
    // MARK: - Internal methods -
    
    func searchProducts(query: String) {
        interactor.searchProducts(query: query)
    }
    
    func goToProductDeatil(_ product: ProductInformation) {
        router?.goToDetailProductModule(product)
    }
}

// MARK: - ProductListInteractorOuputType -

extension ProductListPresenter: ProductListInteractorOuputType{
    
    func showResults(items: [ProductInformation]) {
        view.removeLoadingView()
        view.productListState = .filled
        view.items = items
    }
    
    func manageRequestError(error: ProductListError) {
        view.removeLoadingView()
        switch error {
        case .invalidResponse:
            view.productListState = .emptyResults
        case .undefined:
            view.productListState = .NetworkError
        }
    }
}

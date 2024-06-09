//
//  ProductListInteractor.swift
//  MELIApp
//
//  Created by Jorge Menco on 8/06/24.
//

import Foundation
import Combine
import MELIAppDomain
import MELIAppData

final class ProductListInteractor: ProductListInteractorType {
    
    // MARK: - Private properties -
    
    private var cancellable = Set<AnyCancellable>()
    
    // MARK: - Internal properties -
    
    var presenter: ProductListInteractorOuputType!
    var repository: SearchProductsRepositoryType
    
    // MARK: - LifeCycle -
    
    init(repository: SearchProductsRepositoryType) {
        self.repository = repository
    }
    
    // MARK: - Internal methods -
    
    func searchProducts(query: String) {
        return repository.searchProducts(query: query).sink { [weak self] completion in
            guard let self else { return }
            switch completion {
            case .finished:
                break
            case .failure(let error):
                self.presenter.manageRequestError(error: error)
            }
        } receiveValue: { [weak self] result in
            guard let self else { return }
            self.presenter.showResults(items: result)
        }.store(in: &cancellable)
    }
}

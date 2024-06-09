//
//  SearchProductsRepositoryType.swift
//  
//
//  Created by Jorge Menco on 8/06/24.
//

import Foundation
import Combine

public protocol SearchProductsRepositoryType {
    func searchProducts(query: String) -> AnyPublisher<[ProductInformation], ProductListError>
}

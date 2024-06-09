//
//  File.swift
//  
//
//  Created by Jorge Menco on 8/06/24.
//

import Foundation
import Combine
import MELIAppDomain
import MELINetworking

public class SearchProductsRepository: SearchProductsRepositoryType {
    
    let serviceManager: ServiceManagerType
    
    public init(serviceManager: ServiceManagerType = ServiceManager()) {
        self.serviceManager = serviceManager
    }
    
    public func searchProducts(query: String) -> AnyPublisher<[ProductInformation], ProductListError> {
        
        let request = SearchProductsRequest(query: query)
        
        return serviceManager.execute(request)
            .map({ self.mapper(apiData: $0.response)})
            .mapError({ self.mapperError(error: $0) })
            .eraseToAnyPublisher()
    }
    
    private func mapper(apiData: APISearchResponse) -> [ProductInformation] {
        let result = apiData.results.compactMap { product in
            ProductInformation(
                title: product.title,
                condition: product.condition,
                thumbnail: product.thumbnail,
                price: product.price,
                seller: self.mapperSeller(apiSeller: product.seller ?? APISeller(nickname: "jorge")),
                attributes: self.mapperAttributes(apiAttributes: product.attributes ?? []),
                accepts_mercadopago: product.acceptsMercadopago ?? false)
        }
        
        return result
    }
    
    private func mapperSeller(apiSeller: APISeller) -> Seller {
        return Seller(nickName: apiSeller.nickname ?? "")
    }
    
    private func mapperAttributes(apiAttributes: [APIAtrribute]) -> [Atrribute] {
        if apiAttributes.isEmpty {
            return []
        }
        
        return apiAttributes.compactMap { attribute in
            Atrribute(id: attribute.id, name: attribute.name, value: attribute.value)
        }
    }
    
    private func mapperError(error: ErrorHTTP.API) -> ProductListError {
        switch error {
        case .invalidResponse:
            return .invalidResponse
        case .undefined:
            return .undefined
        }
    }
}

//
//  APISearchResponse.swift
//  
//
//  Created by Jorge Menco on 8/06/24.
//

import Foundation
import MELIAppDomain

public struct APISeller: Decodable {
    public let nickname: String?
}

public struct APIAtrribute: Decodable {
    public let id: String?
    public let name: String?
    public let value: String?
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case value = "value_name"
        
    }
}

public struct APISearchResponse: Decodable {
    let results: [APIProductInfo]
}

public struct APIProductInfo: Decodable {
    public let title: String
    public let condition: String
    public let thumbnail: String
    public let price: Double?
    public let seller: APISeller?
    public let attributes: [APIAtrribute]?
    public let acceptsMercadopago: Bool?
    
    enum CodingKeys: String, CodingKey {
        case title, condition, thumbnail, price, seller, attributes
        case acceptsMercadopago = "accepts_mercadopago"
    }
}

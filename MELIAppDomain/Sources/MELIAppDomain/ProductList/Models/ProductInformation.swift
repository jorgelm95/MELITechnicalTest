//
//  ProductInformation.swift
//  
//
//  Created by Jorge Menco on 8/06/24.
//

import Foundation

public struct ProductInformation {
    public let title: String
    public let condition: String
    public let thumbnail: String
    public let price: Double?
    public let seller: Seller
    public let attributes: [Atrribute]
    public let accepts_mercadopago: Bool
    
    public init(
        title: String,
        condition: String,
        thumbnail: String,
        price: Double?,
        seller: Seller,
        attributes: [Atrribute],
        accepts_mercadopago: Bool) {
            self.title = title
            self.condition = condition
            self.thumbnail = thumbnail
            self.price = price
            self.seller = seller
            self.attributes = attributes
            self.accepts_mercadopago = accepts_mercadopago
        }
}

//
//  Atrribute.swift
//  
//
//  Created by Jorge Menco on 8/06/24.
//

import Foundation

public struct Atrribute {
    public let id: String?
    public let name: String?
    public let value: String?
    
    public init(id: String?, name: String?, value: String?) {
        self.id = id
        self.name = name
        self.value = value
    }
}

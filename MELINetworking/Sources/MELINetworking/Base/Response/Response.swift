//
//  Response.swift
//  
//
//  Created by Jorge Menco on 7/06/24.
//

import Foundation

public protocol ResponseType {
    associatedtype Response
    var response: Response { get }
    var httpCode: Int { get }
    init(response: Response, httpCode: Int)
}

public struct ResponseResult<R: Decodable>: ResponseType {
    
    public var httpCode: Int
    public typealias Response = R
    
    public var response: Response
    
    public init(response: Response, httpCode: Int) {
        self.response = response
        self.httpCode = httpCode
    }
}

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

struct SearchProductsRequest: RequestType {
    
    let query: String
    
    init(query: String) {
        self.query = query
    }
    
    typealias Output = ResponseResult<APISearchResponse>
    
    var baseUrl: URL { URL(string: "https://api.mercadolibre.com/")! }
    var path: String { "sites/MLA/search" }
    var queryParams: HTTPQueryParams {["q": query]}
    var method: HTTPMethod { .get }
    
    func decode(data: Data, httpCode: Int) throws -> ResponseResult<APISearchResponse> {
        let decoder = JSONDecoder()
        printData(for: data)

        return Output(
            response: try decoder.decode(Output.Response.self, from: data),
            httpCode: httpCode)
    }
    
    private func getJsonResponse(for data: Data) -> Dictionary<String, Any>? {
        return try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
    }
    
    private func printData(for data: Data) {
        guard let json = getJsonResponse(for: data) else {
            return
        }
        debugPrint("[HTTP RESPONSE] ", json)
    }
}

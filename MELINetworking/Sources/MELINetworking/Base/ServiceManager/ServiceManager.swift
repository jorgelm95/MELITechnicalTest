//
//  File.swift
//  
//
//  Created by Jorge Menco on 7/06/24.
//

import Foundation
import Combine

public protocol ServiceManagerType {
    func execute<R: RequestType>(_ request: R) -> AnyPublisher<R.Output, ErrorHTTP.API>
    func handleDataTaskOutput(
        urlResponse: URLResponse,
        data: Data
    ) throws -> (httpCode: Int, data: Data)
}


public final class ServiceManager: NSObject, ServiceManagerType {
    
    public override init() {}
    
    public func execute<R>(_ request: R) -> AnyPublisher<R.Output, ErrorHTTP.API> where R : RequestType {
        do {
            let urlRequest = try request.buildRequest()
            return getSession()
                .dataTaskPublisher(for: urlRequest)
                .tryMap { try self.handleDataTaskOutput(
                    urlResponse: $0.response,
                    data: $0.data)}
                .tryMap { try request.decode(data: $0.data, httpCode: $0.httpCode) }
                .mapError { self.handleDataTaskError($0) }
                .subscribe(on: OperationQueue())
                .receive(on: DispatchQueue.main)
                .eraseToAnyPublisher()
        } catch {
            return Fail<R.Output, ErrorHTTP.API>(error: error as? ErrorHTTP.API ?? .undefined).eraseToAnyPublisher()
        }
    }

    public func handleDataTaskOutput(urlResponse: URLResponse, data: Data) throws -> (httpCode: Int, data: Data) {
        guard let httpURLResponse = urlResponse as? HTTPURLResponse
        else {
            throw ErrorHTTP.API.invalidResponse
        }

        return (httpURLResponse.statusCode, data)
    }
    
    private func handleDataTaskError(
        _ error: Error
    ) -> ErrorHTTP.API {
        if let error = error as? URLError, error.code != .timedOut {
            return ErrorHTTP.API.undefined
        }
        return error as? ErrorHTTP.API ?? .undefined
    }
    
    func getSession() -> URLSession {
        URLSession(
            configuration: URLSessionConfiguration.default,
            delegate: self,
            delegateQueue: .main
        )
    }
}

extension ServiceManager: URLSessionDelegate {
    public func urlSession(
        _ session: URLSession,
        didReceive challenge: URLAuthenticationChallenge,
        completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void
    ) {
        if let serverTrust = challenge.protectionSpace.serverTrust {
            completionHandler(.useCredential, URLCredential(trust: serverTrust))
        }
    }
}

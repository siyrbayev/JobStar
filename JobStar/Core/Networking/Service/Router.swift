//
//  Router.swift
//  JobStar
//
//  Created by siyrbayev on 15.05.2022.
//

import Foundation

public typealias NetworkRouterCompletion = (_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Void

// MARK: - NetworkRouterProtocol

protocol NetworkRouterProtocol: AnyObject {
    
    associatedtype Endpoint: EndpointTypeProtocol
    
    func request(_ route: Endpoint, completion: @escaping NetworkRouterCompletion)
    func cancel()
}

class Router<Endpoint: EndpointTypeProtocol> {
    
    private var task: URLSessionTask?
}

extension Router: NetworkRouterProtocol {
    
    func request(_ route: Endpoint, completion: @escaping NetworkRouterCompletion) {
        let session = URLSession.shared
        
        do {
            let request = try buildRequest(from: route)
            task = session.dataTask(with: request, completionHandler: { data, response, error in
                completion(data, response, error)
            })
        } catch {
            completion(nil, nil, error)
        }
        task?.resume()
    }
    
    func cancel() {
        task?.cancel()
    }
}

fileprivate extension Router {
    
    func buildRequest(from route: Endpoint) throws -> URLRequest {
        
        let url = route.baseURL.appendingPathComponent(route.path)
        var request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 60.0)
        
        request.httpMethod = route.httpMethod.rawValue
        
        if let headers = route.headers {
            for (key, value) in headers {
                request.setValue(value, forHTTPHeaderField: key)
            }
        }
        
        do {
            switch route.task {
            case .request:
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                
            case .requestString(bodyString: let bodyString):
                try configureParameters(bodyString: bodyString, request: &request)
                
            case .requestParameters(let bodyParameters, let urlParameters):
                try configureParameters(bodyParameters: bodyParameters, urlParameters: urlParameters, request: &request)
                
            case .requestParametersAndHeaders(let bodyParameters, let urlParameters, let additionHeaders):
                addAdditionalHeaders(additionHeaders: additionHeaders, request: &request)
                try configureParameters(bodyParameters: bodyParameters, urlParameters: urlParameters, request: &request)
            }
            return request
        } catch {
            throw error
        }
    }
    
    func configureParameters(bodyParameters: Parameters?, urlParameters: Parameters?, request: inout URLRequest) throws {
        do {
            if let bodyParameters = bodyParameters {
                try JSONParameterEncoder.encode(urlRequest: &request, with: bodyParameters)
            }
            if let urlParameters = urlParameters {
                try JSONParameterEncoder.encode(urlRequest: &request, with: urlParameters)
            }
        } catch {
            throw error
        }
    }
    
    func configureParameters(bodyString: String?, request: inout URLRequest) throws {
        do {
            if let string = bodyString {
                try JSONParameterEncoder.encode(urlRequest: &request, with: string)
            }
        } catch {
            throw error
        }
    }
    
    func addAdditionalHeaders(additionHeaders: HTTPHeaders?, request: inout URLRequest) {
        guard let additionHeaders = additionHeaders else { return }
        for (key, value) in additionHeaders {
            request.setValue(value, forHTTPHeaderField: key)
        }
    }
}

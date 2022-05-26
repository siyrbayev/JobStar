//
//  NetworkRouter.swift
//  JobStar
//
//  Created by siyrbayev on 15.05.2022.
//

import Foundation

public typealias NetworkRouterCompletion = (_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Void

// MARK: - NetworkRouter

protocol NetworkRouterProtocol: AnyObject {
    associatedtype Endpoint: EndpointTypeProtocol
    func request(_ route: Endpoint, completion: @escaping NetworkRouterCompletion)
    func cancel()
}

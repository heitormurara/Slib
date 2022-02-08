import Foundation

typealias NetworkServiceCompletion = (_ data: Data?,
                                      _ response: URLResponse?,
                                      _ error: Error?) -> ()

protocol NetworkServiceProtocol: AnyObject {
    
    associatedtype Route: Endpoint
    
    func request(_ route: Route,
                 completion: @escaping NetworkServiceCompletion)
}

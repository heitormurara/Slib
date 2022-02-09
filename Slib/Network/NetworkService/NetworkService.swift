import Foundation

typealias NetworkServiceCompletion = (_ data: Data?,
                                      _ response: URLResponse?,
                                      _ error: Error?) -> ()

protocol NetworkServiceProtocol: AnyObject {
    
    associatedtype Endpoint: EndpointProtocol
    
    func request(_ endpoint: Endpoint,
                 completion: @escaping NetworkServiceCompletion)
}

final class NetworkService<Endpoint: EndpointProtocol>: NetworkServiceProtocol {
    
    private var urlSessionTask: URLSessionTask?
    
    func request(_ endpoint: Endpoint,
                 completion: @escaping NetworkServiceCompletion) {
        let session = URLSession.shared
        
        do {
            let request = try endpoint.asURLRequest()
            urlSessionTask = session.dataTask(with: request) { data, response, error in
                completion(data,
                           response,
                           error)
            }
        } catch {
            completion(nil,
                       nil,
                       error)
        }
        
        urlSessionTask?.resume()
    }
}

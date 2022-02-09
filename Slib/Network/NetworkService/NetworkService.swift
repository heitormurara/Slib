import Foundation

typealias NetworkServiceCompletion = (_ data: Data?,
                                      _ response: URLResponse?,
                                      _ error: Error?) -> ()

protocol NetworkServiceProtocol: AnyObject {
    
    func request(_ endpoint: EndpointProtocol,
                 completion: @escaping NetworkServiceCompletion)
}

final class NetworkService: NetworkServiceProtocol {
    
    private var urlSessionTask: URLSessionTask?
    
    func request(_ endpoint: EndpointProtocol,
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

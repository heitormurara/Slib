import Foundation

final class NetworkService<Route: Endpoint>: NetworkServiceProtocol {
    
    private var urlSessionTask: URLSessionTask?
    
    func request(_ route: Route,
                 completion: @escaping NetworkServiceCompletion) {
        let session = URLSession.shared
        
        do {
            let request = try route.asURLRequest()
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

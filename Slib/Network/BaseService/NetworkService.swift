import Foundation

final class NetworkService<Route: Endpoint>: NetworkServiceProtocol {
    
    func request(_ route: Route,
                 completion: @escaping NetworkServiceCompletion) {
        let session = URLSession.shared
        
        
    }
}

import Foundation

enum SeriesEndpoint {
    
    case get
}

// MARK: - Endpoint
extension SeriesEndpoint: EndpointProtocol {
    
    var baseURL: URL {
        URL(string: "https://api.tvmaze.com")!
    }
    
    var path: String {
        "/shows"
    }
    
    var method: HTTPMethod {
        .get
    }
    
    var headers: HTTPHeaders? {
        .none
    }
    
    var parameters: Parameters? {
        .none
    }
    
    var encoder: ParameterEncoder? {
        .none
    }
}

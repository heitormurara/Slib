import Foundation

enum SeriesEndpoint {
    
    case get(page: Int)
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
        switch self {
        case let .get(page):
            return ["page": page]
        }
    }
    
    var encoder: ParameterEncoder? {
        switch self {
        case .get:
            return URLParameterEncoder()
        }
    }
}

import Foundation

enum SeriesEndpoint {
    
    case get(page: Int)
    case search(_ string: String)
}

// MARK: - Endpoint
extension SeriesEndpoint: EndpointProtocol {
    
    var baseURL: URL {
        URL(string: "https://api.tvmaze.com")!
    }
    
    var path: String {
        switch self {
        case .get:
            return "/shows"
        case .search:
            return "/search/shows"
        }
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
        case let .search(string):
            return ["q": string]
        }
    }
    
    var encoder: ParameterEncoder? {
        switch self {
        case .get,
             .search:
            return URLParameterEncoder()
        }
    }
}

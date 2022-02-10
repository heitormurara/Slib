import Foundation

enum SeriesEndpoint {
    
    case get(page: Int)
    case search(_ string: String)
    case getSeasonsFrom(_ series: Series)
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
        case let .getSeasonsFrom(series):
            return "/shows/\(series.id)/seasons"
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
        default:
            return nil
        }
    }
    
    var encoder: ParameterEncoder? {
        switch self {
        case .get,
             .search:
            return URLParameterEncoder()
        default:
            return nil
        }
    }
}

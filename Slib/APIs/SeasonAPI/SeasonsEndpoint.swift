import Foundation

enum SeasonsEndpoint {
    
    case getEpisodesFrom(_ season: Season)
}

// MARK: - Endpoint
extension SeasonsEndpoint: EndpointProtocol {
    
    var baseURL: URL {
        URL(string: "https://api.tvmaze.com")!
    }
    
    var path: String {
        switch self {
        case let .getEpisodesFrom(season):
            return "/seasons/\(season.id)/episodes"
        }
    }
    
    var method: HTTPMethod {
        .get
    }
    
    var headers: HTTPHeaders? {
        .none
    }
    
    var parameters: Parameters? {
        nil
    }
    
    var encoder: ParameterEncoder? {
        nil
    }
}

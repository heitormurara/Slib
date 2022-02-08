import Foundation

protocol Endpoint: AnyObject {
    
    var baseURL: URL { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: HTTPHeaders? { get }
    var parameters: Parameters? { get }
    var encoder: ParameterEncoder? { get }
    
    func asURLRequest() throws -> URLRequest
}

extension Endpoint {
    
    func asURLRequest() throws -> URLRequest {
        var urlRequest = URLRequest(url: baseURL.appendingPathComponent(path),
                                    cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,
                                    timeoutInterval: 30)
        urlRequest.httpMethod = method.rawValue
        
        if parameters != nil {
            urlRequest = try encodingParameters(in: urlRequest)
        } else {
            urlRequest = settingJSONApplicationValue(to: urlRequest)
        }
        
        return urlRequest
    }
    
    private func settingJSONApplicationValue(to urlRequest: URLRequest) -> URLRequest {
        var urlRequest = urlRequest
        urlRequest.setValue("application/json",
                            forHTTPHeaderField: "Content-Type")
        return urlRequest
    }
    
    private func encodingParameters(in urlRequest: URLRequest) throws -> URLRequest {
        var urlRequest = urlRequest
        
        guard let encoder = encoder,
              let parameters = parameters
        else {
            throw NetworkError.encodingFailed
        }
        
        do {
            urlRequest = try encoder.encode(urlRequest,
                                            with: parameters)
        } catch {
            throw NetworkError.encodingFailed
        }
        
        return urlRequest
    }
}

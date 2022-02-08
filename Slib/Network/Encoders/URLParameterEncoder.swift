import Foundation

struct URLParameterEncoder: ParameterEncoder {
    
    func encode(_ urlRequest: URLRequest,
                with parameters: Parameters) throws -> URLRequest {
        guard let url = urlRequest.url else { throw NetworkError.missingURL }
        var urlRequest = urlRequest
        
        if var urlComponents = URLComponents(url: url,
                                             resolvingAgainstBaseURL: false),
           !parameters.isEmpty {
            urlComponents.queryItems = [URLQueryItem]()
            
            for (key, value) in parameters {
                let formattedValue = "\(value)".addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
                let queryItem = URLQueryItem(name: key,
                                             value: formattedValue)
                urlComponents.queryItems?.append(queryItem)
            }
            urlRequest.url = urlComponents.url
        }
        
        if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
            urlRequest.setValue("application/x-www-form-urlencoded",
                                forHTTPHeaderField: "Content-Type")
        }
        
        return urlRequest
    }
}

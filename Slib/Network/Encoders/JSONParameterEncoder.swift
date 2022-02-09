import Foundation

struct JSONParameterEncoder: ParameterEncoder {
    
    func encode(_ urlRequest: URLRequest,
                with parameters: Parameters) throws -> URLRequest {
        var urlRequest = urlRequest
        
        do {
            let data = try JSONSerialization.data(withJSONObject: parameters,
                                                  options: .prettyPrinted)
            urlRequest.httpBody = data
            
            if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
                urlRequest.setValue("application/json",
                                    forHTTPHeaderField: "Content-Type")
            }
        } catch {
            throw ParameterEncoderError.encodingFailed
        }
        
        return urlRequest
    }
}

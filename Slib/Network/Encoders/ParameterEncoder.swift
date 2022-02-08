import Foundation

protocol ParameterEncoder {
    
    func encode(_ urlRequest: URLRequest,
                with parameters: Parameters) throws -> URLRequest
}

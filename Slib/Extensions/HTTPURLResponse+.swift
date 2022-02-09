import Foundation

extension HTTPURLResponse {
    
    var status: HTTPStatusCode? {
        return HTTPStatusCode(rawValue: statusCode)
    }
}

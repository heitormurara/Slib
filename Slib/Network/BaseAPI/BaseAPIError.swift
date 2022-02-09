enum BaseAPIError: Error {
    
    case httpError(_ statusCode: HTTPStatusCode?)
    case decodingError
    case noResponse
    case unknown
}

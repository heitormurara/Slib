typealias SeriesListResult = Result<[Series], BaseAPIError>
typealias SeriesListCompletion = (SeriesListResult) -> Void

protocol SeriesAPIProtocol: AnyObject {
    
    func getSeries(_ completion: @escaping SeriesListCompletion)
}

final class SeriesAPI: BaseAPI<NetworkService<SeriesEndpoint>> {
    
    convenience init() {
        self.init(service: NetworkService<SeriesEndpoint>())
    }
}

// MARK: - SeriesAPIProtocol
extension SeriesAPI: SeriesAPIProtocol {
    
    func getSeries(_ completion: @escaping SeriesListCompletion) {
        request(.get, [Series].self, completion: completion)
    }
}

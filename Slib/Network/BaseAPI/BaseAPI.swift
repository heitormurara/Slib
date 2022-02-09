import Foundation

protocol BaseAPIProtocol where Service: NetworkServiceProtocol {
    
    associatedtype Service = NetworkServiceProtocol
    
    var service: Service { get }
    
    func request<T: Decodable>(_ endpoint: Service.Endpoint,
                               _ responseType: T.Type,
                               completion: @escaping (Result<T, BaseAPIError>) -> Void)
}

class BaseAPI<Service: NetworkServiceProtocol>: BaseAPIProtocol {
    
    let service: Service
    
    init(service: Service) {
        self.service = service
    }
    
    func request<T: Decodable>(_ endpoint: Service.Endpoint,
                               _ responseType: T.Type,
                               completion: @escaping (Result<T, BaseAPIError>) -> Void) {
        service.request(endpoint) { data, urlResponse, error in
            guard let httpURLResponse = urlResponse as? HTTPURLResponse,
                  let responseType = httpURLResponse.status?.responseType
            else {
                completion(.failure(BaseAPIError.noResponse))
                return
            }
            
            switch responseType {
            case .success:
                guard let data = data else { return }
                
                do {
                    let responseModel = try JSONDecoder().decode(T.self,
                                                                 from: data)
                    completion(.success(responseModel))
                } catch _ as DecodingError {
                    completion(.failure(BaseAPIError.decodingError))
                } catch {
                    completion(.failure(BaseAPIError.unknown))
                }
            default:
                completion(.failure(.httpError(httpURLResponse.status)))
            }
        }
    }
}

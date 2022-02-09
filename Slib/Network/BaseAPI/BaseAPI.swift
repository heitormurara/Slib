import Foundation

protocol BaseAPIProtocol {
    
    associatedtype Service = NetworkServiceProtocol
    
    var service: Service { get }
    
    func request<ResponseModel: Decodable>(_ endpoint: EndpointProtocol,
                                completion: @escaping (Result<ResponseModel, BaseAPIError>) -> Void)
}

class BaseAPI<Service: NetworkServiceProtocol>: BaseAPIProtocol {
    
    let service: Service
    
    required init(service: Service) {
        self.service = service
    }
    
    func request<ResponseModel: Decodable>(_ endpoint: EndpointProtocol,
                                completion: @escaping (Result<ResponseModel, BaseAPIError>) -> Void) {
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
                    let responseModel = try JSONDecoder().decode(ResponseModel.self,
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

typealias EpisodeListResult = Result<[Episode], BaseAPIError>
typealias EpisodeListCompletion = (EpisodeListResult) -> Void

protocol SeasonsAPIProtocol: AnyObject {
    
    func getEpisodes(from season: Season,
                     _ completion: @escaping EpisodeListCompletion)
}

final class SeasonsAPI: BaseAPI<NetworkService<SeasonsEndpoint>> {
    
    convenience init() {
        self.init(service: NetworkService<SeasonsEndpoint>())
    }
}

// MARK: - SeasonsAPIProtocol
extension SeasonsAPI: SeasonsAPIProtocol {
    
    func getEpisodes(from season: Season,
                     _ completion: @escaping EpisodeListCompletion) {
        request(.getEpisodesFrom(season),
                [Episode].self,
                completion: completion)
    }
}

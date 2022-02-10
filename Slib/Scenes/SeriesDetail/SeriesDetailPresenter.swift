import Foundation

protocol SeriesDetailPresenterProtocol: AnyObject {
    
    var series: Series { get }
    var seasonEpisodes: [Int: [Episode]] { get }
    func viewDidLoad()
}

protocol SeriesDetailPresenterDelegate: AnyObject {
    
}

final class SeriesDetailPresenter {
    
    private let viewController: SeriesDetailViewControllerProtocol
    private let seriesAPI: SeriesAPIProtocol
    private let seasonsAPI: SeasonsAPIProtocol
    
    weak var delegate: SeriesDetailPresenterDelegate?
    var series: Series
    var seasonEpisodes = [Int: [Episode]]()
    
    init(viewController: SeriesDetailViewControllerProtocol,
         series: Series,
         seriesAPI: SeriesAPIProtocol = SeriesAPI(),
         seasonsAPI: SeasonsAPIProtocol = SeasonsAPI()) {
        self.viewController = viewController
        self.series = series
        self.seriesAPI = seriesAPI
        self.seasonsAPI = seasonsAPI
    }
    
    private func getSeasonEpisodes() {
        seriesAPI.getSeasons(from: series) { [weak self] result in
            switch result {
            case let .success(seasonList):
                self?.getSeasonListEpisodes(seasonList)
            case .failure:
                break
            }
        }
    }
    
    private func getSeasonListEpisodes(_ seasonList: [Season]) {
        let dispatchGroup = DispatchGroup()
        
        seasonList.forEach { [weak self] season in
            dispatchGroup.enter()
            
            seasonsAPI.getEpisodes(from: season) { result in
                defer { dispatchGroup.leave() }
                
                switch result {
                case let .success(episodes):
                    self?.seasonEpisodes[season.id] = episodes
                case .failure:
                    break
                }
            }
        }
        
        dispatchGroup.notify(queue: .main) { [weak self] in
            self?.viewController.displaySeasonEpisodes()
        }
    }
}

// MARK: - SeriesDetailPresenterProtocol
extension SeriesDetailPresenter: SeriesDetailPresenterProtocol {
    
    func viewDidLoad() {
        viewController.displaySeries()
        getSeasonEpisodes()
    }
}

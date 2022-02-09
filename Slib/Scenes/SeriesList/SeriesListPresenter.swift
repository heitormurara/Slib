import Foundation

protocol SeriesListPresenterProtocol: AnyObject {
    
    var tableViewDataSource: [SeriesTableViewCellModel] { get }
    func viewDidLoad()
}

protocol SeriesListPresenterDelegate: AnyObject {
    
}

final class SeriesListPresenter {
    
    let viewController: SeriesListViewControllerProtocol
    let seriesAPI: SeriesAPIProtocol
    
    weak var delegate: SeriesListPresenterDelegate?
    
    private var seriesList: [Series] = [] {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.viewController.reloadTableView()
            }
        }
    }
    
    init(viewController: SeriesListViewControllerProtocol,
         seriesAPI: SeriesAPIProtocol = SeriesAPI()) {
        self.viewController = viewController
        self.seriesAPI = seriesAPI
    }
    
    private func loadSeries() {
        seriesAPI.getSeries { seriesListResult in
            switch seriesListResult {
            case let .success(seriesList):
                self.seriesList = seriesList
            case .failure:
                print("error")
            }
        }
    }
}

// MARK: - SeriesListPresenterProtocol
extension SeriesListPresenter: SeriesListPresenterProtocol {
    
    var tableViewDataSource: [SeriesTableViewCellModel] {
        seriesList.compactMap {
            SeriesTableViewCellModel(bannerImageURL: $0.image.originalSizeURL,
                                     title: $0.name,
                                     genres: $0.genres)
        }
    }
    
    func viewDidLoad() {
        loadSeries()
    }
}

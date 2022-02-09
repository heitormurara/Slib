import Foundation

protocol SeriesListPresenterProtocol: AnyObject {
    
    var tableViewDataSource: [SeriesTableViewCellModel] { get }
    func viewDidLoad()
    func viewDidReachScrollLimit()
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
    
    private var currentPage: Int = .zero
    private var isLoadingSeries = false
    
    init(viewController: SeriesListViewControllerProtocol,
         seriesAPI: SeriesAPIProtocol = SeriesAPI()) {
        self.viewController = viewController
        self.seriesAPI = seriesAPI
    }
    
    private func loadSeries() {
        guard !isLoadingSeries else { return }
        isLoadingSeries = true
        DispatchQueue.main.async { [weak self] in
            self?.viewController.displayActivityIndicator(true)
        }
        
        seriesAPI.getSeries(page: currentPage) { [weak self] seriesListResult in
            guard let self = self else { return }
            self.isLoadingSeries = false
            DispatchQueue.main.async {
                self.viewController.displayActivityIndicator(false)
            }
            
            switch seriesListResult {
            case let .success(newSeriesList):
                self.seriesList.append(contentsOf: newSeriesList)
                self.currentPage += 1
                
                DispatchQueue.main.async {
                    self.viewController.reloadTableView()
                }
            case .failure:
                break
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
    
    func viewDidReachScrollLimit() {
        loadSeries()
    }
}

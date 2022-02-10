import Foundation

protocol SeriesListPresenterProtocol: AnyObject {
    
    var tableViewDataSource: [SeriesTableViewCellModel] { get }
    func viewDidLoad()
    func viewDidReachScrollLimit()
    func searchBarSearchButtonClicked(_ searchString: String)
    func searchBarCancelButtonClicked()
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
    
    private var seriesSearchList: [Series] = [] {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.viewController.reloadTableView()
            }
        }
    }
    
    private var currentPage: Int = .zero
    private var currentStatus: SeriesListPresenterStatus = .none
    
    init(viewController: SeriesListViewControllerProtocol,
         seriesAPI: SeriesAPIProtocol = SeriesAPI()) {
        self.viewController = viewController
        self.seriesAPI = seriesAPI
    }
    
    private func loadSeries() {
        guard currentStatus != .loading,
              currentStatus != .searchingFinished
        else { return }
        currentStatus = .loading
        
        DispatchQueue.main.async { [weak self] in
            self?.viewController.displayActivityIndicator(true)
        }
        
        seriesAPI.getSeries(page: currentPage) { [weak self] seriesListResult in
            guard let self = self else { return }
            defer { self.currentStatus = .loadingFinished }
            
            DispatchQueue.main.async {
                self.viewController.displayActivityIndicator(false)
            }
            
            switch seriesListResult {
            case let .success(newSeriesList):
                self.seriesList.append(contentsOf: newSeriesList)
                self.currentPage += 1
            case .failure:
                break
            }
        }
    }
    
    private func searchSeries(_ searchString: String) {
        guard currentStatus != .searching else { return }
        currentStatus = .searching
        
        seriesAPI.searchSeries(string: searchString) { [weak self] seriesListResult in
            guard let self = self else { return }
            defer { self.currentStatus = .searchingFinished }
            
            switch seriesListResult {
            case let .success(seriesSearchList):
                self.seriesSearchList = seriesSearchList
            case .failure:
                break
            }
        }
    }
}

// MARK: - SeriesListPresenterProtocol
extension SeriesListPresenter: SeriesListPresenterProtocol {
    
    var tableViewDataSource: [SeriesTableViewCellModel] {
        var seriesList: [Series] = []
        
        switch currentStatus {
        case .loadingFinished, .searchingCanceled:
            seriesList = self.seriesList
        case .searchingFinished:
            seriesList = seriesSearchList
        default: break
        }
        
        let seriesTableViewCellModelList = seriesList.compactMap {
            SeriesTableViewCellModel(bannerImageURL: $0.image.originalSizeURL,
                                     title: $0.name,
                                     genres: $0.genres)
        }
        
        return seriesTableViewCellModelList
    }
    
    func viewDidLoad() {
        loadSeries()
    }
    
    func viewDidReachScrollLimit() {
        loadSeries()
    }
    
    func searchBarSearchButtonClicked(_ searchString: String) {
        searchSeries(searchString)
    }
    
    func searchBarCancelButtonClicked() {
        currentStatus = .searchingCanceled
        
        DispatchQueue.main.async { [weak self] in
            self?.viewController.reloadTableView()
        }
    }
}

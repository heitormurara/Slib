protocol SeriesDetailPresenterProtocol: AnyObject {
    
    var series: Series { get }
    func viewDidLoad()
}

protocol SeriesDetailPresenterDelegate: AnyObject {
    
}

final class SeriesDetailPresenter {
    
    private let viewController: SeriesDetailViewControllerProtocol
    
    weak var delegate: SeriesDetailPresenterDelegate?
    var series: Series
    
    init(viewController: SeriesDetailViewControllerProtocol,
         series: Series) {
        self.viewController = viewController
        self.series = series
    }
}

// MARK: - SeriesDetailPresenterProtocol
extension SeriesDetailPresenter: SeriesDetailPresenterProtocol {
    
    func viewDidLoad() {
        viewController.displaySeries()
    }
}

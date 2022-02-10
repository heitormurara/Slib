protocol SeriesDetailPresenterProtocol: AnyObject {
    
    func viewDidLoad()
}

protocol SeriesDetailPresenterDelegate: AnyObject {
    
}

final class SeriesDetailPresenter {
    
    let viewController: SeriesDetailViewControllerProtocol
    
    weak var delegate: SeriesDetailPresenterDelegate?
    
    init(viewController: SeriesDetailViewControllerProtocol) {
        self.viewController = viewController
    }
}

// MARK: - SeriesDetailPresenterProtocol
extension SeriesDetailPresenter: SeriesDetailPresenterProtocol {
    
    func viewDidLoad() {}
}

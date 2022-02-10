import UIKit

protocol SeriesDetailCoordinatorDelegate: AnyObject {}

final class SeriesDetailCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    weak var delegate: SeriesDetailCoordinatorDelegate?
    
    private let navigationController: UINavigationController
    private let series: Series
    
    init(navigationController: UINavigationController,
         series: Series) {
        self.navigationController = navigationController
        self.series = series
    }
    
    func start() {
        let viewController = SeriesDetailViewController()
        let presenter = SeriesDetailPresenter(viewController: viewController,
                                              series: series)
        viewController.presenter = presenter
//        presenter.delegate = self
        
        navigationController.pushViewController(viewController,
                                                animated: true)
    }
}

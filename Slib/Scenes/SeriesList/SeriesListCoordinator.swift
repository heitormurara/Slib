import UIKit

protocol SeriesListCoordinatorDelegate: AnyObject {}

final class SeriesListCoordinator: Coordinator {
    
    private let window: UIWindow
    
    var childCoordinators: [Coordinator] = []
    weak var delegate: SeriesListCoordinatorDelegate?
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        let viewController = SeriesListViewController()
        let navigationController = UINavigationController(rootViewController: viewController)
        let presenter = SeriesListPresenter(viewController: viewController)
        viewController.presenter = presenter
        presenter.delegate = self
        
        window.rootViewController = navigationController
    }
    
    func showDetails(of series: Series) {
        guard let navigationController = window.rootViewController as? UINavigationController else { return }
        let coordinator = SeriesDetailCoordinator(navigationController: navigationController,
                                                  series: series)
        addChildCoordinator(coordinator)
        coordinator.start()
    }
}

// MARK: - SeriesListPresenterDelegate
extension SeriesListCoordinator: SeriesListPresenterDelegate {
    
    func didSelectSeries(_ series: Series) {
        showDetails(of: series)
    }
}

import UIKit

protocol SeriesListCoordinatorDelegate: AnyObject {}

final class SeriesListCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    weak var delegate: SeriesListCoordinatorDelegate?
    
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewController = SeriesListViewController()
        let presenter = SeriesListPresenter(viewController: viewController)
        viewController.presenter = presenter
        
        navigationController.pushViewController(viewController,
                                                animated: true)
    }
}

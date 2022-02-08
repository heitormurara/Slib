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
        let viewModel = SeriesListViewModel()
        let viewController = SeriesListViewController(viewModel: viewModel)
        navigationController.pushViewController(viewController,
                                                animated: true)
    }
}

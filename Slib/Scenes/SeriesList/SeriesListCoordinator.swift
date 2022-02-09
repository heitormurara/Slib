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
        
        window.rootViewController = navigationController
    }
}

import UIKit

final class AppCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    
    private var window: UIWindow
    private let windowScene: UIWindowScene
    
    private lazy var rootViewController: UINavigationController = {
        UINavigationController(rootViewController: UIViewController())
    }()
    
    init(window: UIWindow,
         windowScene: UIWindowScene) {
        self.window = window
        self.windowScene = windowScene
    }
    
    func start() {
        window.windowScene = windowScene
        window.rootViewController = rootViewController
        window.makeKeyAndVisible()
        
        showSeriesList()
    }
    
    private func showSeriesList() {
        guard let navigationController = window.rootViewController as? UINavigationController else { return }
        
        let coordinator = SeriesListCoordinator(navigationController: navigationController)
        coordinator.delegate = self
        addChildCoordinator(coordinator)
        coordinator.start()
    }
}

// MARK: - SeriesListCoordinatorDelegate
extension AppCoordinator: SeriesListCoordinatorDelegate {
    
}

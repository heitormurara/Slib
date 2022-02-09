import UIKit

final class AppCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    
    private var window: UIWindow
    private let windowScene: UIWindowScene
    
    init(window: UIWindow,
         windowScene: UIWindowScene) {
        self.window = window
        self.windowScene = windowScene
    }
    
    func start() {
        window.windowScene = windowScene
        window.makeKeyAndVisible()
        
        showSeriesList()
    }
    
    private func showSeriesList() {
        let coordinator = SeriesListCoordinator(window: window)
        coordinator.delegate = self
        addChildCoordinator(coordinator)
        coordinator.start()
    }
}

// MARK: - SeriesListCoordinatorDelegate
extension AppCoordinator: SeriesListCoordinatorDelegate {
    
}

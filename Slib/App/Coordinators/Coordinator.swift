protocol Coordinator: AnyObject {
    
    var childCoordinators: [Coordinator] { get set }
    
    func start()
    
    func addChildCoordinator(_ coordinator: Coordinator)
    func removeChildCoordinator(_ coordinator: Coordinator)
}

// MARK: - Default Implementations
extension Coordinator {
    
    func addChildCoordinator(_ coordinator: Coordinator) {
        childCoordinators.append(coordinator)
    }
    
    func removeChildCoordinator(_ coordinator: Coordinator) {
        childCoordinators.removeAll { $0 === coordinator }
    }
}

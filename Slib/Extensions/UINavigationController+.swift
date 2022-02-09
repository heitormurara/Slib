import UIKit

extension UINavigationController {
    
    func configure() {
        let textAttributes = [NSAttributedString.Key.foregroundColor: Colors.primaryText as Any]
        navigationBar.prefersLargeTitles = true
        navigationBar.largeTitleTextAttributes = textAttributes
        navigationBar.titleTextAttributes = textAttributes
        navigationBar.barTintColor = Colors.backgroundSystem
        navigationBar.barStyle = .black
    }
}

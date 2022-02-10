import UIKit

extension UINavigationController {
    
    func configureLargeNavigationBar() {
        let textAttributes = [NSAttributedString.Key.foregroundColor: Colors.primaryText as Any]
        navigationBar.prefersLargeTitles = true
        navigationBar.largeTitleTextAttributes = textAttributes
        navigationBar.titleTextAttributes = textAttributes
        commonConfigure()
        navigationBar.setBackgroundImage(nil,
                                         for: .default)
        navigationBar.shadowImage = nil
    }
    
    func configureSmallNavigationBar() {
        navigationBar.prefersLargeTitles = false
        commonConfigure()
        navigationBar.setBackgroundImage(UIImage(),
                                         for: .default)
        navigationBar.shadowImage = UIImage()
    }
    
    private func commonConfigure() {
        navigationBar.barTintColor = Colors.backgroundSystem
        navigationBar.tintColor = Colors.primaryText
        navigationBar.barStyle = .black
    }
}

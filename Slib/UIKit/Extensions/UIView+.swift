import UIKit

extension UIView {
    
    func addSubviews(_ views: UIView...) {
        views.forEach { $0.addSubview($0) }
    }
}

// MARK: - Stylable
extension UIView: Stylable {}

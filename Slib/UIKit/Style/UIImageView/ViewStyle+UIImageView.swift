import UIKit

extension ViewStyle where T: UIImageView {
    
    static var rounded: ViewStyle<UIImageView> {
        ViewStyle<UIImageView> {
            $0.layer.cornerRadius = 8
            $0.layer.masksToBounds = true
        }
    }
}

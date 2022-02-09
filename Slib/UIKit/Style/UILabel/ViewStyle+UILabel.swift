import UIKit

extension ViewStyle where T: UILabel {
    
    static var title: ViewStyle<UILabel> {
        ViewStyle<UILabel> {
            $0.font = UIFont.systemFont(ofSize: 20,
                                        weight: .bold)
            $0.textColor = Colors.primaryText
        }
    }
    
    static var primaryText: ViewStyle<UILabel> {
        ViewStyle<UILabel> {
            $0.font = UIFont.systemFont(ofSize: 16,
                                        weight: .regular)
            $0.textColor = Colors.primaryText
        }
    }
    
    static var secondaryText: ViewStyle<UILabel> {
        ViewStyle<UILabel> {
            $0.font = UIFont.systemFont(ofSize: 16,
                                        weight: .regular)
            $0.textColor = Colors.secondaryText
        }
    }
}

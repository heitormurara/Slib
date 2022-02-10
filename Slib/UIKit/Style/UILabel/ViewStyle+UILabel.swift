import UIKit

extension ViewStyle where T: UILabel {
    
    // MARK: - Tiers
    
    static var largeTitle: ViewStyle<UILabel> {
        ViewStyle<UILabel> {
            $0.font = UIFont.systemFont(ofSize: 34,
                                        weight: .bold)
            $0.textColor = Colors.primaryText
        }
    }
    
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
    
    static var tertiaryText: ViewStyle<UILabel> {
        ViewStyle<UILabel> {
            $0.font = UIFont.systemFont(ofSize: 14,
                                        weight: .regular)
            $0.textColor = Colors.secondaryText
        }
    }
    
    // MARK: - Alignments
    
    static var center: ViewStyle<UILabel> {
        ViewStyle<UILabel> {
            $0.textAlignment = .center
        }
    }
    
    // MARK: - Configurations
    
    static var unlimitedLines: ViewStyle<UILabel> {
        ViewStyle<UILabel> {
            $0.numberOfLines = .zero
        }
    }
}

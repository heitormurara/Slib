import UIKit

protocol Stylable {
    
    init()
}

extension Stylable {
    
    init(style: ViewStyle<Self>) {
        self.init()
        apply(style)
    }
    
    init(styles: ViewStyle<Self>...) {
        self.init()
        styles.forEach { apply($0) }
    }
    
    func apply(_ style: ViewStyle<Self>) {
        style.style(self)
    }
}

import UIKit

protocol Stylable {
    
    init()
}

extension Stylable {
    
    init(style: ViewStyle<Self>) {
        self.init()
        apply(style)
    }
    
    func apply(_ style: ViewStyle<Self>) {
        style.style(self)
    }
}

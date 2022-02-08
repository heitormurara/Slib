struct ViewStyle<T> {
    
    let style: (T) -> Void
}

extension ViewStyle {
    
    func compose(with style: ViewStyle<T>) -> ViewStyle<T> {
        ViewStyle<T> {
            self.style($0)
            style.style($0)
        }
    }
}

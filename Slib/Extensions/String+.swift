extension String {
    
    func strippingHTMLTags() -> String {
        replacingOccurrences(of: "<[^>]+>",
                             with: "",
                             options: .regularExpression,
                             range: nil)
    }
}

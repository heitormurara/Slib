struct SeriesImage: Codable {
    
    let mediumSizeURL: String
    let originalSizeURL: String
    
    enum CodingKeys: String, CodingKey {
        
        case mediumSizeURL = "medium"
        case originalSizeURL = "original"
    }
}

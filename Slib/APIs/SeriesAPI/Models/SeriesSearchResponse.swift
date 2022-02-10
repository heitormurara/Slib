struct SeriesSearchAPIResponse: Decodable {
    
    let series: Series
    
    enum CodingKeys: String, CodingKey {
        
        case series = "show"
    }
}

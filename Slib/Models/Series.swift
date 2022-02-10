struct Series: Codable {
    
    let id: Int
    let name: String
    let genres: [String]
    let image: SeriesImage
    let schedule: SeriesSchedule
    let summary: String
}

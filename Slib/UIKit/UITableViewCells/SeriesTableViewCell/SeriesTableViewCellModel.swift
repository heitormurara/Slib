import Foundation

struct SeriesTableViewCellModel {
    
    let bannerImageURL: URL?
    let title: String
    let genres: [String]
    
    init(bannerImageURL: String,
         title: String,
         genres: [String]) {
        self.bannerImageURL = URL(string: bannerImageURL)
        self.title = title
        self.genres = genres
    }
}

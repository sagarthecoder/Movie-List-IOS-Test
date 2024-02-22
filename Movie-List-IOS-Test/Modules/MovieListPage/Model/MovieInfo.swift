//
//  MovieInfo.swift
//  Movie-List-IOS-Test
//
//  Created by Sagar on 2/23/24.
//

import Foundation

struct MovieInfo : Codable {
    
    var title : String?
    var overview : String?
    var posterPath : String?
    
    enum CodingKeys : String, CodingKey {
        case title = "title"
        case overview = "overview"
        case posterPath = "poster_path"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.title = try container.decodeIfPresent(String.self, forKey: .title)
        self.overview = try container.decodeIfPresent(String.self, forKey: .overview)
        self.posterPath = try container.decodeIfPresent(String.self, forKey: .posterPath)
    }
}

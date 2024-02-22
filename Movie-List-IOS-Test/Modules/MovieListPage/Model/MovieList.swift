//
//  MovieList.swift
//  Movie-List-IOS-Test
//
//  Created by Sagar on 2/23/24.
//

import Foundation

struct MovieList : Codable {
    
    var results : [MovieInfo]?
    
    enum CodingKeys : String, CodingKey {
        case results = "results"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.results = try container.decodeIfPresent([MovieInfo].self, forKey: .results)
    }
}

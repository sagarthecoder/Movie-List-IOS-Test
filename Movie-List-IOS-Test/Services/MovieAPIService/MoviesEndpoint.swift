//
//  MoviesEndpoint.swift
//  Movie-List-IOS-Test
//
//  Created by Sagar on 2/23/24.
//
// https://api.themoviedb.org/3/search/movie?api_key=3f575bd097b18aa6bd4bd1f7df9c973d&query=marvel

import Foundation

enum MoviesEndpoint {
    case getMovieList(query : String)
}

extension MoviesEndpoint : Endpoint {
    var scheme: String {
        return "https"
    }
    
    var host: String {
        return "api.themoviedb.org"
    }
    
    var path: String {
        switch self {
        case .getMovieList(_):
            return "/3/search/movie"
        }
    }
    
    var method: RequestMethod {
        return .get
    }
    
    var body: [String : String]? {
        return nil
    }
    
    var queryItems: [URLQueryItem]? {
        switch self {
        case .getMovieList(let query):
            let apiKey = APIConfig.apiKey
            return [
                URLQueryItem(name: "api_key", value: apiKey),
                URLQueryItem(name: "query", value: query)
            ]
        }
    }
    
    var header: [String : String]? {
        return ["Content-type": "application/json"]
    }
    
    
}

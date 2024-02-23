//
//  MoviesEndpoint.swift
//  Movie-List-IOS-Test
//
//  Created by Sagar on 2/23/24.
//


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
            let validatedQuery  = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
            let apiKey = APIConfig.apiKey
            return [
                URLQueryItem(name: "api_key", value: apiKey),
                URLQueryItem(name: "query", value: validatedQuery)
            ]
        }
    }
    
    var header: [String : String]? {
        return ["Content-type": "application/json"]
    }
    
    
}

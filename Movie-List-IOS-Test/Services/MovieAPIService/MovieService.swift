//
//  MovieService.swift
//  Movie-List-IOS-Test
//
//  Created by Sagar on 2/23/24.
//

import UIKit

protocol MovieServiceable {
    func getMovieList(query : String) async -> Result<MovieList, RequestError>
}

struct MovieService: HTTPClient, MovieServiceable {
    
    func getMovieList(query : String) async -> Result<MovieList, RequestError> {
        return await sendRequest(endpoint: MoviesEndpoint.getMovieList(query: query), responseModel: MovieList.self)
    }
    
}

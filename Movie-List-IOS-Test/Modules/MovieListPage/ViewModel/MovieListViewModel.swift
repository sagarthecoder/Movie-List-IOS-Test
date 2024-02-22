//
//  MovieListViewModel.swift
//  Movie-List-IOS-Test
//
//  Created by Sagar on 2/23/24.
//

import UIKit

class MovieListViewModel {
    
    var items = [MovieInfo]()
    var service : MovieService
    
    init(movieService : MovieService) {
        self.service = movieService
    }
    
    func setNewMovieItems(query : String, completion : ((_ isSuccess : Bool)->())? = nil) {
        Task {
            let result = await self.service.getMovieList(query : query)
            switch result {
            case .success(let movieList):
                guard let moviesInfo = movieList.results else {
                    return
                }
                self.items = moviesInfo
                completion?(true)
                break
            case .failure(let error):
                print("failed to fetch Movies \(error.errorMessage)")
                completion?(false)
                break
            }
        }
    }
    
    func numberOfItems()-> Int {
        return items.count
    }
    
    func indexValidation(index : Int)-> Bool {
        guard index >= 0, index < numberOfItems() else {
            return false
        }
        return true
    }
    
    func getItemAt(at index : Int)-> MovieInfo? {
        guard indexValidation(index: index) else {
            return nil
        }
        return items[index]
    }
    
    func getPosterURL(path : String?)-> URL? {
        guard let path = path else {
            return nil
        }
        let urlString = APIConfig.posterBaseURL + path
        return URL(string: urlString)
    }
}

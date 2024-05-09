//
//  MovieConstant.swift
//  MovieAppNSB
//
//  Created by Baran Baran on 6.05.2024.
//

import Foundation

struct ConstantsMovie {
    static let API_KEY = "43810a10daa5ac1a577ce7405e85f587"
    static let baseURL = "https://api.themoviedb.org"
}



struct MovieURL {
    static let trendAll = "\(ConstantsMovie.baseURL)/3/trending/all/day?api_key=\(ConstantsMovie.API_KEY)"
    static let trendTV =  "\(ConstantsMovie.baseURL)/3/trending/tv/day?api_key=\(ConstantsMovie.API_KEY)"
    static let upcomingMovie = "\(ConstantsMovie.baseURL)/3/movie/upcoming?api_key=\(ConstantsMovie.API_KEY)&language=en-US&page=1"
    static let popularMovie = "\(ConstantsMovie.baseURL)/3/movie/popular?api_key=\(ConstantsMovie.API_KEY)&language=en-US&page=1"
    static let topratedMovie = "\(ConstantsMovie.baseURL)/3/movie/top_rated?api_key=\(ConstantsMovie.API_KEY)&language=en-US&page=1"
    static let discoverMovie = "\(ConstantsMovie.baseURL)/3/discover/movie?api_key=\(ConstantsMovie.API_KEY)&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&with_watch_monetization_types=flatrate"
    
}

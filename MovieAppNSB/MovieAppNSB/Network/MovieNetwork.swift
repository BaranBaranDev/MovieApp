//
//  MovieNetwork.swift
//  MovieAppNSB
//
//  Created by Baran Baran on 4.05.2024.
//

import Foundation


// MARK: - MovieNetworkProtocol
protocol MovieNetworkProtocol {
    func getTrendMovies(completion: @escaping(Result<MoviesResponse, NetworkError>) -> Void)
    func getTrendTv(completion: @escaping(Result<MoviesResponse, NetworkError>) -> Void)
    func getUpcomingMovie(completion: @escaping(Result<MoviesResponse, NetworkError>) -> Void)
    func getPopularMovie(completion: @escaping (Result<MoviesResponse, NetworkError>) -> Void)
    func getTopRatedMovie(completion: @escaping(Result<MoviesResponse, NetworkError>) -> Void)
    func getDiscoverMovie(completion: @escaping(Result<MoviesResponse, NetworkError>) -> Void)
}

// MARK: - MovieNetwork Class

final class MovieNetwork{
    static let shared = MovieNetwork()
    private init() {}

}


extension MovieNetwork: MovieNetworkProtocol{
    func getTrendMovies(completion: @escaping (Result<MoviesResponse, NetworkError>) -> Void){
        NetworkManager.shared.fetchData(url: MovieURL.trendAll, completion: completion)
    }
    
    func getTrendTv(completion: @escaping (Result<MoviesResponse, NetworkError>) -> Void){
        NetworkManager.shared.fetchData(url: MovieURL.trendTV, completion: completion)
    }
    
    func getUpcomingMovie(completion: @escaping (Result<MoviesResponse, NetworkError>) -> Void){
        NetworkManager.shared.fetchData(url: MovieURL.upcomingMovie, completion: completion)
    }
    func getPopularMovie(completion: @escaping (Result<MoviesResponse, NetworkError>) -> Void){
        NetworkManager.shared.fetchData(url: MovieURL.popularMovie, completion: completion)
    }
    
    func getTopRatedMovie(completion: @escaping (Result<MoviesResponse, NetworkError>) -> Void){
        NetworkManager.shared.fetchData(url: MovieURL.topratedMovie, completion: completion)
    }
    func getDiscoverMovie(completion: @escaping (Result<MoviesResponse, NetworkError>) -> Void){
        NetworkManager.shared.fetchData(url: MovieURL.discoverMovie, completion: completion)
    }
    
}

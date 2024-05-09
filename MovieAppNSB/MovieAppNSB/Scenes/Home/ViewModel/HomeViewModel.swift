//
//  HomeViewModel.swift
//  MovieAppNSB
//
//  Created by Baran Baran on 7.05.2024.
//

import Foundation

// çıktılarımız
enum HomeViewModelOutput{
    case TrendMoviesOutput([Movie])
    case TrendTvOutput([Movie])
    case PopularOutput([Movie])
    case UpcomingOutput([Movie])
    case TopRatedOutput([Movie])
    case ErrorOutput(Error)
}

// haberleşmeleri için delegete
protocol HomeViewModelDelegate: AnyObject {
    func handleOutput(_ output: HomeViewModelOutput)
}


final class HomeViewModel{
    weak var output: HomeViewModelDelegate?
}

extension HomeViewModel{
    func fetchData() {
        fetchTrendingMovies()
        fetchTrendingTv()
        fetchUpcomingMovies()
        fetchPopularMovies()
        fetchTopRatedMovies()
    }
    
    private func fetchTrendingMovies() {
        MovieNetwork.shared.getTrendMovies { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let movies):
                self.output?.handleOutput(.TrendMoviesOutput(movies.results))
            case .failure(let error):
                self.output?.handleOutput(.ErrorOutput(error))
            }
        }
    }
    
    private func fetchTrendingTv() {
        MovieNetwork.shared.getTrendTv { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let tvs):
                self.output?.handleOutput(.TrendTvOutput(tvs.results))
            case .failure(let error):
                self.output?.handleOutput(.ErrorOutput(error))
            }
        }
    }
    
    private func fetchUpcomingMovies() {
        MovieNetwork.shared.getUpcomingMovie { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let movies):
                self.output?.handleOutput(.UpcomingOutput(movies.results))
            case .failure(let error):
                self.output?.handleOutput(.ErrorOutput(error))
            }
        }
    }
    
    private func fetchPopularMovies() {
        MovieNetwork.shared.getPopularMovie { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let movies):
                self.output?.handleOutput(.PopularOutput(movies.results))
            case .failure(let error):
                self.output?.handleOutput(.ErrorOutput(error))
            }
        }
    }
    
    private func fetchTopRatedMovies() {
        MovieNetwork.shared.getTopRatedMovie { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let movies):
                self.output?.handleOutput(.TopRatedOutput(movies.results))
            case .failure(let error):
                self.output?.handleOutput(.ErrorOutput(error))
            }
        }
    }
}

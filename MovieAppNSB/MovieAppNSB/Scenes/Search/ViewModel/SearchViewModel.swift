//
//  SearchViewModel.swift
//  MovieAppNSB
//
//  Created by Baran Baran on 9.05.2024.
//

import Foundation



// MARK: - UpcomingViewModelDelegate

protocol SearchViewModelDelegate: AnyObject {
    func didFinish()
    func didFail(_ error: Error)
}

// MARK: - UpcomingViewModel

final class SearchViewModel{
    weak var delegate: SearchViewModelDelegate?
    
    private(set) var discoverMoviesArray : [Movie] = []
    
}

extension SearchViewModel{
   
    func fetchData(){
        MovieNetwork.shared.getDiscoverMovie { [weak self] result in
            guard let self = self else{return}
            switch result{
            case .success(let movies):
                self.discoverMoviesArray = movies.results
                delegate?.didFinish()
            case .failure(let error):
                delegate?.didFail(error)
            }
        }
    }
}

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

// MARK: - SearchViewModelProtocol

protocol SearchViewModelProtocol {
    func fetchData()
    func search(searchQuery: String, resultController: SearchResultController)
}

// MARK: - SearchViewModel

final class SearchViewModel{
    weak var delegate: SearchViewModelDelegate?
    
    private(set) var discoverMoviesArray : [Movie] = []
    
}

extension SearchViewModel: SearchViewModelProtocol{
    
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
    
    
    func search(searchQuery: String, resultController: SearchResultController){
        MovieNetwork.shared.getSearchMovie(searchQuery: searchQuery) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let searched):
                // SearchResultController'a alınan sonuçları ata ve koleksiyon görünümünü yeniden yükle
                resultController.searchedMovies = searched.results
                DispatchQueue.main.async { [weak self] in
                    guard self != nil else{return}
                    resultController.collectionView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

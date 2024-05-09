//
//  UpcomingViewModel.swift
//  MovieAppNSB
//
//  Created by Baran Baran on 9.05.2024.
//

import Foundation

// MARK: - UpcomingViewModelDelegate

protocol UpcomingViewModelDelegate: AnyObject {
    func didFinish()
    func didFail(_ error: Error)
}

// MARK: - UpcomingViewModel

final class UpcomingViewModel{
    weak var delegate: UpcomingViewModelDelegate?
    
    private(set) var upcomingMoviesArray : [Movie] = []
    
}

extension UpcomingViewModel{
   
    func fetchData(){
        MovieNetwork.shared.getUpcomingMovie { [weak self] result in
            guard let self = self else{return}
            switch result{
            case .success(let movies):
                self.upcomingMoviesArray = movies.results
                delegate?.didFinish() // tableView güncellenmeli
            case .failure(let error):
                delegate?.didFail(error)
            }
        }
    }
}

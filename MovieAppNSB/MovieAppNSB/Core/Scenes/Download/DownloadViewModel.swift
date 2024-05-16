//
//  DownloadViewModel.swift
//  MovieAppNSB
//
//  Created by Baran Baran on 16.05.2024.
//

import Foundation

// MARK: - DownloadViewModelDelegate

protocol DownloadViewModelDelegate:AnyObject {
    func didFinish()
    func didFail(_ error:Error)
}

// MARK: - DownloadViewModelProtocol
protocol DownloadViewModelProtocol {
    func fetchDownloadData()
}

// MARK: - DownloadViewModel

final class DownloadViewModel{
    private(set) var databaseArray : [DataEntities] = []
    weak var delegate : DownloadViewModelDelegate?
}

extension DownloadViewModel{
    func fetchDownloadData(){
        DataManager.shared.fetchDatabase {[weak self] result in
            guard let self = self else{return}
            switch result{
            case .success(let dataEntity):
                self.databaseArray = dataEntity
                delegate?.didFinish()
            case .failure(let error):
                delegate?.didFail(error)
            }
        }
    }
    
    func deleteData(indexPath:IndexPath){
        DataManager.shared.deleteDatabase(deleteItem: databaseArray[indexPath.item]) { [weak self] result in
            guard let self = self else{return}
            switch result{
            case .success():
                self.databaseArray.remove(at: indexPath.item)
                delegate?.didFinish()
            case .failure(let error):
                delegate?.didFail(error)
            }
        }
        
    }
}


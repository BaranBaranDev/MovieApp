//
//  DataManager.swift
//  MovieAppNSB
//
//  Created by Baran Baran on 16.05.2024.
//

import UIKit
import CoreData



protocol DataManagerProtocol {
    func saveDatabase(model: Movie , completion: @escaping(Result<Void,Error>) -> Void)
    func fetchDatabase(completion: @escaping(Result<[DataEntities],Error>) -> Void)
    func deleteDatabase(deleteItem: DataEntities,completion: @escaping(Result<Void,Error>) -> Void)
}

final class DataManager{
    static let shared = DataManager()
    private init(){}
}


extension DataManager: DataManagerProtocol{
    
    // Kayıt etmek
    func saveDatabase(model: Movie , completion: @escaping(Result<Void,Error>) -> Void){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{return}
        let context = appDelegate.persistentContainer.viewContext
        
        let item = DataEntities(context: context)
        
        item.id = Int64(model.id)
        item.originalName = model.originalName
        item.originalTitle = model.originalTitle
        item.posterPath = model.posterPath
        
        do{
            try context.save()
            completion(.success(()))
        }catch{
            completion(.failure(error))
        }
    }
    
    
    // Alıp göstermek
    func fetchDatabase(completion: @escaping(Result<[DataEntities],Error>) -> Void){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{return}
        let context = appDelegate.persistentContainer.viewContext
        
        let request: NSFetchRequest<DataEntities> = DataEntities.fetchRequest()
        
        do{
            let data = try context.fetch(request)
            completion(.success(data))
        }catch{
            completion(.failure(error))
        }
        
    }
    
    // Silmek
    func deleteDatabase(deleteItem: DataEntities,completion: @escaping(Result<Void,Error>) -> Void){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{return}
        let context = appDelegate.persistentContainer.viewContext
        
        //belirli bir film verisini veritabanından silinir.
        context.delete(deleteItem)
        
        // bu silme işlemi kayıt edilir.
        do{
            try context.save()
            completion(.success(()))
        }catch{
            completion(.failure(error))
        }
    
    }
}






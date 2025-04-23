//
//  DataPersistenceManager.swift
//  cineby
//
//  Created by Rishav chandra on 23/04/25.
//

import UIKit
import CoreData

class DataPersistenceManager {
    
    enum dataManagerError: Error {
        case failedToSaveData
        case failedToFetchData
        case failedToDeleteData
    }
    
    static let shared = DataPersistenceManager()
    
    func downloadTitleWith(with model : Title , completion: @escaping (Result<Void,Error>)->Void){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let context = appDelegate.persistentContainer.viewContext
        let item = Titleitem(context: context)
        item.id = Int64(model.id)
        item.media_type = model.media_type
        item.original_name = model.original_name
        item.original_title = model.original_title
        item.overview = model.overview
        item.poster_path = model.poster_path
        
        do {
            try context.save()
            completion(.success(()))
        }catch{
            completion(.failure(dataManagerError.failedToSaveData))
        }
        
    }
    
    func fetchDatabase(completion: @escaping (Result<[Titleitem],Error>)->Void){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let context = appDelegate.persistentContainer.viewContext
        let request: NSFetchRequest<Titleitem>
        request = Titleitem.fetchRequest()
        do {
            let titles = try context.fetch(request)
            completion(.success(titles))
        }catch{
            completion(.failure(dataManagerError.failedToFetchData))
        }
    }
    
    func deleteItemfromDatabase(model: Titleitem , completion: @escaping (Result<Void , Error>)->Void){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let context = appDelegate.persistentContainer.viewContext
        context.delete(model)
        do{
            try context.save()
            completion(.success(()))
        }catch{
            completion(.failure(dataManagerError.failedToDeleteData))
        }
    }
}

//
//  StorageProvider.swift
//  CoreDataFundamentals
//
//  Created by Ankith on 28/06/24.
//

import CoreData

class StorageProvider{
    let persistentContainer: NSPersistentContainer
    
    init() {
        self.persistentContainer  = NSPersistentContainer(name: "CDFundamentals")
        
        persistentContainer.loadPersistentStores { description, error in
            
            if let error = error{
                fatalError("Core data failed to load with error: \(error)")
            }
        }
    }
}

extension StorageProvider{
    func saveMovie(named name:String){
        let movie = Movie(context:persistentContainer.viewContext)
        movie.name = name
        
        do{
            try persistentContainer.viewContext.save()
            debugPrint("Movie saved")
        }catch{
            persistentContainer.viewContext.rollback()
            debugPrint("error: \(error.localizedDescription)")
        }
    }
}

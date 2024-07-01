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
        
        
        ValueTransformer.setValueTransformer(UIImageTransformer(), forName: NSValueTransformerName("UIImageTransformer"))
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
        movie.title = name
        
        saveContext()
    }
    
    func getAllMovies()->[Movie]{
        let request:NSFetchRequest<Movie> = Movie.fetchRequest()
        
        do{
            let movies = try persistentContainer.viewContext.fetch(request)
            return movies
            
        }catch{
            debugPrint("Error: \(error.localizedDescription)")
            return []
        }
    }
    
    func deleteMovie(movie:Movie){
        persistentContainer.viewContext.delete(movie)
        saveContext()
    }
    
    func updateMovie(){
        saveContext()
    }
    
    fileprivate func saveContext() {
        do{
            try persistentContainer.viewContext.save()
        }catch{
            persistentContainer.viewContext.rollback()
            debugPrint("error deleting: \(error.localizedDescription)")
        }
    }
    
}

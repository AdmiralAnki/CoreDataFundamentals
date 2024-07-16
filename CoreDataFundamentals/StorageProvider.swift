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
        //        /request.predicate = NSPredicate(format: "", #keyPath(Movie.releaseDate))
        //        request.fetchLimit = 10
        //        request.fetchOffset = 10
        //        request.returnsObjectsAsFaults = false
        
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
    
    
    ///Compound Predicates demo
    func createCompoundPredicate(lowerBound:Date?,upperBound:Date?,rating:Int){
        
        let dateBetween:NSCompoundPredicate?
        var dateClauses = [NSPredicate]()
        
        if let lowerBound{
            let minDate = NSPredicate(format:"%K >= %@",
                                      #keyPath(Movie.releaseDate),
                                      lowerBound as NSDate)
            
            dateClauses.append(minDate)
        }
        
        
        if let upperBound{
            let maxDate = NSPredicate(format: "%K <= %@",
                                      #keyPath(Movie.releaseDate),
                                      upperBound as NSDate)
            
            dateClauses.append(maxDate)
            
        }
        
        if !dateClauses.isEmpty{
            dateBetween = NSCompoundPredicate(orPredicateWithSubpredicates: dateClauses)
            
            let rating = NSPredicate(format: "%K > %@", #keyPath(Movie.rating),
                                     rating)
            
            let compoundPred = NSCompoundPredicate(andPredicateWithSubpredicates: [dateBetween!,rating])
        }
        
        
    }
    
    func createSortDescriptors(){
        let request:NSFetchRequest<Movie> = Movie.fetchRequest()
        request.sortDescriptors = [
            NSSortDescriptor(keyPath: \Movie.releaseDate, ascending: false),
            NSSortDescriptor(keyPath: \Movie.rating, ascending: true)
        ]
    }
    
}

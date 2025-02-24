//
//  ListViewModel.swift
//  CoreDataFundamentals
//
//  Created by Ankith K on 29/06/24.
//

import Foundation

class ListViewModel{
    var storageProvider:StorageProvider
    var dataList = [Movie]()
    
    init(storageProvider:StorageProvider) {
        self.storageProvider = storageProvider
    }
    
    
    func loadData(){
        dataList = storageProvider.getAllMovies()
    }
    
    func removeData(at index:Int){
        let movie = self.dataList.remove(at: index)
        storageProvider.deleteMovie(movie: movie)
    }
}

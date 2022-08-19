//
//  DataBaseCRUD.swift
//  The Movie DB App
//
//  Created by Adriancys Jesus Villegas Toro on 18/8/22.
//

import CoreData
import UIKit

class DataBaseCRUD {
    //MARK: - properties
    
    static let share = DataBaseCRUD()
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    
    //MARK: - save
    
    func createObjec(movie: DetailModel) -> Bool{
        let newMovie = Movie(context: context)
        
        if let link = movie.posterPath{
            newMovie.imageMovie = String(describing:link)
        }
        newMovie.id = Int64(movie.id)
        newMovie.title = movie.originalTitle
        newMovie.adult = movie.adult
        newMovie.descriptionMovie = movie.overview ?? ""
        newMovie.popularity = movie.popularity
        newMovie.languageMovie = movie.originalLanguage
        newMovie.releaseDate = movie.releaseDate
        newMovie.genre = movie.genres.joined(separator: ",")
        return saveData()
    }
    
    //MARK: - SaveData
     
    func saveData() -> Bool{
        do{
            try context.save()
            return true
        }catch{
            _ = error.localizedDescription
            return false
        }
    }
    
    //MARK: - Delete
    
    func deleteData() {
        
    }
    
    //MARK: - LoadData
    
    func readData() -> [Movie]? {
        var result: [Movie]? = []
        let request: NSFetchRequest<Movie> = Movie.fetchRequest()
        
        do{
            result = try context.fetch(request)
        }catch{
            _ = error.localizedDescription
        }
        return result
    }
}

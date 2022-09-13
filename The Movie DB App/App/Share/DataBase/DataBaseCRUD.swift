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

    
    //MARK: - saveMovie
    
    func saveMovie(movie: DetailModel) -> Bool{
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
    
    // MARK: - saveTvShow
    
    func saveTVShow(model: TVShowsDetailResponse) -> Bool {
        var genres: [String] = []
        let tvShow = TVShow(context: context)
        tvShow.id = Int64(model.id)
        tvShow.language = model.originalLanguage
        tvShow.title = model.originalName
        tvShow.number_Seasons = Int64(model.numberOfSeasons ?? 1)
        tvShow.number_episodes = Int64(model.numberOfEpisodes ?? 1)
        tvShow.overview = model.overview
        tvShow.popularity = model.popularity
        tvShow.image = model.posterPath
        for genre in model.genres{
            genres.append(genre.name)
        }
        tvShow.genre = genres.joined(separator:",")
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
    
    //MARK: - getMovieSaved
    
    func getMovieSaved() -> [Movie]? {
        var result: [Movie]? = []
        let request: NSFetchRequest<Movie> = Movie.fetchRequest()
        
        do{
            result = try context.fetch(request)
        }catch{
            _ = error.localizedDescription
        }
        return result
    }
    
    func getTVShowSaved() -> [TVShow]? {
        var result: [TVShow] = []
        
        let request: NSFetchRequest<TVShow> = TVShow.fetchRequest()
        do{
            result = try context.fetch(request)
        }catch{
            _ = error.localizedDescription
        }
        return result
    }
    
    
}

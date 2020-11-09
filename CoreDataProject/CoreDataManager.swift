//
//  CoreDataManager.swift
//  CoreDataProject
//
//  Created by Field Employee on 11/6/20.
//

import Foundation
import UIKit
import CoreData

class CoreDataManager {
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CoreDataProject")
        
        container.loadPersistentStores { (description, error) in
            if let error = error {
                fatalError("Something went very wrong")
            }
        }
        return container
    }()
    
    func saveContext() {
        let context = self.persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                fatalError("Error: \(error.localizedDescription)")
            }
        }
    }
    
    func saveSong(songInf: songInfo){
        let context = persistentContainer.viewContext
        guard let entity = NSEntityDescription.entity(forEntityName: "Song", in: context) else {return}
        let song = Song(entity: entity, insertInto: context)
        song.artistName = songInf.artistName
        song.artworkUrl100 = songInf.artworkUrl100
        song.collectionName = songInf.collectionName
//        songInf.genres.forEach{
//            song.genre = song.genre! + $0.name + "/"
////        }
//        song.genre = String(song.genre!.dropLast())
        song.name = songInf.name
        song.releaseDate = songInf.releaseDate
        song.favorite = false
    }
    
    func getSongList() -> [Song] {
        let context = persistentContainer.viewContext
        let request: NSFetchRequest<Song> = Song.fetchRequest()
        do {
            let results = try context.fetch(request)
//In case you want to delete all entries
//            results.forEach{
//                context.delete($0)
//            }
            self.saveContext()
            return results
        } catch {
            print(error.localizedDescription)
        }
        return []
    }
}

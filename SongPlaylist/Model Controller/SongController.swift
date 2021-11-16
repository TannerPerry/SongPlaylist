//
//  SongController.swift
//  SongPlaylist
//
//  Created by Tanner Perry on 11/16/21.
//

import Foundation

class SongController {
    // shared Instance
   static let shared = SongController()
    
    // SOT
    var songs: [Song] = []
    
    // CRUD
    
    // Create
    func createSong(title: String, artistName: String) {
        let newSong = Song(title: title, artistName: artistName)
        songs.append(newSong)
        saveToPersistanceStore()
    }
    // Delete
    func deleteSong(song: Song) {
        guard let index = songs.firstIndex(of: song) else { return }
        songs.remove(at: index)
        saveToPersistanceStore()
    }
    
    // MARK: Persistance
    
    // persistance store
    func persistantStore() -> URL {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        
        let fileUrl = urls[0].appendingPathComponent("SongPlaylist.json")
        return fileUrl
    }
    
    // Save
    func saveToPersistanceStore() {
        do {
            let data = try JSONEncoder().encode(songs)
            try data.write(to: persistantStore())
        } catch let saveError {
            print("we had an error saving to out persistance store.")
            print(saveError)
            print(saveError.localizedDescription)
            
        }
    }
    
    // Load
    func loadFromPersistanceStore() {
        do {
            let data = try Data(contentsOf: persistantStore())
            songs = try JSONDecoder().decode([Song].self, from: data)
        } catch {
            print("we had a error loading our data from the persistance store.")
            print(error)
            print(error.localizedDescription)
        }
    }
}

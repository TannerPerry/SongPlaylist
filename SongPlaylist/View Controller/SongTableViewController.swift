//
//  SongTableViewController.swift
//  SongPlaylist
//
//  Created by Tanner Perry on 11/16/21.
//

import UIKit

class SongTableViewController: UITableViewController {
    
    @IBOutlet weak var songTitleTextField: UITextField!
    @IBOutlet weak var artistNameTextField: UITextField!
    
    var playlist: Playlist?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func addSongButtonTapped(_ sender: Any) {
        guard let songTitle = songTitleTextField.text,
              let songArtist = artistNameTextField.text,
              !songTitle.isEmpty,
              !songArtist.isEmpty,
              let playlist = playlist else { return }
        SongController.createSong(title: songTitle, artistName: songArtist, playlist: playlist)
        songTitleTextField.text = ""
        artistNameTextField.text = ""
        tableView.reloadData()
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return playlist?.songs.count ?? 0
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "songCell", for: indexPath)
        
        guard  let playlist = playlist else { return cell }
        
        let song = playlist.songs[indexPath.row]
        
        cell.textLabel?.text = song.title
        cell.detailTextLabel?.text = song.artistName
        
        return cell
    }
    
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard let playlist = playlist else { return }
            let songToDelete = playlist.songs[indexPath.row]
            SongController.deleteSong(song: songToDelete, playlist: playlist)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}

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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SongController.shared.loadFromPersistanceStore()
    }
    
    @IBAction func addSongButtonTapped(_ sender: Any) {
        guard let songTitle = songTitleTextField.text,
              let songArtist = artistNameTextField.text,
              !songTitle.isEmpty,
              !songArtist.isEmpty else { return }
        
        SongController.shared.createSong(title: songTitle, artistName: songArtist)
        songTitleTextField.text = ""
        artistNameTextField.text = ""
        tableView.reloadData()
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SongController.shared.songs.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "songCell", for: indexPath)

        let song = SongController.shared.songs[indexPath.row]
        
        cell.textLabel?.text = song.title
        cell.detailTextLabel?.text = song.artistName

        return cell
    }


    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let songToDelete = SongController.shared.songs[indexPath.row]
            SongController.shared.deleteSong(song: songToDelete)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}

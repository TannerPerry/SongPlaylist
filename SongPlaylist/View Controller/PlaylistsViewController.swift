//
//  PlaylistsViewController.swift
//  SongPlaylist
//
//  Created by Tanner Perry on 11/16/21.
//

import UIKit

class PlaylistsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {


    @IBOutlet weak var playlistNameTextField: UITextField!
    @IBOutlet weak var playlistTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playlistTableView.delegate = self
        playlistTableView.dataSource = self
        PlaylistController.shared.loadFromPersistanceStore()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        playlistTableView.reloadData()
    }
    
    @IBAction func addPlaylistButtonTapped(_ sender: Any) {
        guard let playlistName = playlistNameTextField.text, !playlistName.isEmpty else { return }
        PlaylistController.shared.createPlaylist(name: playlistName)
        playlistTableView.reloadData()
        playlistNameTextField.text = ""
    }
    
    // MARK: TableView Data Source Functions
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return PlaylistController.shared.playlists.count
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = playlistTableView.dequeueReusableCell(withIdentifier: "playlistCell", for: indexPath)
        
        let playlist = PlaylistController.shared.playlists[indexPath.row]
        cell.textLabel?.text = playlist.name
        if playlist.songs.count == 1 {
            cell.detailTextLabel?.text = "\(playlist.songs.count) song"
        } else {
            cell.detailTextLabel?.text = "\(playlist.songs.count) songs"
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let playlistToDelete = PlaylistController.shared.playlists[indexPath.row]
            PlaylistController.shared.deletePlaylist(playlist: playlistToDelete)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //IIDOO
        if segue.identifier == "toSongsList"{
            guard let indexPath = playlistTableView.indexPathForSelectedRow,
                  let destination = segue.destination as? SongTableViewController else {
                return }
            let playlist = PlaylistController.shared.playlists[indexPath.row]
            destination.playlist = playlist
        }
    }
    

}

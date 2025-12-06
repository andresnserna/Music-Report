//
//  MusicPickerViewController.swift
//  Music Report
//
//  Created by Andrés Serna on 12/1/25.
//

import UIKit

protocol MusicPickerDelegate: AnyObject {
    func didSelectMusic(_ music: Music_fromJSON)
}

class MusicPickerViewController: UITableViewController, UISearchBarDelegate {

    var allMusic = [Music_fromJSON]()
    var filteredMusic = [Music_fromJSON]()
    var isSearching = false
    
    weak var delegate: MusicPickerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load all music from JSON
        allMusic = loadMusic()
        filteredMusic = allMusic
        
        // Set up search bar
        if let searchBar = tableView.tableHeaderView as? UISearchBar {
            searchBar.delegate = self
        }
    }

// Table view ovverides

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isSearching ? filteredMusic.count : allMusic.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let music = isSearching ? filteredMusic[indexPath.row] : allMusic[indexPath.row]
        
        // Check if it's a song or album based on whether track_name exists
        if let trackName = music.track_name, !trackName.isEmpty {
            // It's a song
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "SongCell", for: indexPath) as? SongCell else {
                return UITableViewCell()
            }
            cell.configure(with: music)
            return cell
        } else {
            // It's an album
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "AlbumCell", for: indexPath) as? AlbumCell else {
                return UITableViewCell()
            }
            cell.configure(with: music)
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedMusic = isSearching ? filteredMusic[indexPath.row] : allMusic[indexPath.row]
            
        delegate?.didSelectMusic(selectedMusic)
        dismiss(animated: true, completion: nil)
    }
    
//searchbar functions
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            isSearching = false
            filteredMusic = allMusic
        } else {
            isSearching = true
            filteredMusic = allMusic.filter { music in
                //trackname is optional so there will be cases the 
                music.track_name?.lowercased().contains(searchText.lowercased()) ?? false ||
                music.album_name.lowercased().contains(searchText.lowercased()) ||
                music.artist.lowercased().contains(searchText.lowercased())
            }
        }
        tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        isSearching = false
        filteredMusic = allMusic
        searchBar.resignFirstResponder()
        tableView.reloadData()
    }

}

//
//  MyStuffViewController.swift
//  Music Report
//
//  Created by Andrés Serna on 11/24/25.
//

import UIKit

class MyStuffViewController: UIViewController {
    
    var music: Music_fromJSON?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let username = activeUser {
            lbl_activeUsername.text = "@\(username)"
        }
        
        populateLabels()
    }
    
    // In FeedViewController
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let username = activeUser {
            lbl_activeUsername.text = "@\(username)"
        }
        
        populateLabels()
    }
        
    @IBOutlet weak var lbl_activeUsername: UILabel!
    
    //TOP GENRES
    @IBOutlet weak var lbl_topGenre1: UILabel!
    @IBOutlet weak var lbl_topGenre2: UILabel!
    @IBOutlet weak var lbl_topGenre3: UILabel!
    
    //TOP SONGS
    @IBOutlet weak var lbl_topSong1: UILabel!
    @IBOutlet weak var lbl_topSongAlbum1: UILabel!
    @IBOutlet weak var img_topSongImage1: UIImageView!
    
    @IBOutlet weak var lbl_topSong2: UILabel!
    @IBOutlet weak var lbl_topSongAlbum2: UILabel!
    @IBOutlet weak var img_topSongImage2: UIImageView!
    
    @IBOutlet weak var lbl_topSong3: UILabel!
    @IBOutlet weak var lbl_topSongAlbum3: UILabel!
    @IBOutlet weak var img_topSongImage3: UIImageView!
    
    @IBOutlet weak var lbl_topSong4: UILabel!
    @IBOutlet weak var lbl_topSongAlbum4: UILabel!
    @IBOutlet weak var img_topSongImage4: UIImageView!
    
    @IBOutlet weak var lbl_topSong5: UILabel!
    @IBOutlet weak var lbl_topSongAlbum5: UILabel!
    @IBOutlet weak var img_topSongImage5: UIImageView!
    
    //TOP ALBUMS
    @IBOutlet weak var lbl_topAlbum1: UILabel!
    @IBOutlet weak var img_topAlbumImage1: UIImageView!
    
    @IBOutlet weak var lbl_topAlbum2: UILabel!
    @IBOutlet weak var img_topAlbumImage2: UIImageView!
    
    @IBOutlet weak var lbl_topAlbum3: UILabel!
    @IBOutlet weak var img_topAlbumImage3: UIImageView!

    func populateLabels() {
        // Load all music from JSON and ilter only songs in the user's library
        let libraryMusic = loadMusic().filter { $0.in_library }
        
        // Get top songs, genres, and albums
        let myTop3Genres = top3Genres(music: libraryMusic)
        let myTop5Songs = top5Songs(music: libraryMusic)
        let myTop3Albums = top3Albums(music: libraryMusic)
        
        // Populate genre labels, using this weird for-switch loop-case because can't loop a call to an element by its name. would be nice if i could tho.
        for (index, genre) in myTop3Genres.prefix(3).enumerated() {
            switch index {
                case 0: lbl_topGenre1.text = genre
                case 1: lbl_topGenre2.text = genre
                case 2: lbl_topGenre3.text = genre
                default: break
            }
        }
        
        // Populate song labels with images
        for (index, song) in myTop5Songs.prefix(5).enumerated() {
            updateSongLabel(rank: index + 1, music: song)
        }
        
        // Populate album labels with images
        for (index, album) in myTop3Albums.prefix(3).enumerated() {
            updateAlbumLabel(rank: index + 1, music: album)
        }
    }

    // Helper function to update song labels and images
    func updateSongLabel(rank: Int, music: Music_fromJSON) {
        switch rank {
        case 1:
            lbl_topSong1.text = music.track_name
            lbl_topSongAlbum1.text = music.album_name
            img_topSongImage1.image = UIImage(named: music.album_art_file)
        case 2:
            lbl_topSong2.text = music.track_name
            lbl_topSongAlbum2.text = music.album_name
            img_topSongImage2.image = UIImage(named: music.album_art_file)
        case 3:
            lbl_topSong3.text = music.track_name
            lbl_topSongAlbum3.text = music.album_name
            img_topSongImage3.image = UIImage(named: music.album_art_file)
        case 4:
            lbl_topSong4.text = music.track_name
            lbl_topSongAlbum4.text = music.album_name
            img_topSongImage4.image = UIImage(named: music.album_art_file)
        case 5:
            lbl_topSong5.text = music.track_name
            lbl_topSongAlbum5.text = music.album_name
            img_topSongImage5.image = UIImage(named: music.album_art_file)
        default:
            break
        }
    }

    // Helper function to update album labels and images
    func updateAlbumLabel(rank: Int, music: Music_fromJSON) {
        switch rank {
        case 1:
            lbl_topAlbum1.text = music.album_name
            img_topAlbumImage1.image = UIImage(named: music.album_art_file)
        case 2:
            lbl_topAlbum2.text = music.album_name
            img_topAlbumImage2.image = UIImage(named: music.album_art_file)
        case 3:
            lbl_topAlbum3.text = music.album_name
            img_topAlbumImage3.image = UIImage(named: music.album_art_file)
        default:
            break
        }
    }

    // Update your finder functions to return Music_fromJSON objects instead of strings
    func top3Genres(music: [Music_fromJSON]) -> [String] {
        // Count genre occurrences weighted by play_count
        var genreCounts: [String: Int] = [:]
        for song in music {
            let count = song.play_count ?? 0
            genreCounts[song.track_genre, default: 0] += count
        }
        
        // Sort by count and return top 3
        return genreCounts.sorted { $0.value > $1.value }
            .prefix(3)
            .map { $0.key }
    }

    func top5Songs(music: [Music_fromJSON]) -> [Music_fromJSON] {
        return music
            .sorted { ($0.play_count ?? 0) > ($1.play_count ?? 0) }
            .prefix(5)
            .map { $0 }
    }

    func top3Albums(music: [Music_fromJSON]) -> [Music_fromJSON] {
        // grouping by album and sum play counts, keeping the track with most plays as representative
        var albumData: [String: (representativeSong: Music_fromJSON, totalPlays: Int)] = [:]
        
        for song in music {
            let plays = song.play_count ?? 0
            if let existing = albumData[song.album_name] {
                let newTotal = existing.totalPlays + plays
                // Keep the song with higher individual play count as the representative
                let representative = (song.play_count ?? 0) > (existing.representativeSong.play_count ?? 0) ? song : existing.representativeSong
                albumData[song.album_name] = (representative, newTotal)
            } else {
                albumData[song.album_name] = (song, plays)
            }
        }
        
        // Sort by total plays and return top 3
        return albumData.values
            .sorted { $0.totalPlays > $1.totalPlays }
            .prefix(3)
            .map { $0.representativeSong }
    }
}

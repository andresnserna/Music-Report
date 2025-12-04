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
    }
    
    // In FeedViewController
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let username = activeUser {
            lbl_activeUsername.text = "@\(username)"
        }
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
        guard let music = music else { print("error loading music from JSON"); return }

        //grab top 3 genres from this finder function, and their image strings
        let myTop3Genres: [String] = top3Genres(music: music)

        //grab top 5 songs from this finder function
        let myTop5Songs: [String] = top5Songs(music: music)
                
        //grab top 3 albums from this finder function
        let myTop3Albums: [String] = top3Albums(music: music)
        
        //populate the genre labels
        lbl_topGenre1.text = myTop3Genres[0]
        lbl_topGenre2.text = myTop3Genres[1]
        lbl_topGenre3.text = myTop3Genres[2]
        
        //populate the song labels
        lbl_topSong1.text = myTop5Songs[0]
        lbl_topSong2.text = myTop5Songs[1]
        lbl_topSong3.text = myTop5Songs[2]
        lbl_topSong4.text = myTop5Songs[3]
        lbl_topSong5.text = myTop5Songs[4]

        //populate the album labels
        lbl_topAlbum1.text = myTop3Albums[0]
        lbl_topAlbum2.text = myTop3Albums[1]
        lbl_topAlbum3.text = myTop3Albums[2]
    }
    
    func top3Genres(music: Music_fromJSON?) -> [String] {
        var myTop3Genres: [String] = []
        
        //query the json database
        
        return myTop3Genres
    }
    
    func top5Songs(music: Music_fromJSON?) -> [String] {
        var myTop5Songs: [String] = []
        
        //query the json database

        return myTop5Songs
    }
    
    func top3Albums(music: Music_fromJSON?) -> [String] {
        var myTop3Albums: [String] = []
        
        //query the json database

        return myTop3Albums
    }
}

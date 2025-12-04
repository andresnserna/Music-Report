//
//  SongPostCell.swift
//  Music Report
//
//  Created by Andrés Serna on 12/3/25.
//

import UIKit

class SongPostCell: UITableViewCell {
    
    @IBOutlet weak var lbl_username: UILabel!
    @IBOutlet weak var lbl_date: UILabel!
    @IBOutlet weak var lbl_postText: UILabel!
    @IBOutlet weak var img_albumArt: UIImageView!
    @IBOutlet weak var lbl_songName: UILabel!
    @IBOutlet weak var lbl_albumName: UILabel!
    
    func configure(with post: Post, music: Music_fromJSON?) {
        lbl_username.text = "@\(post.username ?? "Unknown")"
        lbl_postText.text = post.text
        
        if let date = post.date {
            let formatter = DateFormatter()
            formatter.dateFormat = "MMM d, h:mm a"
            lbl_date.text = formatter.string(from: date)
        }
        
        if let music = music {
            lbl_songName.text = "\(music.track_name) - \(music.artist)"
            lbl_albumName.text = music.album_name
            img_albumArt.image = UIImage(named: music.album_art_file)
        }
    }
}

//
//  SongCell.swift
//  Music Report
//
//  Created by Andrés Serna on 12/5/25.
//

import UIKit

class SongCell: UITableViewCell {
    @IBOutlet weak var lbl_songName: UILabel!
    @IBOutlet weak var lbl_artistName: UILabel!
    @IBOutlet weak var img_albumImage: UIImageView!
    
    func configure(with music: Music_fromJSON) {
        lbl_songName.text = music.track_name
        lbl_artistName.text = music.artist
        img_albumImage.image = UIImage(named: music.album_name)
    }
}

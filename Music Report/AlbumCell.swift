//
//  AlbumCell.swift
//  Music Report
//
//  Created by Andrés Serna on 12/5/25.
//

import UIKit

class AlbumCell: UITableViewCell {
    @IBOutlet weak var lbl_albumName: UILabel!
    @IBOutlet weak var img_albumImage: UIImageView!
    
    func configure(with music: Music_fromJSON) {
        lbl_albumName.text = music.album_name
        img_albumImage.image = UIImage(named: music.album_art_file)
    }
}

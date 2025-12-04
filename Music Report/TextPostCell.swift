//
//  TextPostCell.swift
//  Music Report
//
//  Created by Andrés Serna on 12/3/25.
//

import UIKit

class TextPostCell: UITableViewCell {
    
    @IBOutlet weak var lbl_username: UILabel!
    @IBOutlet weak var lbl_date: UILabel!
    @IBOutlet weak var lbl_postText: UILabel!

    func configure(with post: Post) {
        lbl_username.text = "@\(post.username ?? "Unknown")"
        lbl_postText.text = post.text
        
        if let date = post.date {
            let formatter = DateFormatter()
            formatter.dateFormat = "MMM d, h:mm a"
            lbl_date.text = formatter.string(from: date)
        }
    }
}

//
//  HotEventCell.swift
//  Music Report
//
//  Created by Andrés Serna on 12/4/25.
//

import UIKit

class HotEventCell: UITableViewCell {
    
    @IBOutlet weak var lbl_eventName: UILabel!
    @IBOutlet weak var img_partyPopper: UIImageView!
    
    func configure(with event: Events_fromJSON) {
        lbl_eventName.text = event.name
    }
}

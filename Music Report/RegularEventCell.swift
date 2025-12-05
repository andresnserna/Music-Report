//
//  RegularEventCell.swift
//  Music Report
//
//  Created by Andrés Serna on 12/4/25.
//

import UIKit

class RegularEventCell: UITableViewCell {
    
    @IBOutlet weak var lbl_eventName: UILabel!
        
    func configure(with event: Events_fromJSON) {
        lbl_eventName.text = event.name
    }
}

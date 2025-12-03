//
//  NewPostViewController.swift
//  Music Report
//
//  Created by Andrés Serna on 11/24/25.
//

import UIKit

class NewPostViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
        
    @IBOutlet weak var txtV_postBody: UITextView!
    
    @IBOutlet weak var btn_attachedMusicImage: UIButton!
    @IBOutlet weak var lbl_attachedMusicTitle: UILabel!
    @IBOutlet weak var lbl_attachedMusicSubtitle: UILabel!
    @IBAction func btn_postIt(_ sender: UIButton) {
    }
    
}

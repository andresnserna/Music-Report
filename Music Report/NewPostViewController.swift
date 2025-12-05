//
//  NewPostViewController.swift
//  Music Report
//
//  Created by Andrés Serna on 11/24/25.
//

import UIKit

class NewPostViewController: UIViewController {
    
    var selectedMusic: Music_fromJSON?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
        
    @IBOutlet weak var txtV_postBody: UITextView!
    
    @IBOutlet weak var btn_attachedMusicImage: UIButton!
    @IBOutlet weak var lbl_attachedMusicTitle: UILabel!
    @IBOutlet weak var lbl_attachedMusicSubtitle: UILabel!
    @IBAction func btn_postIt(_ sender: UIButton) {
        // Check that post body has text
        guard let postText = txtV_postBody.text, !postText.isEmpty else {
            let alertview = UIAlertController(title: "Error", message: "Please write something in your post", preferredStyle: .alert)
            alertview.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alertview, animated: true)
            return
        }
        
        let newPost = Post(context: context)
        newPost.post_ID = UUID()
        newPost.username = activeUser
        newPost.text = postText
        newPost.date = Date()
        
        // Determine post type based on whether music is attached
        if let music = selectedMusic {
            newPost.post_type = "song" // or determine if album
            newPost.music_ID = music.music_ID
        } else {
            newPost.post_type = "text"
            newPost.music_ID = nil
        }
        
        do {
            try context.save()
            print("Post saved successfully")
            
            // Clear the form
            txtV_postBody.text = ""
            lbl_attachedMusicTitle.text = "Music Title"
            lbl_attachedMusicSubtitle.text = "Music Subtitle"
            
            // Go back to feed
            navigationController?.popViewController(animated: true)
            
        } catch {
            print("Error saving Post: \(error)")
            let alertview = UIAlertController(title: "Error", message: "Failed to save post", preferredStyle: .alert)
            alertview.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alertview, animated: true)
        }
    }
    
}

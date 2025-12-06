//
//  NewPostViewController.swift
//  Music Report
//
//  Created by Andrés Serna on 11/24/25.
//

import UIKit

class NewPostViewController: UIViewController, MusicPickerDelegate {
    
    var selectedMusic: Music_fromJSON?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
        
    @IBOutlet weak var txtV_postBody: UITextView!
    
    @IBAction func btn_attachMusic(_ sender: UIButton) {
        performSegue(withIdentifier: "showMusicPicker", sender: nil)
    }
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
            if music.track_name != nil && !music.track_name!.isEmpty {
                newPost.post_type = "song"
            } else {
                newPost.post_type = "album"
            }
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
    
    func updateMusicDisplay() {
        guard let music = selectedMusic else { return }
        print("DEBUG: updateMusicDisplay called")
        print("DEBUG: track_name = \(music.track_name ?? "unknown")")
        
        // Update the labels
        if let trackName = music.track_name, !trackName.isEmpty {
            // for songs
            print("DEBUG: Setting song title to: \(trackName)")
            lbl_attachedMusicTitle.text = trackName
            lbl_attachedMusicSubtitle.text = music.album_name
        } else {
            // for lbums
            print("DEBUG: Setting album title to: \(music.album_name)")
            lbl_attachedMusicTitle.text = music.album_name
            lbl_attachedMusicSubtitle.text = music.artist
        }
        print("DEBUG: Final label text = \(lbl_attachedMusicTitle.text ?? "nil")")

        // Update button to show album art instead of icon
        if let albumArtImage = UIImage(named: music.album_art_file) {
            btn_attachedMusicImage.setImage(albumArtImage, for: .normal)
            btn_attachedMusicImage.setTitle("", for: .normal)
        }
    }
    
    func didSelectMusic(_ music: Music_fromJSON) {
        selectedMusic = music
        updateMusicDisplay()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showMusicPicker" {
            if let musicPickerVC = segue.destination as? MusicPickerViewController {
                musicPickerVC.delegate = self
            }
        }
    }
    
}

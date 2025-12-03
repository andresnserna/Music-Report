//
//  FeedViewController.swift
//  Music Report
//
//  Created by Andrés Serna on 11/24/25.
//

import UIKit
import CoreData

class FeedViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var posts = [Post]()  // Array to hold your posts
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let post = posts[indexPath.row]

        // Determine which cell type to use based on post_type
        let cellIdentifier: String
        
        switch post.post_type {
        case "text":
            cellIdentifier = "TextPostCell"
        case "music":
            cellIdentifier = "MusicPostCell"
        case "album":
            cellIdentifier = "AlbumPostCell"
        default:
            cellIdentifier = "TextPostCell"  // Default fallback
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        
        // Configure the cell based on type
        // You'll customize this based on your cell design
        if let textLabel = cell.textLabel {
            textLabel.text = post.text
        }
        
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let username = activeUser {
            lbl_activeUsername.text = "@\(username)"
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let username = activeUser {
            lbl_activeUsername.text = "@\(username)"
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
            return 1
    }
    
    func loadPosts() {
        let fetchRequest: NSFetchRequest<Post> = Post.fetchRequest()
        
        // Add sorting by date (newest first)
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
        
        do {
            posts = try context.fetch(fetchRequest)
            tbl_postItems.reloadData()
        } catch {
            print("Error fetching posts: \(error)")
        }
    }
    
    @IBAction func seg_feedPicker(_ sender: UISegmentedControl) {
        // Filter posts based on segment selection
        if sender.selectedSegmentIndex == 0 {
            // Home feed - show all posts
            loadPosts()
        } else {
            // New feed - maybe filter by recent or followed users
            loadPosts()
        }
    }
    @IBAction func btn_newPost(_ sender: UIButton) {
    }
    
    @IBOutlet weak var lbl_activeUsername: UILabel!
    
    @IBOutlet weak var tbl_postItems: UITableView!

}

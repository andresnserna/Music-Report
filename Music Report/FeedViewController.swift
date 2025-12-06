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
        
        switch post.post_type {
        case "text":
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "TextPostCell", for: indexPath) as? TextPostCell else {
                print("ERROR: Could not dequeue TextPostCell")
                return UITableViewCell()
            }
            cell.configure(with: post)
            return cell
            
        case "song":
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "SongPostCell", for: indexPath) as? SongPostCell else {
                print("ERROR: Could not dequeue SongPostCell")
                return UITableViewCell()
            }
            
            // Load music data
            var musicData: Music_fromJSON? = nil
            if let musicID = post.music_ID {
                let allMusic = loadMusic()
                musicData = allMusic.first { $0.music_ID == musicID }
            }
            
                cell.configure(with: post, Music: musicData)
            return cell
            
        case "album":
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "AlbumPostCell", for: indexPath) as? AlbumPostCell else {
                print("ERROR: Could not dequeue AlbumPostCell")
                return UITableViewCell()
            }
            
            // Load music data
            var musicData: Music_fromJSON? = nil
            if let musicID = post.music_ID {
                let allMusic = loadMusic()
                musicData = allMusic.first { $0.music_ID == musicID }
            }
            
            cell.configure(with: post, music: musicData)
            return cell
            
        default:
            // Fallback to text cell
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "TextPostCell", for: indexPath) as? TextPostCell else {
                return UITableViewCell()
            }
            cell.configure(with: post)
            return cell
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let username = activeUser {
            lbl_activeUsername.text = "@\(username)"
        }
        
        // Set up table view
        tbl_postItems.dataSource = self
        tbl_postItems.delegate = self
        tbl_postItems.estimatedRowHeight = 138 //height of post cell in the interface builder
        
        // Load posts from JSON into Core Data (do this once)
        loadPostsFromJSON()
        
        // Set segmented control to home by default
        seg_feedPicker.selectedSegmentIndex = 0
        
        // Trigger the filter for home feed
        seg_feedPicker.sendActions(for: .valueChanged)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let username = activeUser {
            lbl_activeUsername.text = "@\(username)"
        }
        
        refreshPosts()
        
        // go back to last section picked in the picker
        seg_feedPicker.sendActions(for: .valueChanged)

    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
            return 1
    }
    
    func loadPostsFromJSON() {
        // Check if posts already exist in Core Data
        let fetchRequest: NSFetchRequest<Post> = Post.fetchRequest()
        let existingPostCount = (try? context.count(for: fetchRequest)) ?? 0
        
        if existingPostCount > 0 {
            print("Posts already loaded in Core Data")
            return
        }
        
        // Load posts from JSON
        let jsonPosts = loadPosts()
        
        for jsonPost in jsonPosts {
            let newPost = Post(context: context)
            newPost.post_ID = UUID(uuidString: jsonPost.post_ID)
            newPost.username = jsonPost.username
            newPost.post_type = jsonPost.post_type
            newPost.text = jsonPost.text
            newPost.music_ID = jsonPost.music_ID
            
            // Convert ISO8601 date
            let dateFormatter = ISO8601DateFormatter()
            newPost.date = dateFormatter.date(from: jsonPost.date)
        }
        
        // Save to Core Data
        do {
            try context.save()
            print("Successfully loaded \(jsonPosts.count) posts from JSON")
        } catch {
            print("Error saving posts to Core Data: \(error)")
        }
    }
    
    func refreshPosts() {
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
        let fetchRequest: NSFetchRequest<Post> = Post.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
        
        // Load all music data to check in_library status
        let allMusic = loadMusic()
        
        if sender.selectedSegmentIndex == 0 {
            // Home feed - show posts of music only in library
            do {
                let allPosts = try context.fetch(fetchRequest)
                posts = allPosts.filter { post in
                    
                    guard let musicID = post.music_ID else {
                        // INCLUDE text posts (no music_ID)
                        return true
                    }
                    
                    // Check if music is in library
                    return allMusic.first(where: { $0.music_ID == musicID })?.in_library == true
                }
                
                tbl_postItems.reloadData()
                
            } catch {
                print("Error fetching posts: \(error)")
            }
        } else {
            // New feed - show posts only of music not in library
            do {
                let allPosts = try context.fetch(fetchRequest)
                //print("DEBUG: Total posts fetched: \(allPosts.count)")
                
                posts = allPosts.filter { post in
                    guard let musicID = post.music_ID else {
                        return false
                    }
                    let musicItem = allMusic.first(where: { $0.music_ID == musicID })
                    //print("DEBUG NEW: Post \(post.post_ID?.uuidString ?? "unknown") | Music ID: \(musicID) | In Library: \(musicItem?.in_library ?? false)")
                    return musicItem?.in_library == false
                }
                
                //print("DEBUG: New feed posts count: \(posts.count)")
                tbl_postItems.reloadData()
                
            } catch {
                print("Error fetching posts: \(error)")
            }
        }
    }
    @IBAction func btn_newPost(_ sender: UIButton) {
    }
    
    @IBOutlet weak var seg_feedPicker: UISegmentedControl!
    @IBOutlet weak var lbl_activeUsername: UILabel!
    
    @IBOutlet weak var tbl_postItems: UITableView!

}

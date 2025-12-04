//
//  JSONLoader.swift
//  Music Report
//
//  Created by Andrés Serna on 12/3/25.
//

import Foundation

struct Post_fromJSON: Codable {
    //can i name this "Post"? it says that's invalid redeclaration
}

struct Music_fromJSON: Codable {
    
}

struct Events_fromJSON: Codable {
    
}

func loadPosts() -> [Post_fromJSON] {
    //MAKE SURE TO CHANGE THE RESOURCE NAME ONCE YOU FINALIZE THE POST DATABASE
    guard let url = Bundle.main.url(forResource: "posts_TEST", withExtension: "json") else {
        print("posts_TEST.json not found in app bundle")
        return []
    }

    do {
        let data = try Data(contentsOf: url)
        let posts = try JSONDecoder().decode([Post_fromJSON].self, from: data)
        print("posts loaded successfully")
        return posts
    } catch {
        print("Failed to decode posts_TEST.json: \(error)")
        return []
    }
}

func loadMusic() -> [Music_fromJSON] {
    //MAKE SURE TO CHANGE THE RESOURCE NAME ONCE YOU FINALIZE THE POST DATABASE
    guard let url = Bundle.main.url(forResource: "music_TEST", withExtension: "json") else {
        print("music_TEST.json not found in app bundle")
        return []
    }

    do {
        let data = try Data(contentsOf: url)
        let music = try JSONDecoder().decode([Music_fromJSON].self, from: data)
        print("music loaded successfully")
        return music
    } catch {
        print("Failed to decode music_TEST.json: \(error)")
        return []
    }
}

func loadEvents() -> [Events_fromJSON] {
    //MAKE SURE TO CHANGE THE RESOURCE NAME ONCE YOU FINALIZE THE POST DATABASE
    guard let url = Bundle.main.url(forResource: "events_TEST", withExtension: "json") else {
        print("events_TEST.json not found in app bundle")
        return []
    }

    do {
        let data = try Data(contentsOf: url)
        let events = try JSONDecoder().decode([Events_fromJSON].self, from: data)
        print("events loaded successfully")
        return events
    } catch {
        print("Failed to decode events_TEST.json: \(error)")
        return []
    }
}

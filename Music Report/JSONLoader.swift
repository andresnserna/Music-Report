//
//  JSONLoader.swift
//  Music Report
//
//  Created by Andrés Serna on 12/3/25.
//

import Foundation

struct Post_fromJSON: Codable {
    let post_ID: String
    let username: String
    let post_type: String
    let text: String?
    let date: String  // ISO8601 date string
    let music_ID: String?
}

struct Music_fromJSON: Codable {
    let music_ID: String
    let artist: String
    let album_name: String
    let track_name: String?
    let track_genre: String
    let album_art_file: String
    let in_library: Bool
    let play_count: Int?
}

struct Events_fromJSON: Codable {
    let name: String
    let event_description: String
    let address: String
    let date_START: String  // ISO8601 date string
    let date_END: String    // ISO8601 date string
    let hot_event: Bool
    let event_LAT: Double
    let event_LON: Double

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

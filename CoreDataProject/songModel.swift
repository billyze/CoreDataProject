//
//  songModel.swift
//  CoreDataProject
//
//  Created by Field Employee on 11/7/20.
//

import Foundation

struct songModel: Codable {
    var feed: results
}

struct results: Codable {
    var results: [songInfo]
}

struct songInfo: Codable {
    var artistName: String
    var releaseDate: String?
    var name: String
    var collectionName: String
    var artworkUrl100: String
    var genres: [genre]
}

struct genre: Codable {
    var name: String
}

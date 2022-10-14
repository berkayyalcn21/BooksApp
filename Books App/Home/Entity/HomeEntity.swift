//
//  HomeEntity.swift
//  Books App
//
//  Created by Berkay on 12.10.2022.
//

import Foundation


// MARK: - Welcome
struct Welcome: Codable {
    let feed: Feed?
}

// MARK: - Feed
struct Feed: Codable {
    let title: String?
    let id: String?
    let author: Author?
    let links: [Link]?
    let copyright, country: String?
    let icon: String?
    let updated: String?
    let results: [Books]?
}

// MARK: - Author
struct Author: Codable {
    let name: String?
    let url: String?
}

// MARK: - Link
struct Link: Codable {
    let linkSelf: String?

    enum CodingKeys: String, CodingKey {
        case linkSelf = "self"
    }
}

// MARK: - Result
struct Books: Codable {
    let artistName, id, name, releaseDate: String?
    let kind: String?
    let artistID: String?
    let artistURL: String?
    let contentAdvisoryRating: ContentAdvisoryRating?
    let artworkUrl100: String?
    let genres: [Genre]?
    let url: String?

    enum CodingKeys: String, CodingKey {
        case artistName, id, name, releaseDate, kind
        case artistID = "artistId"
        case artistURL = "artistUrl"
        case contentAdvisoryRating, artworkUrl100, genres, url
    }
    
    init(artistName: String?, id: String?, name: String?, releaseDate: String?, kind: String?, artistID: String?, artistURL: String?, contentAdvisoryRating: ContentAdvisoryRating?, artworkUrl100: String?, genres: [Genre]?, url: String?) {
        self.artistName = artistName
        self.id = id
        self.name = name
        self.releaseDate = releaseDate
        self.kind = kind
        self.artistID = artistID
        self.artistURL = artistURL
        self.contentAdvisoryRating = contentAdvisoryRating
        self.artworkUrl100 = artworkUrl100
        self.genres = genres
        self.url = url
    }
}

enum ContentAdvisoryRating: String, Codable {
    case explict = "Explict"
}

// MARK: - Genre
struct Genre: Codable {
    let genreID, name: String?
    let url: String?

    enum CodingKeys: String, CodingKey {
        case genreID = "genreId"
        case name, url
    }
}

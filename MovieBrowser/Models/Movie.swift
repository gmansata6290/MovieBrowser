//
//  Movie.swift
//  MovieBrowser
//
//  Created by Shayona on 28/12/18.
//  Copyright © 2018 Shayona. All rights reserved.
//

import UIKit

struct Movie {
    let id: Int?
    let posterPath: String?
    let title: String?
    let releaseDate: String?
    let rating: Double?
    let overview: String?
}

extension Movie: Codable {
    
    enum MovieCodingKeys: String, CodingKey {
        case id
        case posterPath = "poster_path"
        case title
        case releaseDate = "release_date"
        case rating = "vote_average"
        case overview
    }
    
    
    init(from decoder: Decoder) throws {
        let movieContainer = try decoder.container(keyedBy: MovieCodingKeys.self)
        
        id = try movieContainer.decodeIfPresent(Int.self, forKey: .id)
        posterPath = try movieContainer.decodeIfPresent(String.self, forKey: .posterPath)
        title = try movieContainer.decodeIfPresent(String.self, forKey: .title)
        releaseDate = try movieContainer.decodeIfPresent(String.self, forKey: .releaseDate)
        rating = try movieContainer.decodeIfPresent(Double.self, forKey: .rating)
        overview = try movieContainer.decodeIfPresent(String.self, forKey: .overview)
    }
}

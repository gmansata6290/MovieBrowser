//
//  MovieList.swift
//  MovieBrowser
//
//  Created by Shayona on 28/12/18.
//  Copyright © 2018 Shayona. All rights reserved.
//

import UIKit

struct MovieList {
    let page: Int?
    let numberOfResults: Int?
    let numberOfPages: Int?
    let movies: [Movie]?
}

extension MovieList: Codable {
    
    private enum MovieApiResponseCodingKeys: String, CodingKey {
        case page
        case numberOfResults = "total_results"
        case numberOfPages = "total_pages"
        case movies = "results"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: MovieApiResponseCodingKeys.self)
        
        page = try container.decodeIfPresent(Int.self, forKey: .page)
        numberOfResults = try container.decodeIfPresent(Int.self, forKey: .numberOfResults)
        numberOfPages = try container.decodeIfPresent(Int.self, forKey: .numberOfPages)
        movies = try container.decodeIfPresent([Movie].self, forKey: .movies)
    }
}

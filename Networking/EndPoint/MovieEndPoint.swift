//
//  MovieEndPoint.swift
//  MovieBrowser
//
//  Created by Shayona on 28/12/18.
//  Copyright © 2018 Shayona. All rights reserved.
//

import UIKit

public enum MovieApi {
    case recommended(id:Int)
    case popular(page:Int)
    case newMovies(page:Int)
    case video(id:Int)
    case searchMovie(searchText : String, page:Int)
}

extension MovieApi: EndPointType {
    
    var environmentBaseURL : String {
        switch NetworkManager.environment {
        case .production: return "https://api.themoviedb.org/"
        case .qa: return "https://qa.themoviedb.org/3/movie/"
        case .staging: return "https://staging.themoviedb.org/3/movie/"
        }
    }
    
    var baseURL: URL {
        guard let url = URL(string: environmentBaseURL) else { fatalError("baseURL could not be configured.")}
        return url
    }
    
    var path: String {
        switch self {
        case .recommended(let id):
            return "3/movie/\(id)/recommendations"
        case .popular:
            return "3/movie/popular"
        case .newMovies:
            return "3/movie/now_playing"
        case .video(let id):
            return "3/movie/\(id)/videos"
        case .searchMovie:
            return "3/search/movie"
        }
    }
    
    var httpMethod: HTTPMethod {
        return .get
    }
    
    var task: HTTPTask {
        switch self {
        case .newMovies(let page):
            return .requestParameters(bodyParameters: nil,
                                      bodyEncoding: .urlEncoding,
                                      urlParameters: ["page":page,
                                                      "api_key": AppConstant.APIKEY])
            
        case .searchMovie(let searchText, let page):
                return .requestParameters(bodyParameters: nil, bodyEncoding: .urlEncoding, urlParameters: ["page" : page,
                    "query" : searchText,
                    "api_key": AppConstant.APIKEY])
        default:
            return .request
        }
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
}

//
//  Global.swift
//  MovieBrowser
//
//  Created by Shayona on 28/12/18.
//  Copyright © 2018 Shayona. All rights reserved.
//

import UIKit

enum AppConstant {
    
    //This is the global padding for spaces between the views programatically we can use as well as for fonr sizes also for any view height also. For HeightOFTheViewConstraint.constant = AppConstant.PADDING * 3 i.e. approx 30pts height resp. to the device this will correct in iPad and iPhone both.
    static let PADDING = UIDevice.current.iPad ? ScreenSize.SCREEN_WIDTH * 0.03 : ScreenSize.SCREEN_WIDTH * 0.032 //Approx. 10pts for all Device
    
    static let ACCESSTOKEN = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI1MGEwYmQ5OGZjMGM5Nzg0NDI3MDZmZDVhNDlhZGY3ZCIsInN1YiI6IjVjMjFkZDRkOTI1MTQxNjdmYmMyYjJhMyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.Urz_EWfAa1M1hs-Ob6XxCMoAuIb9OgnVMxw5RYBHjJY"
    
    static let APIKEY = "50a0bd98fc0c978442706fd5a49adf7d"
    
    static let BASEURL = "https://api.themoviedb.org/3/movie/"
    
    static let IMGBASEURL = "https://image.tmdb.org/t/p/w500"
}

enum Version {
    
    static let SYS_VERSION_FLOAT = (UIDevice.current.systemVersion as NSString).floatValue
    static let iOS9 = (Version.SYS_VERSION_FLOAT >= 9.0 && Version.SYS_VERSION_FLOAT < 10.0)
    static let iOS10 = (Version.SYS_VERSION_FLOAT >= 10.0 && Version.SYS_VERSION_FLOAT < 11.0)
    static let iOS11 = (Version.SYS_VERSION_FLOAT >= 11.0 && Version.SYS_VERSION_FLOAT < 12.0)
    static let iOS12 = (Version.SYS_VERSION_FLOAT >= 12.0 && Version.SYS_VERSION_FLOAT < 13.0)
}

enum ScreenSize {
    
    static let SCREEN_WIDTH         = UIScreen.main.bounds.size.width
    static let SCREEN_HEIGHT        = UIScreen.main.bounds.size.height
    static let SCREEN_MAX_LENGTH    = max(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
    static let SCREEN_MIN_LENGTH    = min(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
}

enum HTTPHeaderField: String {
    case authentication = "Authorization"
    case contentType = "Content-Type"
    case acceptType = "Accept"
    case acceptEncoding = "Accept-Encoding"
}

enum ContentType: String {
    case json = "application/json"
}

enum NetworkResponse:String {
    case success
    case authenticationError = "You need to be authenticated first."
    case badRequest = "Bad request"
    case outdated = "The url you requested is outdated."
    case failed = "Network request failed."
    case noData = "Response returned with no data to decode."
    case unableToDecode = "We could not decode the response."
}

enum Result<String>{
    case success
    case failure(String)
}

enum NetworkEnvironment {
    case qa
    case production
    case staging
}

public enum HTTPMethod : String {
    case get     = "GET"
    case post    = "POST"
    case put     = "PUT"
    case patch   = "PATCH"
    case delete  = "DELETE"
}

public typealias HTTPHeaders = [String:String]

public enum HTTPTask {
    case request
    
    case requestParameters(bodyParameters: Parameters?,
        bodyEncoding: ParameterEncoding,
        urlParameters: Parameters?)
    
    case requestParametersAndHeaders(bodyParameters: Parameters?,
        bodyEncoding: ParameterEncoding,
        urlParameters: Parameters?,
        additionHeaders: HTTPHeaders?)
    
    // case download, upload...etc
}

public enum NetworkError : String, Error {
    case parametersNil = "Parameters were nil."
    case encodingFailed = "Parameter encoding failed."
    case missingURL = "URL is nil."
}

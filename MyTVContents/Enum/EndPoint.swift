//
//  EndPoint.swift
//  MyTVContents
//
//  Created by 조유진 on 1/31/24.
//

import Foundation

enum EndPoint: String {
    static let baseURL = "https://api.themoviedb.org/3"
    
    case topRated = "/tv/top_rated"
    case trend = "/trending/tv"
    case popular = "/tv/popular"
    
    case dramaInfo = "/tv/96102"
    case similarDramaRecommendation = "/tv/96102/recommendations"
    case dramaCaseInfo = "/tv/96102/aggregate_credits"
    
    case basePosterURL = "https://image.tmdb.org/t/p/w500"
     
    var url: String {
       return EndPoint.baseURL + self.rawValue
    }
}


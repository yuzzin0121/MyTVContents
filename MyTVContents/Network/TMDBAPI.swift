//
//  TMDBAPI.swift
//  MyTVContents
//
//  Created by 조유진 on 2/1/24.
//

import Foundation
import Alamofire

// enum의 case rawValue는 고유해야 한다.
enum TMDBAPI {
    case topRated
    case trend(page: Int=1)
    case popular(page: Int=1)
    
    case dramaInfo(id: Int)
    case similarDramaRecommendation(id: Int)
    case dramaCaseInfo(id: Int)
    
    case dramaSearch(query: String)
    case tvSeasonsDetails(seriesId: Int, seasonNumber: Int)
    
    case video(seriesId: Int)
    
    var baseURL: String {
        return "https://api.themoviedb.org/3/"
    }
    
    static var videoBaseURL: String {
        return "https://www.youtube.com/watch?v="
    }
    
    var endpoint: URL {
        switch self{
        case.topRated: return URL(string: baseURL + "/tv/top_rated")!
        case .trend: return URL(string: baseURL + "/tv/popular")!
        case .popular: return URL(string: baseURL + "/tv/popular")!
            
        case .dramaInfo(let id): return URL(string: baseURL + "/tv/\(id)")!
        case .similarDramaRecommendation(let id): return URL(string: baseURL +  "/tv/\(id)/recommendations")!
        case .dramaCaseInfo(let id): return URL(string: baseURL + "/tv/\(id)/aggregate_credits")!
        case .dramaSearch: return URL(string: baseURL + "/search/tv")!
        case .tvSeasonsDetails(let seriesId, let seasonNumber): 
            return URL(string: baseURL + "/tv/\(seriesId)/season/\(seasonNumber)")!
        case .video(let seriesId):
            return URL(string: baseURL + "/tv/\(seriesId)/videos")!
        }
    }
        
    var header: HTTPHeaders {
        return ["Authorization": APIKey.tmdbKey]
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var parameter: Parameters {
        switch self {
        case .topRated:
            ["language":"ko-KR"]
        case .trend(let page):
            ["language":"ko-KR", "page": page]
        case .popular(let page):
            ["language":"ko-KR", "page": page]
            
        case .dramaInfo:
            ["language":"ko-KR"]
        case .similarDramaRecommendation:
            ["language":"ko-KR", "page": 1]
        case .dramaCaseInfo:
            ["language":"ko-KR", "page": 1]
            
        case .dramaSearch(query: let query):
            ["language":"ko-KR", "query": query]
        case .tvSeasonsDetails(seriesId: let seriesId, seasonNumber: let seasonNumber):
            ["language":"ko-KR"]
        case .video(seriesId: let seriesId):
            ["language":"ko-KR"]
        }
    }
}

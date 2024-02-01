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
    
    case dramaInfo(id: Int = 96102)
    case similarDramaRecommendation(id: Int = 96102)
    case dramaCaseInfo(id: Int = 96102)
    
    var baseURL: String {
        return "https://api.themoviedb.org/3/"
    }
    
    var endpoint: URL {
        switch self{
        case.topRated: return URL(string: baseURL + "/tv/top_rated")!
        case .trend: return URL(string: baseURL + "/tv/popular")!
        case .popular: return URL(string: baseURL + "/tv/popular")!
            
        case .dramaInfo(let id): return URL(string: baseURL + "/tv/\(id)")!
        case .similarDramaRecommendation(let id): return URL(string: baseURL +  "/tv/\(id)/recommendations")!
        case .dramaCaseInfo(let id): return URL(string: baseURL + "/tv/\(id)/aggregate_credits")!
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
        }
    }
}

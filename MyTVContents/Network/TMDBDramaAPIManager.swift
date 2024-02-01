//
//  TMDBDramaAPIManager.swift
//  MyTVContents
//
//  Created by 조유진 on 1/31/24.
//

import Foundation
import Alamofire

class TMDBDramaAPIManager {
    static let shared = TMDBDramaAPIManager()
    let headers: HTTPHeaders = ["Authorization": APIKey.tmdbKey]
    
    private init() {}
    
    func fetchTvSeriesDetail(api: TMDBAPI,completionHandler: @escaping (DramaInfoModel) -> Void) {
        
        AF.request(api.endpoint,
                   method: api.method,
                   parameters: api.parameter,
                   encoding: URLEncoding(destination: .queryString),
                   headers: api.header)
            .responseDecodable(of: DramaInfoModel.self) { response in
                switch response.result {
                case .success(let success):
                    completionHandler(success)
                case .failure(let failure):
                    print(failure)
            }
        }
    }
    
    func fetchSimilarDramaRecommendation(api: TMDBAPI, completionHandler: @escaping (SimilarDramaRecommendationModel) -> Void) {
        
        AF.request(api.endpoint,
                   method: api.method,
                   parameters: api.parameter,
                   encoding: URLEncoding(destination: .queryString),
                   headers: api.header)
            .responseDecodable(of: SimilarDramaRecommendationModel.self) { response in
                switch response.result {
                case .success(let success):
                    completionHandler(success)
                case .failure(let failure):
                    print(failure)
            }
        }
    }
    
    func fetchDramaCastInfo(api: TMDBAPI, completionHandler: @escaping (DramaCastInfoModel) -> Void) {
        
        AF.request(api.endpoint,
                   method: api.method,
                   parameters: api.parameter,
                   encoding: URLEncoding(destination: .queryString),
                   headers: api.header)
            .responseDecodable(of: DramaCastInfoModel.self) { response in
                switch response.result {
                case .success(let success):
                    completionHandler(success)
                case .failure(let failure):
                    print(failure)
            }
        }
    }
}

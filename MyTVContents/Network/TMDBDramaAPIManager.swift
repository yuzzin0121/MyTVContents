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
    
    func fetchTvSeriesDetail(completionHandler: @escaping (DramaInfoModel) -> Void) {
        let url = EndPoint.dramaInfo.url + "?language=ko-KR"
        
        AF.request(url, headers: headers)
            .responseDecodable(of: DramaInfoModel.self) { response in
                switch response.result {
                case .success(let success):
                    completionHandler(success)
                case .failure(let failure):
                    fatalError("네트워킹 오류")
            }
        }
    }
    
    func fetchSimilarDramaRecommendation(completionHandler: @escaping (SimilarDramaRecommendationModel) -> Void) {
        let url = EndPoint.similarDramaRecommendation.url + "?language=ko-KR&page=1"
        
        AF.request(url, headers: headers)
            .responseDecodable(of: SimilarDramaRecommendationModel.self) { response in
                switch response.result {
                case .success(let success):
                    print(success)
                    completionHandler(success)
                case .failure(let failure):
                    fatalError("네트워킹 오류")
            }
        }
    }
    
    func fetchDramaCastInfo(completionHandler: @escaping (DramaCastInfoModel) -> Void) {
        let url = EndPoint.dramaCaseInfo.url + "?language=ko-KR&page=1"
        
        AF.request(url, headers: headers)
            .responseDecodable(of: DramaCastInfoModel.self) { response in
                switch response.result {
                case .success(let success):
//                    print(success)
                    completionHandler(success)
                case .failure(let failure):
                    fatalError("네트워킹 오류")
            }
        }
    }
}

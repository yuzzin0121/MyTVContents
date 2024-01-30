//
//  TMDBAPIManager.swift
//  MyTVContents
//
//  Created by 조유진 on 1/31/24.
//

import Foundation
import Alamofire

class TMDBAPIManager {
    static let shared = TMDBAPIManager()
    
    private init() {}
    
    func fetchTopRatedTv(completionHandler: @escaping (TVContentsModel) -> Void) {
        let url = EndPoint.topRated.url + "?language=ko-KR&page=1"
        
        let headers: HTTPHeaders = ["Authorization": APIKey.tmdbKey]
        
        AF.request(url, headers: headers)
            .responseDecodable(of: TVContentsModel.self) { response in
                switch response.result {
                case .success(let success):
                    completionHandler(success)
                case .failure(let failure):
                    fatalError("네트워킹 오류")
                }
            }
    }
    
    func fetchTrendingTv(completionHandler: @escaping (TVContentsModel) -> Void) {
        let url = EndPoint.trend.url + "/week?language=ko-KR"
        
        let headers: HTTPHeaders = ["Authorization": APIKey.tmdbKey]
        
        AF.request(url, headers: headers)
            .responseDecodable(of: TVContentsModel.self) { response in
                switch response.result {
                case .success(let success):
                    completionHandler(success)
                case .failure(let failure):
                    fatalError("네트워킹 오류")
                }
            }
    }
    
    func fetchPopularTv(completionHandler: @escaping (TVContentsModel) -> Void) {
        let url = EndPoint.popular.url + "?language=ko-KR&page=1"
        
        let headers: HTTPHeaders = ["Authorization": APIKey.tmdbKey]
        
        AF.request(url, headers: headers)
            .responseDecodable(of: TVContentsModel.self) { response in
                switch response.result {
                case .success(let success):
                    completionHandler(success)
                case .failure(let failure):
                    print(failure)
                }
            }
    }
}

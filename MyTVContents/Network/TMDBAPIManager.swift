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
    
    func fetchTv<T: Decodable>(type: T.Type, api: TMDBAPI,completionHandler: @escaping (T) -> Void) {
        
        AF.request(api.endpoint,
                   method: api.method,
                   parameters: api.parameter,
                   encoding: URLEncoding(destination: .queryString),
                   headers: api.header)
        .responseDecodable(of: type) { response in
            switch response.result {
            case .success(let success):
                completionHandler(success)
            case .failure(let failure):
                fatalError("네트워킹 오류")
            }
        }
        
    }
}

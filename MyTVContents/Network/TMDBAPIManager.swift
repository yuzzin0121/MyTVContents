//
//  TMDBAPIManager.swift
//  MyTVContents
//
//  Created by 조유진 on 1/31/24.
//

import Foundation
import Alamofire


final class TMDBAPIManager {
    static let shared = TMDBAPIManager()
    
    private init() {}
    
    func fetchTv<T: Decodable>(type: T.Type, api: TMDBAPI, completionHandler: @escaping (T?, NetworkError?) -> Void) {
        
        AF.request(api.endpoint,
                   method: api.method,
                   parameters: api.parameter,
                   encoding: URLEncoding(destination: .queryString),
                   headers: api.header)
        .responseDecodable(of: type) { response in
            switch response.result {
            case .success(let success):
                completionHandler(success, nil)
            case .failure(let failure):
                completionHandler(nil, .failedRequest)
                fatalError("네트워킹 오류")
            }
        }
        
    }
}

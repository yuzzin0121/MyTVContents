//
//  TMDBSessionManager.swift
//  MyTVContents
//
//  Created by 조유진 on 2/6/24.
//

import Foundation

enum NetworkError: Error {
    case failedRequest
    case noData
    case invalidResponse
    case invalidData
}

class TMDBSessionManager {
    static let shared = TMDBSessionManager()
    
    private init() { }
    
    func fetchTV(api: TMDBAPI, completionHandler: @escaping (TVContentsModel?, NetworkError?) -> Void) {
        var url = URLRequest(url: api.endpoint)
        url.httpMethod = "GET"
        url.addValue(APIKey.tmdbKey, forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                guard error == nil else {     // 에러 체크
                    print("네트워크 통신 실패")
                    completionHandler(nil, .failedRequest)
                    return
                }
                
                guard let data = data else {    // 데이터 체크
                    print("통신은 성공, 데이터는 안옴")
                    completionHandler(nil, .noData)
                    return
                }
                
                guard let response = response as? HTTPURLResponse else {    // 응답 체크
                    print("통신은 성공했지만 응답값이 오지 않음")
                    completionHandler(nil, .invalidResponse)
                    return
                }
                
                guard response.statusCode == 200 else {     // 상태코드 체크
                    print("통신은 성공했지만, 올바른 값이 오지 않은 상태")
                    completionHandler(nil, .failedRequest)
                    return
                }
                
                do {
                    let result = try JSONDecoder().decode(TVContentsModel.self, from: data)
                    completionHandler(result, nil)
                } catch {
                    print(error)
                    completionHandler(nil, .invalidData)
                }
            }
        }.resume()
    }
}

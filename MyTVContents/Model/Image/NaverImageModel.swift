//
//  NaverImageModel.swift
//  MyTVContents
//
//  Created by 조유진 on 2/14/24.
//

import Foundation

struct NaverImageModel: Decodable {
    let total: Int
    let start: Int
    let items: [NaverImage]
}

struct NaverImage: Decodable {
    let link: String
}

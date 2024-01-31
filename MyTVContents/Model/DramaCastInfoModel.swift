//
//  DramaCastInfoModel.swift
//  MyTVContents
//
//  Created by 조유진 on 1/31/24.
//

import Foundation

struct DramaCastInfoModel: Decodable {
    let cast: [Cast]
    let id: Int
}

struct Cast: Decodable {
    let knownForDepartment: String
    let name: String
    let profilPath: String?
    let roles: [Role]
    
    enum CodingKeys: String, CodingKey {
        case knownForDepartment = "known_for_department"
        case name
        case profilPath = "profile_path"
        case roles
    }
}

struct Role: Decodable {
    let character: String
}

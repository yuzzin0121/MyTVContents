//
//  TabItem.swift
//  MyTVContents
//
//  Created by 조유진 on 2/14/24.
//

import UIKit

enum TabItem: String {
    case home = "홈"
    case profile = "프로필"
    
    var image: UIImage {
        switch self {
        case .home:
            return ImageStyle.home
        case .profile:
            return ImageStyle.person
        }
    }
    
    var selectedImage: UIImage {
        switch self {
        case .home:
            return ImageStyle.homeFill
        case .profile:
            return ImageStyle.personFill
        }
    }
}

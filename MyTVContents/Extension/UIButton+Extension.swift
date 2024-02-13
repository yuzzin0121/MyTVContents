//
//  UIButton+Extension.swift
//  MyTVContents
//
//  Created by 조유진 on 2/8/24.
//

import UIKit

extension UIButton {
    func design(title: String, font: UIFont = .systemFont(ofSize: 14, weight: .medium), titleColor: UIColor = .white, backgroundColor: UIColor = .black) {
        self.setTitle(title, for: .normal)
        self.titleLabel?.font = font
        self.setTitleColor(titleColor, for: .normal)
        self.backgroundColor = backgroundColor
    }
}

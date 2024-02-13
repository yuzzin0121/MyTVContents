//
//  UILabel+Extension.swift
//  MyTVContents
//
//  Created by 조유진 on 2/13/24.
//

import UIKit

extension UILabel {
    func design(text: String = "", 
                textColor: UIColor = .white,
                font: UIFont = .systemFont(ofSize: 14),
                textAlignment: NSTextAlignment = .left,
                numberOfLines: Int = 1) {
        self.text = text
        self.textAlignment = textAlignment
        self.font = font
        self.textColor = textColor
        self.numberOfLines = numberOfLines
    }
}

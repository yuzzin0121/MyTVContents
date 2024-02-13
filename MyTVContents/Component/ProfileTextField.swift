//
//  ProfileTextField.swift
//  MyTVContents
//
//  Created by 조유진 on 2/14/24.
//

import UIKit

class ProfileTextField: UITextField {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureView() {
        textColor = .white
        borderStyle = .none
        backgroundColor = .black
        attributedPlaceholder = NSAttributedString(string: "",
                                                 attributes: [
                                                    .foregroundColor: UIColor.lightGray
                                                 ])
        font = .systemFont(ofSize: 14)
    }
}


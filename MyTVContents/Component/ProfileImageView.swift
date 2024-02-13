//
//  CastImageView.swift
//  MyTVContents
//
//  Created by 조유진 on 2/1/24.
//

import UIKit

class ProfileImageView: UIImageView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    private func configureView() {
        contentMode = .scaleAspectFill
        layer.cornerRadius = frame.height / 2
        clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

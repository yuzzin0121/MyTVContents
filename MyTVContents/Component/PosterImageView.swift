//
//  PosterImageView.swift
//  MyTVContents
//
//  Created by 조유진 on 1/31/24.
//

import UIKit

class PosterImageView: UIImageView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    func configureView() {
        contentMode = .scaleAspectFill
        layer.cornerRadius = 8
        clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

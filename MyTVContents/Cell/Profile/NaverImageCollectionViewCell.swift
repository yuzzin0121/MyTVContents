//
//  NaverImageCollectionViewCell.swift
//  MyTVContents
//
//  Created by 조유진 on 2/14/24.
//

import UIKit
import SnapKit
import Kingfisher

final class NaverImageCollectionViewCell: UICollectionViewCell, ViewProtocol {
    
    let imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureHierarchy()
        configureLayout()
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        configureCell(imageString: nil)
    }
    
    func configureCell(imageString: String?) {
        guard let imageString = imageString else { return }
        
        if let url = URL(string: imageString) {
            imageView.kf.setImage(with: url, placeholder: ImageStyle.personCircle)
        } else {
            imageView.image = ImageStyle.personCircle
        }
        imageView.contentMode = .scaleAspectFill
    }
    
    func configureHierarchy() {
        contentView.addSubview(imageView)
    }
    
    func configureLayout() {
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func configureView() {
        contentView.backgroundColor = .black
        imageView.image = ImageStyle.personCircle
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .systemGray6
        imageView.clipsToBounds = true
    }
    
}

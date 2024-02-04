//
//  ContentCollectionViewCell.swift
//  MyTVContents
//
//  Created by 조유진 on 1/31/24.
//

import UIKit
import SnapKit
import Kingfisher

class ContentCollectionViewCell: UICollectionViewCell, ViewProtocol {
    let titleLabel = UILabel()
    let posterImageView = PosterImageView(frame: .zero)
    let gradientView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureHierarchy()
        configureLayout()
        configureView()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        configureCell(item: nil)
    }
    
    func configureCell(item: TV?) {
        guard let item = item else { return }
        titleLabel.text = item.name
        
        if let imageString = item.backdropPath, let url = URL(string: EndPoint.basePosterURL.rawValue + imageString) {
            posterImageView.kf.setImage(with: url, placeholder: UIImage(systemName: "movieclapper"))
        } else {
            posterImageView.image = UIImage(systemName: "movieclapper")
        }
    }
    
    func configureHierarchy() {
        contentView.addSubview(posterImageView)
        posterImageView.addSubview(gradientView)
        gradientView.addSubview(titleLabel)
    }
    
    func configureLayout() {
        posterImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        gradientView.snp.makeConstraints { make in
            make.edges.equalTo(posterImageView)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.bottom.horizontalEdges.equalTo(gradientView).inset(4)
        }
    }
    
    func configureView() {
        DispatchQueue.main.async {
            self.gradientView.applyGradientBackground()
        }
        titleLabel.font = .boldSystemFont(ofSize: 14)
        titleLabel.textColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


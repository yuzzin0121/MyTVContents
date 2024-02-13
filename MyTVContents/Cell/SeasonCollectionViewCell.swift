//
//  SeasonCollectionViewCell.swift
//  MyTVContents
//
//  Created by 조유진 on 2/13/24.
//

import UIKit
import SnapKit
import Kingfisher

final class SeasonCollectionViewCell: UICollectionViewCell, ViewProtocol {
    
    let backdropimageView = UIImageView()
    let airDateLabel = UILabel()
    let nameLabel = UILabel()
    let overViewLabel = UILabel()
    let episodesCountLabel = UILabel()
   
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureHierarchy()
        configureLayout()
        configureView()
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        configureCell(season: nil)
    }
    
    func configureCell(season: Season?) {
        guard let season = season else { return }
        if let imageString = season.posterPath, let url = URL(string: EndPoint.basePosterURL.rawValue + imageString) {
            backdropimageView.kf.setImage(with: url, placeholder: ImageStyle.movieClapper)
        } else {
            backdropimageView.image = ImageStyle.movieClapper
        }
        
        nameLabel.text = season.name
        episodesCountLabel.text = "에피소드 \(season.episodeCount)개"
        airDateLabel.text = season.airDate
        overViewLabel.text = season.overview
    }
    
    func configureHierarchy() {
        [backdropimageView, airDateLabel, nameLabel, overViewLabel, episodesCountLabel].forEach {
            contentView.addSubview($0)
        }
    }
    
    func configureLayout() {
        backdropimageView.snp.makeConstraints { make in
            make.verticalEdges.leading.equalToSuperview().inset(8)
            make.width.equalTo(150)
        }
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(backdropimageView.snp.top).offset(8)
            make.leading.equalTo(backdropimageView.snp.trailing).offset(8)
            make.height.equalTo(16)
        }
        
        episodesCountLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel)
            make.leading.equalTo(nameLabel.snp.trailing).offset(6)
            make.trailing.equalToSuperview().inset(8)
            make.height.equalTo(14)
        }
        
        airDateLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(4)
            make.leading.equalTo(nameLabel)
            make.height.equalTo(12)
        }
        
        overViewLabel.snp.makeConstraints { make in
            make.top.equalTo(airDateLabel.snp.bottom).offset(8)
            make.leading.equalTo(nameLabel)
            make.trailing.equalToSuperview().inset(8)
            make.bottom.equalTo(backdropimageView.snp.bottom)
        }
        
    }
    
    func configureView() {
        contentView.backgroundColor = .black
        backdropimageView.backgroundColor = .darkGray
        backdropimageView.contentMode = .scaleAspectFill
        backdropimageView.layer.cornerRadius = 10
        backdropimageView.clipsToBounds = true
        
        nameLabel.design(font: .boldSystemFont(ofSize: 16))
        episodesCountLabel.design()
        airDateLabel.design(textColor: .gray, font: .systemFont(ofSize: 12))
        overViewLabel.design(numberOfLines: 0)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

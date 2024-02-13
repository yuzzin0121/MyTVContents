//
//  DramaInfoTableViewCell.swift
//  MyTVContents
//
//  Created by 조유진 on 2/1/24.
//

import UIKit
import SnapKit

final class DramaInfoTableViewCell: UITableViewCell {
    let backdropimageView = UIImageView()
    let playImageView = UIImageView()
    let nameLabel = UILabel()
    let overViewLabel = UILabel()
    let creatorLabel = UILabel()
    let episodesCountLabel = UILabel()
    let seasonsCountLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureHierarchy()
        configureLayout()
        configureView()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        configureCell(dramaInfo: nil)
    }
    
    func configureCell(dramaInfo: DramaInfoModel?) {
        guard let dramaInfo else { return }
        if let imagePath = dramaInfo.backdropPath, let url = URL(string: EndPoint.basePosterURL.rawValue + imagePath) {
            backdropimageView.kf.setImage(with: url, placeholder: UIImage(systemName: "movieclapper"))
        } else {
            backdropimageView.image = UIImage(systemName: "movieclapper")
        }
        
        nameLabel.text = dramaInfo.name
        overViewLabel.text = dramaInfo.overview
        
        if dramaInfo.createdBy.isEmpty == false {
            var creators = dramaInfo.createdBy[0].name
            if dramaInfo.createdBy.count > 1 {
                for index in 1...dramaInfo.createdBy.count - 1 {
                    creators.append(", " + dramaInfo.createdBy[index].name)
                }
            }
            creatorLabel.text = "크리에이터: \(creators)"
        }
        
        episodesCountLabel.text = "에피소드 \(dramaInfo.numberOfEpisodes)개"
        seasonsCountLabel.text = "시즌 \(dramaInfo.numberOfSeasons)개"
    }
    
    func configureHierarchy() {
        [backdropimageView, nameLabel, overViewLabel ,creatorLabel, episodesCountLabel, seasonsCountLabel].forEach {
            contentView.addSubview($0)
        }
        
        backdropimageView.addSubview(playImageView)
    }
    func configureLayout() {
        backdropimageView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview()
            make.height.equalTo(200)
        }
        
        playImageView.snp.makeConstraints { make in
            make.center.equalTo(backdropimageView)
            make.size.equalTo(50)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(backdropimageView.snp.bottom).offset(12)
            make.horizontalEdges.equalToSuperview().inset(12)
            make.height.equalTo(24)
        }
        
        overViewLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(8)
            make.horizontalEdges.equalToSuperview().inset(12)
            make.height.equalTo(40)
        }
        
        episodesCountLabel.snp.makeConstraints { make in
            make.top.equalTo(overViewLabel.snp.bottom).offset(12)
            make.horizontalEdges.equalToSuperview().inset(12)
            make.height.equalTo(18)
        }
        seasonsCountLabel.snp.makeConstraints { make in
            make.top.equalTo(episodesCountLabel.snp.bottom).offset(4)
            make.horizontalEdges.equalToSuperview().inset(12)
            make.height.equalTo(18)
        }
        
        creatorLabel.snp.makeConstraints { make in
            make.top.equalTo(seasonsCountLabel.snp.bottom).offset(6)
            make.horizontalEdges.equalToSuperview().inset(12)
            make.height.equalTo(18)
        }
        
    }
    func configureView() {
        contentView.backgroundColor = .black
        backdropimageView.isUserInteractionEnabled = true
        playImageView.image = ImageStyle.play
        playImageView.tintColor = .white
        playImageView.contentMode = .scaleAspectFit
        nameLabel.font = .boldSystemFont(ofSize: 18)
        nameLabel.textColor = .white
        overViewLabel.font = .systemFont(ofSize: 14)
        overViewLabel.textColor = .systemGray6
        overViewLabel.numberOfLines = 0
        creatorLabel.font = .systemFont(ofSize: 13)
        creatorLabel.textColor = .gray
        episodesCountLabel.font = .systemFont(ofSize: 13)
        episodesCountLabel.textColor = .white
        seasonsCountLabel.font = .systemFont(ofSize: 13)
        seasonsCountLabel.textColor = .white
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

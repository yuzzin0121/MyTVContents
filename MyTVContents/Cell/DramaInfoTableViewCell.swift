//
//  DramaInfoTableViewCell.swift
//  MyTVContents
//
//  Created by 조유진 on 2/1/24.
//

import UIKit
import SnapKit

class DramaInfoTableViewCell: UITableViewCell {
    let backdropimageView = UIImageView()
    let nameLabel = UILabel()
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
        
        if dramaInfo.createdBy.isEmpty == false {
            var creators = dramaInfo.createdBy[0].name
            for index in 1...dramaInfo.createdBy.count - 1 {
                creators.append(", " + dramaInfo.createdBy[index].name)
            }
            
            creatorLabel.text = "연출: \(creators)"
        }
        
        episodesCountLabel.text = "에피소드: \(dramaInfo.numberOfEpisodes)개"
        seasonsCountLabel.text = "시즌: \(dramaInfo.numberOfSeasons)개"
    }
    
    func configureHierarchy() {
        [backdropimageView, nameLabel, creatorLabel, episodesCountLabel, seasonsCountLabel].forEach {
            contentView.addSubview($0)
        }
    }
    func configureLayout() {
        backdropimageView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview()
            make.height.equalTo(240)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(backdropimageView.snp.bottom).offset(12)
            make.horizontalEdges.equalToSuperview().inset(12)
            make.height.equalTo(24)
        }
        
        creatorLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(6)
            make.horizontalEdges.equalToSuperview().inset(12)
            make.height.equalTo(18)
        }
        
        episodesCountLabel.snp.makeConstraints { make in
            make.top.equalTo(creatorLabel.snp.bottom).offset(12)
            make.horizontalEdges.equalToSuperview().inset(12)
            make.height.equalTo(18)
        }
        seasonsCountLabel.snp.makeConstraints { make in
            make.top.equalTo(episodesCountLabel.snp.bottom).offset(4)
            make.horizontalEdges.equalToSuperview().inset(12)
            make.height.equalTo(18)
        }
    }
    func configureView() {
        contentView.backgroundColor = .black
        nameLabel.font = .boldSystemFont(ofSize: 18)
        nameLabel.textColor = .white
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
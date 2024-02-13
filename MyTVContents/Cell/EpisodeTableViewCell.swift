//
//  EpisodeTableViewCell.swift
//  MyTVContents
//
//  Created by 조유진 on 2/13/24.
//

import UIKit

final class EpisodeTableViewCell: UITableViewCell, ViewProtocol {
    let stillImageView = UIImageView()
    let runtimeLabel = UILabel()
    let nameLabel = UILabel()
    let overViewLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureHierarchy()
        configureLayout()
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(episode: Episode?) {
        guard let episode = episode else { return }
        if let imageString = episode.stillPath, let url = URL(string: EndPoint.basePosterURL.rawValue + imageString) {
            print(imageString)
            stillImageView.kf.setImage(with: url, placeholder: ImageStyle.movieClapper)
        } else {
            stillImageView.image = ImageStyle.movieClapper
        }
        
        nameLabel.text = episode.name
        runtimeLabel.text = "\(episode.runtime)분"
        overViewLabel.text = episode.overview
    }
    
    func configureHierarchy() {
        [stillImageView, runtimeLabel, nameLabel, overViewLabel].forEach {
            contentView.addSubview($0)
        }
    }
    
    func configureLayout() {
        stillImageView.snp.makeConstraints { make in
            make.leading.verticalEdges.equalToSuperview().inset(8)
            make.width.equalTo(130)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.leading.equalTo(stillImageView.snp.trailing).offset(8)
            make.top.equalTo(stillImageView.snp.top).offset(4)
            make.trailing.equalToSuperview().inset(8)
            make.height.equalTo(15)
        }
        
        runtimeLabel.snp.makeConstraints { make in
            make.leading.equalTo(nameLabel)
            make.top.equalTo(nameLabel.snp.bottom).offset(4)
            make.trailing.equalTo(nameLabel)
            make.height.equalTo(13)
        }
        
        overViewLabel.snp.makeConstraints { make in
            make.leading.equalTo(nameLabel)
            make.top.equalTo(runtimeLabel.snp.bottom).offset(8)
            make.trailing.equalTo(nameLabel)
            make.bottom.equalTo(stillImageView.snp.bottom)
        }
    }
    
    func configureView() {
        contentView.backgroundColor = .black
        stillImageView.backgroundColor = .darkGray
        stillImageView.contentMode = .scaleAspectFill
        stillImageView.layer.cornerRadius = 10
        stillImageView.clipsToBounds = true
        
        nameLabel.design(font: .boldSystemFont(ofSize: 16))
        runtimeLabel.design()
        overViewLabel.design(numberOfLines: 0)
    }

}

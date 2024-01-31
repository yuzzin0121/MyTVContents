//
//  DramaCastInfoCollectionViewCell.swift
//  MyTVContents
//
//  Created by 조유진 on 2/1/24.
//

import UIKit

class DramaCastInfoCollectionViewCell: UICollectionViewCell {
    let knownForDepartmentLabel = UILabel()
    let profileImageView = ProfileImageView(frame: .zero)
    let nameLabel = UILabel()
    let roleLabel = UILabel()
    
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
    
    func configureCell(item: Cast?) {
        guard let item = item else { return }
        knownForDepartmentLabel.text = item.knownForDepartment
        
        if let imageString = item.profilPath, let url = URL(string: EndPoint.basePosterURL.rawValue + imageString) {
            profileImageView.kf.setImage(with: url, placeholder: UIImage(systemName: "movieclapper"))
        } else {
            profileImageView.image = UIImage(systemName: "movieclapper")
        }
        nameLabel.text = item.name
        roleLabel.text = item.roles[0].character
    }
    
    func configureHierarchy() {
        [knownForDepartmentLabel, profileImageView, nameLabel, roleLabel].forEach {
            contentView.addSubview($0)
        }
    }
    func configureLayout() {
        knownForDepartmentLabel.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview().inset(4)
            make.height.equalTo(18)
        }
        
        profileImageView.snp.makeConstraints { make in
            make.top.equalTo(knownForDepartmentLabel.snp.bottom).offset(8)
            make.horizontalEdges.equalToSuperview().inset(4)
            make.height.equalTo(profileImageView.snp.width)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.bottom).offset(6)
            make.horizontalEdges.equalToSuperview().inset(4)
            make.height.equalTo(18)
        }
        
        roleLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(2)
            make.horizontalEdges.equalToSuperview().inset(4)
            make.height.equalTo(18)
        }
        
    }
    func configureView() {
        knownForDepartmentLabel.textAlignment = .center
        knownForDepartmentLabel.font = .boldSystemFont(ofSize: 14)
        nameLabel.font = .systemFont(ofSize: 14)
        roleLabel.font = .systemFont(ofSize: 14)
        DispatchQueue.main.async {
            self.profileImageView.layer.cornerRadius = self.profileImageView.frame.height / 2
        }
        [knownForDepartmentLabel, nameLabel, roleLabel].forEach {
            $0.textColor = .white
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

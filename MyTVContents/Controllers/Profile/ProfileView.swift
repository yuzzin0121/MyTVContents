//
//  ProfileView.swift
//  MyTVContents
//
//  Created by 조유진 on 2/14/24.
//

import UIKit

final class ProfileView: BaseView {
    let profileImageView = ProfileImageView(frame: .zero)
    let imageModifyButton = UIButton()
    let textFieldTableView = UITableView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureTableView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureTableView() {
        textFieldTableView.showsVerticalScrollIndicator = false
        textFieldTableView.isScrollEnabled = false
        textFieldTableView.register(TextFieldTableViewCell.self, forCellReuseIdentifier: TextFieldTableViewCell.identifier)
        textFieldTableView.rowHeight = 50
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        DispatchQueue.main.async {
            self.profileImageView.layer.cornerRadius = self.profileImageView.frame.height / 2
            self.profileImageView.clipsToBounds = true
        }
    }
    
    override func configureHierarchy() {
        [profileImageView, imageModifyButton, textFieldTableView].forEach {
            addSubview($0)
        }
    }
    
    override func configureLayout() {
        profileImageView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(32)
            make.centerX.equalToSuperview()
            make.size.equalTo(100)
        }
        imageModifyButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(profileImageView.snp.bottom).offset(12)
        }
        
        textFieldTableView.snp.makeConstraints { make in
            make.top.equalTo(imageModifyButton.snp.bottom).offset(24)
            make.horizontalEdges.bottom.equalToSuperview()
        }
    }
    
    override func configureView() {
        backgroundColor = .black
        profileImageView.image = ImageStyle.personCircle
        profileImageView.contentMode = .scaleAspectFill
        profileImageView.tintColor = .systemGray6
        
        
        imageModifyButton.design(title: "프로필 이미지 수정", titleColor: .cyan)
        textFieldTableView.backgroundColor = .black
    }
}

//
//  SelectInfoTableViewCell.swift
//  MyTVContents
//
//  Created by 조유진 on 2/8/24.
//

import UIKit

final class SelectInfoTableViewCell: UITableViewCell {
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        stackView.spacing = 12
        return stackView
    }()
    
    let episodeButton = UIButton()
    let castInfoButton = UIButton()
    let similarContentsButton = UIButton()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureHierarchy()
        configureLayout()
        configureView()
    }
    
    func configureHierarchy() {
        contentView.addSubview(stackView)
        [episodeButton, castInfoButton, similarContentsButton].forEach {
            stackView.addArrangedSubview($0)
        }
    }
    func configureLayout() {
        stackView.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview()
            make.leading.equalTo(12)
            make.height.equalTo(44)
        }
    }
    func configureView() {
        contentView.backgroundColor = .black
        episodeButton.design(title: "회차")
        episodeButton.isSelected = true
        episodeButton.tag = 0
        castInfoButton.design(title: "캐스트 정보")
        castInfoButton.tag = 1
        similarContentsButton.design(title: "비슷한 콘텐츠")
        similarContentsButton.tag = 2
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//
//  TextFieldTableViewCell.swift
//  MyTVContents
//
//  Created by 조유진 on 2/14/24.
//

import UIKit
import SnapKit

final class TextFieldTableViewCell: UITableViewCell, ViewProtocol {
    let titleLabel = UILabel()
    let textField = ProfileTextField()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureHierarchy()
        configureLayout()
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        configureCell(title: nil)
    }
    
    func configureCell(title: String?) {
        guard let title = title else { return }
        titleLabel.text = title
        textField.placeholder = title
        textField.attributedPlaceholder = NSAttributedString(string: title,
                                                 attributes: [
                                                    .foregroundColor: UIColor.lightGray
                                                 ])
    }
    
    func configureHierarchy() {
        [titleLabel, textField].forEach {
            contentView.addSubview($0)
        }
    }
    
    func configureLayout() {
        titleLabel.snp.makeConstraints { make in
            make.leading.verticalEdges.equalToSuperview().inset(4)
            make.width.equalTo(60)
        }
        
        textField.snp.makeConstraints { make in
            make.trailing.verticalEdges.equalToSuperview().inset(4)
            make.leading.equalTo(titleLabel.snp.trailing).offset(24)
        }
    }
    
    func configureView() {
        contentView.backgroundColor = .black
        titleLabel.design(font: .boldSystemFont(ofSize: 15))
        textField.isEnabled = false
    }
}

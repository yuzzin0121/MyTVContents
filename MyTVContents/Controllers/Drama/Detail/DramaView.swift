//
//  DramaView.swift
//  MyTVContents
//
//  Created by 조유진 on 2/2/24.
//

import UIKit
import SnapKit

final class DramaView: BaseView {
    let tableView = UITableView()
    
    override func configureHierarchy() {
        addSubview(tableView)
    }
    
    override func configureLayout() {
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
    }
    
    override func configureView() {
        tableView.backgroundColor = .black
        tableView.showsVerticalScrollIndicator = false
        tableView.rowHeight = UIScreen.main.bounds.height / 2 
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.register(DramaInfoTableViewCell.self, forCellReuseIdentifier: DramaInfoTableViewCell.identifier)  // 드라마 상세 정보 셀
        tableView.register(SelectInfoTableViewCell.self, forCellReuseIdentifier: SelectInfoTableViewCell.identifier)   // 드라마 정보 선택 뷰
        tableView.register(InfoContentTableViewCell.self, forCellReuseIdentifier: InfoContentTableViewCell.identifier)  // 시즌 정보 셀
    }
    
}

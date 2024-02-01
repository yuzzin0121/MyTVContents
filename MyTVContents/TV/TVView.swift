//
//  TVView.swift
//  MyTVContents
//
//  Created by 조유진 on 2/1/24.
//

import UIKit
import SnapKit

class TVView: BaseView {
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
        tableView.rowHeight = UIScreen.main.bounds.height / 3 - 48
        tableView.register(TVContentsTableViewCell.self, forCellReuseIdentifier: "TVContentsTableViewCell")
    }
}

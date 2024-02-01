//
//  DramaView.swift
//  MyTVContents
//
//  Created by 조유진 on 2/2/24.
//

import UIKit
import SnapKit

class DramaView: BaseView {
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
        tableView.rowHeight = UIScreen.main.bounds.height / 2 - 48
        tableView.register(DramaInfoTableViewCell.self, forCellReuseIdentifier: "DramaInfoTableViewCell")
        tableView.register(TVContentsTableViewCell.self, forCellReuseIdentifier: "TVContentsTableViewCell")
    }
    
}

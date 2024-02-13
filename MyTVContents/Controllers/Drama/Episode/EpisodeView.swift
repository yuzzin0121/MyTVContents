//
//  EpisodeView.swift
//  MyTVContents
//
//  Created by 조유진 on 2/13/24.
//

import UIKit
import SnapKit


final class EpisodeView: BaseView {
    let tableView = UITableView()
    
    override func configureHierarchy() {
        addSubview(tableView)
    }
    
    override func configureLayout() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    override func configureView() {
        backgroundColor = .black
        tableView.backgroundColor = .black
        tableView.showsVerticalScrollIndicator =  false
        tableView.rowHeight = 120
    }
}

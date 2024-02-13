//
//  DramaSearchView.swift
//  MyTVContents
//
//  Created by 조유진 on 2/5/24.
//

import UIKit
import SnapKit

class DramaSearchView: BaseView {
    let searchController = UISearchController(searchResultsController: nil)
    let titleLabel = UILabel()
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: configureCollectionViweFlowLayout())

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureSearchBar()
    }
    
    func configureCollectionViweFlowLayout()  -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 12
        layout.itemSize = CGSize(width: 110, height: 176)
        layout.minimumLineSpacing = spacing
        layout.scrollDirection = .vertical
        return layout
    }
    
    override func configureHierarchy() {
        [titleLabel, collectionView].forEach {
            addSubview($0)
        }
    }
    
    override func configureLayout() {
        titleLabel.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(16)
        }
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.horizontalEdges.bottom.equalToSuperview().inset(16)
            
        }
    }
    
    override func configureView() {
        titleLabel.text = "검색된 드라마"
        titleLabel.font = .boldSystemFont(ofSize: 16)
        titleLabel.textColor = .white
        collectionView.backgroundColor = .black
        collectionView.showsVerticalScrollIndicator = false
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        collectionView.register(ContentCollectionViewCell.self, forCellWithReuseIdentifier: "ContentCollectionViewCell")
    }
    
    func configureSearchBar() {
        searchController.searchBar.placeholder = "드라마 이름을 검색해보세요"
        searchController.searchBar.barStyle = .black
        searchController.searchBar.barTintColor = .black
        searchController.searchBar.tintColor = .white
        searchController.searchBar.searchTextField.textColor = .lightGray
        searchController.searchBar.searchTextField.backgroundColor = UIColor(named: "deepDarkGray")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

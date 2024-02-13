//
//  ProfileImageSelectView.swift
//  MyTVContents
//
//  Created by 조유진 on 2/14/24.
//

import UIKit

final class ProfileImageSelectView: BaseView {
    let searchBar = UISearchBar()
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: configureCollectionViweFlowLayout())
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureSearchBar()
    }
    
    private func configureCollectionViweFlowLayout()  -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 12
        let itemSize = UIScreen.main.bounds.width / 3 - spacing*2
        layout.itemSize = CGSize(width: itemSize, height: itemSize)
        layout.minimumLineSpacing = spacing
        layout.scrollDirection = .vertical
        return layout
    }
    
    override func configureHierarchy() {
        [searchBar, collectionView].forEach {
            addSubview($0)
        }
    }
    
    override func configureLayout() {
        searchBar.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(44)
        }
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom)
            make.horizontalEdges.bottom.equalTo(safeAreaLayoutGuide).inset(16)
        }
    }
    
    override func configureView() {
        collectionView.backgroundColor = .black
        collectionView.showsVerticalScrollIndicator = false
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        collectionView.register(NaverImageCollectionViewCell.self, forCellWithReuseIdentifier: NaverImageCollectionViewCell.identifier)
    }
    
    private func configureSearchBar() {
        searchBar.placeholder = "이미지를 검색해보세요"
        searchBar.barStyle = .black
        searchBar.barTintColor = .black
        searchBar.tintColor = .white
        searchBar.searchTextField.textColor = .lightGray
        searchBar.searchTextField.backgroundColor = UIColor(named: "deepDarkGray")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

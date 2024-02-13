//
//  InfoCollectionViewCell.swift
//  MyTVContents
//
//  Created by 조유진 on 2/9/24.
//

import UIKit

final class InfoContentTableViewCell: UITableViewCell, ViewProtocol {
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: configureCollectionViewFlowLayout())
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureHierarchy()
        configureLayout()
        configureView()
    }
    
    func configureHierarchy() {
        [collectionView].forEach {
            contentView.addSubview($0)
        }
    }
    
    func configureLayout() {
        collectionView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(16)
            make.verticalEdges.equalToSuperview().inset(8)
        }
    }
    
    func configureView() {
        contentView.backgroundColor = .black
        collectionView.backgroundColor = .black
//        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        collectionView.register(SeasonCollectionViewCell.self, forCellWithReuseIdentifier: SeasonCollectionViewCell.identifier)
        collectionView.register(DramaCastInfoCollectionViewCell.self, forCellWithReuseIdentifier: DramaCastInfoCollectionViewCell.identifier)
        collectionView.register(ContentCollectionViewCell.self, forCellWithReuseIdentifier: ContentCollectionViewCell.identifier)
    }
    
    private func configureCollectionViewFlowLayout()  -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        let spacing = 12
        layout.itemSize = CGSize(width: 110, height: 176)
        layout.minimumLineSpacing = 12
        layout.scrollDirection = .vertical
        return layout
    }
    
    func changeCollectionViewLayout(isSeason: Bool) {
        let layout = UICollectionViewFlowLayout()
        if isSeason {
            layout.itemSize = CGSize(width: UIScreen.main.bounds.width - 12, height: 130)
        } else {
            layout.itemSize = CGSize(width: 110, height: 176)
        }
        layout.minimumLineSpacing = 12
        layout.scrollDirection = .vertical
        collectionView.collectionViewLayout = layout
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

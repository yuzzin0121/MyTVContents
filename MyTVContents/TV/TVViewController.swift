//
//  ViewController.swift
//  MyTVContents
//
//  Created by 조유진 on 1/30/24.
//

import UIKit

import UIKit
import SnapKit
import Kingfisher

class TVViewController: UIViewController {
    
    let mainView = TVView()
    
    let titleList: [String] = ["지금 뜨는 콘텐츠", "이번주 인기 콘텐츠", "취향저격 인기 콘텐츠"]
    
    var tvList: [TVContentsModel] = [
        TVContentsModel(results: [], totalPages: 0, totalResults: 0),
        TVContentsModel(results: [], totalPages: 0, totalResults: 0),
        TVContentsModel(results: [], totalPages: 0, totalResults: 0)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadView()
        configureTableView()
        callRequest()
    }
    
    override func loadView() {
        self.view = mainView
    }
    
    func callRequest() {
        let group = DispatchGroup()
        
        group.enter()
        TMDBAPIManager.shared.fetchTv(type: TVContentsModel.self, api: .trend()) { trendingModel in
            self.tvList[0] = trendingModel
            group.leave()
        }
        
        group.enter()
        TMDBAPIManager.shared.fetchTv(type: TVContentsModel.self, api: .topRated) { topRatedModel in
            self.tvList[1] = topRatedModel
            group.leave()
        }
        
        group.enter()
        TMDBAPIManager.shared.fetchTv(type: TVContentsModel.self, api: .popular()) { popularModel in
            self.tvList[2] = popularModel
            group.leave()
        }
        
        group.notify(queue: .main) {
            self.mainView.tableView.reloadData()
        }
    }

    func configureTableView() {
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
    }
}

extension TVViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TVContentsTableViewCell", for: indexPath) as? TVContentsTableViewCell else { return UITableViewCell() }
        cell.collectionView.delegate = self
        cell.collectionView.dataSource = self
        cell.collectionView.tag = indexPath.row
        cell.titleLabel.text = titleList[indexPath.row]
        cell.collectionView.reloadData()
        
        return cell
    }

}

extension TVViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return tvList.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tvList[collectionView.tag].results.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ContentCollectionViewCell", for: indexPath) as? ContentCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let section = collectionView.tag
        let row = indexPath.row
        cell.titleLabel.text = tvList[section].results[row].name
        
        if let urlString = tvList[section].results[row].posterPath {
            if let url = URL(string: EndPoint.basePosterURL.rawValue + urlString) {
                cell.posterImageView.kf.setImage(with: url, placeholder: UIImage(systemName: "movieclapper"))
            } else {
                cell.posterImageView.image = UIImage(systemName: "movieclapper")
            }
        } else {
            cell.posterImageView.image = UIImage(systemName: "movieclapper")
        }
        
        collectionView.reloadData()
        
        return cell
    }
}


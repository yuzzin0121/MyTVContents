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

class HomeViewController: UIViewController, ViewProtocol {
    let tableView = UITableView()
    
    let titleList: [String] = ["지금 뜨는 콘텐츠", "이번주 인기 콘텐츠", "취향저격 인기 콘텐츠"]
    
    var tvList: [TVContentsModel] = [
        TVContentsModel(results: [], totalPages: 0, totalResults: 0),
        TVContentsModel(results: [], totalPages: 0, totalResults: 0),
        TVContentsModel(results: [], totalPages: 0, totalResults: 0)
    ] {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierarchy()
        configureLayout()
        configureView()
        
        TMDBAPIManager.shared.fetchTrendingTv { trendingModel in
            self.tvList[0] = trendingModel
        }
        
        TMDBAPIManager.shared.fetchTopRatedTv { topRatedModel in
            self.tvList[1] = topRatedModel
        }
        
        TMDBAPIManager.shared.fetchPopularTv { popularModel in
            self.tvList[2] = popularModel
        }
        
    }

    func configureHierarchy() {
        view.addSubview(tableView)
    }
    
    func configureLayout() {
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func configureView() {
       
        
        view.backgroundColor = .black
        tableView.backgroundColor = .black
        tableView.showsVerticalScrollIndicator = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UIScreen.main.bounds.height / 2 - 48
        tableView.register(TVContentsTableViewCell.self, forCellReuseIdentifier: "TVContentsTableViewCell")
    }
    

}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
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

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
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


#Preview {
    HomeViewController()
}

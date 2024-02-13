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

final class TVViewController: BaseViewController {
    
    let mainView = TVView()
    
    let titleList: [String] = ["지금 뜨는 콘텐츠", "이번주 인기 콘텐츠", "취향저격 인기 콘텐츠"]
    
    var tvList: [TVContentsModel] = [
        TVContentsModel(results: [], totalPages: 0, totalResults: 0),
        TVContentsModel(results: [], totalPages: 0, totalResults: 0),
        TVContentsModel(results: [], totalPages: 0, totalResults: 0)
    ]
    
    let apiList: [TMDBAPI] = [.trend(), .topRated, .popular()]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadView()
        configureNavigationItem()
        configureTableView()
        callRequestToUseURLSession()
//        callRequest()
    }
    
    override func configureNavigationItem() {
        navigationItem.title = "홈"
        let searchItem = UIBarButtonItem(image: ImageStyle.search, style: .plain, target: self, action: #selector(showSearchVC))
        searchItem.tintColor = .white
        navigationItem.rightBarButtonItem = searchItem
    }
    
    @objc private func showSearchVC() {
        let searchVC = DramaSearchViewController()
        navigationController?.pushViewController(searchVC, animated: true)
    }
    
    override func loadView() {
        self.view = mainView
    }
    
    // URLSession을 사용한 네트워크 요청
    private func callRequestToUseURLSession() {
        let group = DispatchGroup()
        
        for index in 0...tvList.count - 1 {
            group.enter()
            TMDBSessionManager.shared.fetchTV(api: apiList[index]) { contentsModel, error in
                if error == nil {
                    guard let contentsModel = contentsModel else { return }
                    self.tvList[index] = contentsModel
                    
                    // UI에 직결된 코드
                    self.mainView.tableView.reloadData()
                } else {
                    // error 분기 처리, alert, toast > main  케이스마다 다르게 띄울 수 있다.
                    fatalError("에러")
                }
                group.leave()
            }
        }
        
        group.notify(queue: .main) {
            self.mainView.tableView.reloadData()
        }
    }
    
    private func callRequest() {
        let group = DispatchGroup()
        
        group.enter()
        TMDBAPIManager.shared.fetchTv(type: TVContentsModel.self, api: .trend()) { trendingModel, error in
            if error == nil {
                guard let trendingModel = trendingModel else { return }
                self.tvList[0] = trendingModel
            } else {
                print("trendingModel을 가져오는 요청 응답에 실패했습니다.")
            }
            group.leave()
        }
        
        group.enter()
        TMDBAPIManager.shared.fetchTv(type: TVContentsModel.self, api: .topRated) { topRatedModel, error in
            if error == nil {
                guard let topRatedModel = topRatedModel else { return }
                self.tvList[1] = topRatedModel
            } else {
                print("topRatedModel을 가져오는 요청 응답에 실패했습니다.")
            }
            group.leave()
        }
        
        group.enter()
        TMDBAPIManager.shared.fetchTv(type: TVContentsModel.self, api: .popular()) { popularModel, error in
            if error == nil {
                guard let popularModel = popularModel else { return }
                self.tvList[2] = popularModel
            } else {
                print("popularModel을 가져오는 요청 응답에 실패했습니다.")
            }
            group.leave()
        }
        
        group.notify(queue: .main) {
            self.mainView.tableView.reloadData()
        }
    }

    private func configureTableView() {
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
    }
    
    private func showDetailVC(id: Int) {
        let detailVC = DramaDetailViewController()
        detailVC.id = id
        navigationController?.pushViewController(detailVC, animated: true)
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
        
        if let urlString = tvList[section].results[row].posterPath, let url = URL(string: EndPoint.basePosterURL.rawValue + urlString) {
            cell.posterImageView.kf.setImage(with: url, placeholder: ImageStyle.movieClapper)
        } else {
            cell.posterImageView.image = ImageStyle.movieClapper
        }
        
        collectionView.reloadData()
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("클릭")
        let section = collectionView.tag
        let row = indexPath.row
        let id = tvList[section].results[row].id
        showDetailVC(id: id)
    }
}


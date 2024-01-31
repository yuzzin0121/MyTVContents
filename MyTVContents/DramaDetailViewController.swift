//
//  DramaDetailViewController.swift
//  MyTVContents
//
//  Created by 조유진 on 1/31/24.
//

import UIKit
import SnapKit
import Kingfisher

class DramaDetailViewController: BaseViewController {
    let tableView = UITableView()
    
    let titleList: [String] = ["드라마 정보", "비슷한 드라마 추천", "드라마 캐스트 정보"]
    
    var dramaInfoModel: DramaInfoModel = DramaInfoModel(backdropPath: nil, createdBy: [], id: 0, name: "", numberOfEpisodes: 0, numberOfSeasons: 0)
    var similarDramaRecommendationModel: SimilarDramaRecommendationModel = SimilarDramaRecommendationModel(page: 0, results: [], totalPages: 0, totalResults: 0)
    var dramaCastInfoModel: DramaCastInfoModel = DramaCastInfoModel(cast: [], id: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationItem()
        callRequest()
    }
    
    func callRequest() {
        let group = DispatchGroup()
        
        group.enter()
        TMDBDramaAPIManager.shared.fetchTvSeriesDetail { dramaInfoModel in
            self.dramaInfoModel = dramaInfoModel
            group.leave()
        }
        
        group.enter()
        TMDBDramaAPIManager.shared.fetchSimilarDramaRecommendation { similarDramaRecommendationModel in
            self.similarDramaRecommendationModel = similarDramaRecommendationModel
            group.leave()
        }
        
        group.enter()
        TMDBDramaAPIManager.shared.fetchDramaCastInfo { dramaCastInfoModel in
            self.dramaCastInfoModel = dramaCastInfoModel
            group.leave()
        }
        
        group.notify(queue: .main) {
            self.tableView.reloadData()
        }
    }
    
    func configureNavigationItem() {
        navigationItem.title = "드라마 세부 정보"
    }

    override func configureHierarchy() {
        view.addSubview(tableView)
    }
    
    override func configureLayout() {
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    override func configureView() {
        view.backgroundColor = .black
        tableView.backgroundColor = .black
        tableView.showsVerticalScrollIndicator = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UIScreen.main.bounds.height / 2 - 48
        tableView.register(DramaInfoTableViewCell.self, forCellReuseIdentifier: "DramaInfoTableViewCell")
        tableView.register(TVContentsTableViewCell.self, forCellReuseIdentifier: "TVContentsTableViewCell")
    }
    

}

extension DramaDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "DramaInfoTableViewCell", for: indexPath) as? DramaInfoTableViewCell else { return UITableViewCell() }
            
            let item = dramaInfoModel
            cell.configureCell(dramaInfo: item)
            
            return cell
            
        case 1, 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "TVContentsTableViewCell", for: indexPath) as? TVContentsTableViewCell else { return UITableViewCell() }
            cell.collectionView.delegate = self
            cell.collectionView.dataSource = self
            cell.collectionView.tag = indexPath.row
            cell.titleLabel.text = titleList[indexPath.row]
            cell.collectionView.reloadData()
            
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return UIScreen.main.bounds.height / 2 - 48
        case 1:
            return UIScreen.main.bounds.height / 2
        case 2:
            return UIScreen.main.bounds.height / 2
        default:
            return UITableView.automaticDimension
        }
        
    }

}

extension DramaDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2 
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView.tag {
        case 1:
            return similarDramaRecommendationModel.results.count
        case 2:
            return dramaCastInfoModel.cast.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let section = collectionView.tag
        let row = indexPath.row
        
        switch collectionView.tag {
        case 1:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ContentCollectionViewCell", for: indexPath) as? ContentCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.configureCell(item: similarDramaRecommendationModel.results[row])
            
            return cell
        case 2:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DramaCastInfoCollectionViewCell", for: indexPath) as? DramaCastInfoCollectionViewCell else {
                return UICollectionViewCell()
            }
            print("d우잉?")
            cell.configureCell(item: dramaCastInfoModel.cast[row])
            
            return cell
        default:
            return UICollectionViewCell()
        }
    }
}
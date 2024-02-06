//
//  DramaDetailViewController.swift
//  MyTVContents
//
//  Created by 조유진 on 1/31/24.
//

import UIKit
import SnapKit
import Kingfisher

enum Section: Int, CaseIterable {
    case drameInfo
    case similarDramaRecommendation
    case dramaCaseInfo
    
    var sectionHeight: CGFloat {
        switch self {
        case .drameInfo:
            return UIScreen.main.bounds.height / 2 + 50
        case .similarDramaRecommendation:
            return UIScreen.main.bounds.height / 2
        case .dramaCaseInfo:
            return UIScreen.main.bounds.height / 2
        }
    }
}

class DramaDetailViewController: BaseViewController {
    let mainView = DramaView()
    
    let titleList: [String] = ["드라마 정보", "비슷한 드라마 추천", "드라마 캐스트 정보"]
    
    var dramaInfoModel: DramaInfoModel = DramaInfoModel(backdropPath: nil, createdBy: [], id: 0, name: "", overview: "", numberOfEpisodes: 0, numberOfSeasons: 0)
    var similarDramaRecommendationModel: SimilarDramaRecommendationModel = SimilarDramaRecommendationModel(page: 0, results: [], totalPages: 0, totalResults: 0)
    var dramaCastInfoModel: DramaCastInfoModel = DramaCastInfoModel(cast: [], id: 0)
    var sectionList = Section.allCases
    var id = 96102
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        configureNavigationItem()
        callRequest()
    }
    
    override func loadView() {
        self.view = mainView
    }
    
    func callRequest() {
        let group = DispatchGroup()
        
        group.enter()
        TMDBAPIManager.shared.fetchTv(type: DramaInfoModel.self, api: .dramaInfo(id: id)) { dramaInfoModel, error in
            if error == nil {
                guard let dramaInfoModel = dramaInfoModel else { return }
                self.dramaInfoModel = dramaInfoModel
            } else {
                print("dramaInfoModel을 가져오는 요청 응답에 실패했습니다.")
            }
            group.leave()
        }
        
        group.enter()
        TMDBAPIManager.shared.fetchTv(type: SimilarDramaRecommendationModel.self, api: .similarDramaRecommendation(id: id)) { similarDramaRecommendationModel, error in
            if error == nil {
                guard let similarDramaRecommendationModel = similarDramaRecommendationModel else { return }
                self.similarDramaRecommendationModel = similarDramaRecommendationModel
            } else {
                print("similarDramaRecommendationModel을 가져오는 요청 응답에 실패했습니다.")
            }
            group.leave()
        }
        
        group.enter()
        TMDBAPIManager.shared.fetchTv(type: DramaCastInfoModel.self, api: .dramaCaseInfo(id: id)) { dramaCastInfoModel, error  in
            if error == nil {
                guard let dramaCastInfoModel = dramaCastInfoModel else { return }
                self.dramaCastInfoModel = dramaCastInfoModel
            } else {
                print("dramaCastInfoModel을 가져오는 요청 응답에 실패했습니다.")
            }
            group.leave()
        }
        
        group.notify(queue: .main) {
            self.mainView.tableView.reloadData()
        }
    }
    
    override func configureNavigationItem() {
        navigationItem.title = "드라마 세부 정보"
    }
    
    func configureTableView() {
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
    }
}

extension DramaDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case Section.drameInfo.rawValue:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "DramaInfoTableViewCell", for: indexPath) as? DramaInfoTableViewCell else { return UITableViewCell() }
            
            let item = dramaInfoModel
            cell.configureCell(dramaInfo: item)
            
            return cell
            
        case Section.similarDramaRecommendation.rawValue, Section.dramaCaseInfo.rawValue:
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
        return sectionList[indexPath.row].sectionHeight
    }

}

extension DramaDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2 
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView.tag {
        case Section.similarDramaRecommendation.rawValue:
            return similarDramaRecommendationModel.results.count
        case Section.dramaCaseInfo.rawValue:
            return dramaCastInfoModel.cast.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let section = collectionView.tag
        let row = indexPath.row
        
        switch collectionView.tag {
        case Section.similarDramaRecommendation.rawValue:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ContentCollectionViewCell", for: indexPath) as? ContentCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.configureCell(item: similarDramaRecommendationModel.results[row])
            
            return cell
        case Section.dramaCaseInfo.rawValue:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DramaCastInfoCollectionViewCell", for: indexPath) as? DramaCastInfoCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.configureCell(item: dramaCastInfoModel.cast[row])
            
            return cell
        default:
            return UICollectionViewCell()
        }
    }
}

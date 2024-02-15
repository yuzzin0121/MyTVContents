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
    case dramaInfo
    case selectInfo
    case selectedInfo
    
    var sectionHeight: CGFloat {
        switch self {
        case .dramaInfo:
            return UIScreen.main.bounds.height / 2 - 70
        case .selectInfo:
            return 50
        case .selectedInfo:
            return UIScreen.main.bounds.height / 2 - 30
        }
    }
}

enum Content: Int {
    case season
    case castInfo
    case similarDrama
}

final class DramaDetailViewController: BaseViewController {
    let mainView = DramaView()
    
    var dramaInfoModel: DramaInfoModel = DramaInfoModel(backdropPath: nil, createdBy: [], id: 0, name: "", overview: "", numberOfEpisodes: 0, numberOfSeasons: 0, seasons: [])
    var similarDramaRecommendationModel: SimilarDramaRecommendationModel = SimilarDramaRecommendationModel(page: 0, results: [], totalPages: 0, totalResults: 0)
    var dramaCastInfoModel: DramaCastInfoModel = DramaCastInfoModel(cast: [], id: 0)
    var sectionList = Section.allCases
    var id = 96102
    var currentSelectedIndex = 0
    var seasons: [Season] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        configureNavigationItem()
        callRequest()
    }
    
    override func loadView() {
        self.view = mainView
    }
    
    private func callRequest() {
        let group = DispatchGroup()
        
        group.enter()
        TMDBAPIManager.shared.fetchTv(type: DramaInfoModel.self, api: .dramaInfo(id: id)) { dramaInfoModel, error in
            if error == nil {
                guard let dramaInfoModel = dramaInfoModel else { return }
                self.dramaInfoModel = dramaInfoModel
                self.seasons = dramaInfoModel.seasons
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
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: ImageStyle.arrowLeft, style: .plain, target: self, action: #selector(popView))
    }

    @objc func popView() {
        navigationController?.popViewController(animated: true)
    }
    
    private func configureTableView() {
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
    }
    
    @objc func showInfoButtonClicked(sender: UIButton) {
        currentSelectedIndex = sender.tag
        sender.isSelected.toggle()
        mainView.tableView.reloadData()
    }
    
    private func setButtonDesign(button: UIButton, isClicked: Bool) {
        let color: UIColor = button.isSelected ? .white : .gray
        button.setTitleColor(color, for: .normal)
    }
    
    private func showEpisodeVC(seasonNumber: Int, seasonName: String) {
        let episodeVC = DramaEpisodeViewController()
        episodeVC.seriesId = dramaInfoModel.id
        episodeVC.seasonNumber = seasonNumber
        episodeVC.seasonName = seasonName
        navigationController?.pushViewController(episodeVC, animated: true)
    }
    
    private func showDetailVC(id: Int) {
        let detailVC = DramaDetailViewController()
        detailVC.id = id
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    private func showPlayVideoVC() {
        let videoVC = VideoViewController()
        
        videoVC.seriesId = dramaInfoModel.id
        
        navigationController?.pushViewController(videoVC, animated: true)
    }
    
    @objc private func dramaVideoTapped() {
        print("asdf")
        showPlayVideoVC()
    }
}

extension DramaDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sectionList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case Section.dramaInfo.rawValue:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: DramaInfoTableViewCell.identifier, for: indexPath) as? DramaInfoTableViewCell else { return UITableViewCell() }
            
            let item = dramaInfoModel
            cell.configureCell(dramaInfo: item)
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dramaVideoTapped))
            cell.backdropimageView.addGestureRecognizer(tapGesture)
            
            return cell
            
        case Section.selectInfo.rawValue:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SelectInfoTableViewCell.identifier, for: indexPath) as? SelectInfoTableViewCell else {
                return UITableViewCell()
            }
            
            cell.episodeButton.addTarget(self, action: #selector(showInfoButtonClicked), for: .touchUpInside)
            cell.castInfoButton.addTarget(self, action: #selector(showInfoButtonClicked), for: .touchUpInside)
            cell.similarContentsButton.addTarget(self, action: #selector(showInfoButtonClicked), for: .touchUpInside)
            
            return cell
            
        case Section.selectedInfo.rawValue:
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: InfoContentTableViewCell.identifier, for: indexPath) as? InfoContentTableViewCell else { return UITableViewCell()
            }
            
            cell.collectionView.delegate = self
            cell.collectionView.dataSource = self
            cell.collectionView.tag = indexPath.row
            cell.collectionView.reloadData()
            if currentSelectedIndex ==  Content.season.rawValue {
                cell.changeCollectionViewLayout(isSeason: true)
            } else {
                cell.changeCollectionViewLayout(isSeason: false)
            }
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
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch currentSelectedIndex {
        case Content.season.rawValue:
            return seasons.count
        case Content.castInfo.rawValue:
            return dramaCastInfoModel.cast.count
        case Content.similarDrama.rawValue:
            return similarDramaRecommendationModel.results.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let row = indexPath.row
        
        switch currentSelectedIndex {
        case Content.season.rawValue:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SeasonCollectionViewCell.identifier, for: indexPath) as? SeasonCollectionViewCell else {
                return UICollectionViewCell()
            }
            
            cell.configureCell(season: seasons[indexPath.row])
            
            return cell
        case Content.castInfo.rawValue:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DramaCastInfoCollectionViewCell.identifier, for: indexPath) as? DramaCastInfoCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.configureCell(item: dramaCastInfoModel.cast[row])
            
            return cell
            
        case Content.similarDrama.rawValue:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContentCollectionViewCell.identifier, for: indexPath) as? ContentCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.configureCell(item: similarDramaRecommendationModel.results[row])
            
            return cell
            
        default:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let row = indexPath.row
        switch currentSelectedIndex{
        case Content.season.rawValue:
            let season = seasons[row]
            showEpisodeVC(seasonNumber: season.seasonNumber, seasonName: season.name)
        case Content.similarDrama.rawValue:
            let similarDrama = similarDramaRecommendationModel.results[row]
            showDetailVC(id: similarDrama.id)
        default:
            return
        }
        
    }
}

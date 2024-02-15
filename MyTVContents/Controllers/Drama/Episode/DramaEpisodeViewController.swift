//
//  DramaEpisodeViewController.swift
//  MyTVContents
//
//  Created by 조유진 on 2/13/24.
//

import UIKit

final class DramaEpisodeViewController: BaseViewController {
    let mainView = EpisodeView()
    
    var seriesId: Int? = nil
    var seasonNumber: Int? = nil
    var seasonName: String = "에피소드 정보"
    var episodes: [Episode] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationItem()
        configureTableView()
        callRequest()
        // Do any additional setup after loading the view.
    }
    
    override func loadView() {
        view = mainView
    }
  
    override func configureNavigationItem() {
        navigationItem.title = seasonName
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: ImageStyle.arrowLeft, style: .plain, target: self, action: #selector(popView))
    }

    @objc func popView() {
        navigationController?.popViewController(animated: true)
    }
    
    private func configureTableView() {
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
        mainView.tableView.register(EpisodeTableViewCell.self, forCellReuseIdentifier: EpisodeTableViewCell.identifier)
    }
    
    private func callRequest() {
        guard let seriesId = seriesId else { return }
        guard let seasonNumber = seasonNumber else { return }
        TMDBAPIManager.shared.fetchTv(type: EpisodeDetail.self, api: .tvSeasonsDetails(seriesId: seriesId, seasonNumber: seasonNumber)) { episodeModel, error in
            if error == nil {
                guard let episodeModel = episodeModel else { return }
                self.episodes = episodeModel.episodes
                self.mainView.tableView.reloadData()
            } else {
                guard let error = error else { return }
                switch error {
                case .failedRequest:
                    print("failedRequest")
                case .noData:
                    print("noData")
                case .invalidResponse:
                    print("invalidResponse")
                case .invalidData:
                    print("invalidData")
                }
            }
        }
    }

}

extension DramaEpisodeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return episodes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: EpisodeTableViewCell.identifier, for: indexPath) as? EpisodeTableViewCell else {
            return UITableViewCell()
        }
        
        cell.configureCell(episode: episodes[indexPath.row])
        
        return cell
    }
    
    
}

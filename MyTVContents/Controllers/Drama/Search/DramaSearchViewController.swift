//
//  DramaSearchViewController.swift
//  MyTVContents
//
//  Created by 조유진 on 2/5/24.
//

import UIKit

final class DramaSearchViewController: UIViewController {
    let mainView = DramaSearchView()
    
    var searchedDramaList: [TV] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        configureNavigationItem()
    }
    
    private func callRequest(query: String) {
        TMDBAPIManager.shared.fetchTv(type: TVContentsModel.self, api: TMDBAPI.dramaSearch(query: query)) { tvContentsModel, error in
            if error == nil {
                guard let tvContentsModel = tvContentsModel else { return }
                self.searchedDramaList = tvContentsModel.results
                self.mainView.collectionView.reloadData()
            } else {
                print("응답에 실패했습니다.")
            }
        }
    }
    
    override func loadView() {
        super.loadView()
        self.view = mainView
    }
    
    private func configureCollectionView() {
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
    }
    
    private func configureNavigationItem() {
        navigationItem.title = "드라마 검색"
        navigationItem.searchController = mainView.searchController
        mainView.searchController.searchBar.delegate = self
    }
}

extension DramaSearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else { return }
        callRequest(query: text)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchedDramaList = []
        mainView.collectionView.reloadData()
    }
}

extension DramaSearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        searchedDramaList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ContentCollectionViewCell", for: indexPath) as? ContentCollectionViewCell else {
            return UICollectionViewCell()
        }
     
        cell.titleLabel.text = searchedDramaList[indexPath.row].name
        
        if let urlString = searchedDramaList[indexPath.row].posterPath, let url = URL(string: EndPoint.basePosterURL.rawValue + urlString) {
           
            cell.posterImageView.kf.setImage(with: url, placeholder: ImageStyle.movieClapper)
        } else {
            cell.posterImageView.image = ImageStyle.movieClapper
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let index = indexPath.row
        let dramaDetailVC = DramaDetailViewController()
        dramaDetailVC.id = searchedDramaList[index].id
        navigationController?.pushViewController(dramaDetailVC, animated: true)
    }
}

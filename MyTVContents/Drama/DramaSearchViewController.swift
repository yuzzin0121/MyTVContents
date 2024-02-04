//
//  DramaSearchViewController.swift
//  MyTVContents
//
//  Created by 조유진 on 2/5/24.
//

import UIKit

class DramaSearchViewController: UIViewController {
    let mainView = DramaSearchView()
    
    var searchedDramaList: [TV] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        configureNavigationItem()
    }
    
    func callRequest(query: String) {
        TMDBAPIManager.shared.fetchTv(type: TVContentsModel.self, api: TMDBAPI.dramaSearch(query: query)) { tvContentsModel in
            self.searchedDramaList = tvContentsModel.results
            self.mainView.collectionView.reloadData()
        }
    }
    
    override func loadView() {
        super.loadView()
        self.view = mainView
    }
    
    func configureCollectionView() {
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
    }
    
    func configureNavigationItem() {
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
           
            cell.posterImageView.kf.setImage(with: url, placeholder: UIImage(systemName: "movieclapper"))
        } else {
            cell.posterImageView.image = UIImage(systemName: "movieclapper")
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("클릭")
        let index = indexPath.row
        let dramaDetailVC = DramaDetailViewController()
        dramaDetailVC.id = searchedDramaList[index].id
        navigationController?.pushViewController(dramaDetailVC, animated: true)
    }
}

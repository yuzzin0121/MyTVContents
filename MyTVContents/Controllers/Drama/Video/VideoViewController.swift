//
//  VideoViewController.swift
//  MyTVContents
//
//  Created by 조유진 on 2/14/24.
//

import UIKit

final class VideoViewController: BaseViewController {
    let mainView = VideoView()

    var seriesId: Int? = nil
    var videoResult: [Video] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        callRequest()
    }
    override func configureNavigationItem() {
        navigationItem.title = "비디오"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: ImageStyle.arrowLeft, style: .plain, target: self, action: #selector(popView))
    }

    @objc func popView() {
        navigationController?.popViewController(animated: true)
    }
    
    private func callRequest() {
        guard let seriesId = seriesId else { return }
        TMDBAPIManager.shared.fetchTv(type: VideoModel.self, api: .video(seriesId: seriesId)) { VideoModel, error in
            if error == nil {
                guard let videoModel = VideoModel else { return }
                self.videoResult = videoModel.results
                self.loadWebview()
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
    
    private func loadWebview() {
        if videoResult.isEmpty {
            return
        } else {
            let key = videoResult[0].key
            if let url = URL(string: TMDBAPI.videoBaseURL + key) {
                let request = URLRequest(url: url)
                mainView.webView.load(request)
            }
        }
    }
    
    override func loadView() {
        view = mainView
    }
}

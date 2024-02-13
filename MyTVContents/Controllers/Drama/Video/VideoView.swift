//
//  videoView.swift
//  MyTVContents
//
//  Created by 조유진 on 2/14/24.
//

import UIKit
import WebKit
import SnapKit

final class VideoView: BaseView {
    let webView = WKWebView()
    
    override func configureHierarchy() {
        addSubview(webView)
    }
    
    override func configureLayout() {
        webView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
    }
    
    override func configureView() {
        webView.backgroundColor = .black
    }
}

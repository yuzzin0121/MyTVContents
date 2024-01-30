//
//  UIView+Extension.swift
//  MyTVContents
//
//  Created by 조유진 on 1/31/24.
//

import UIKit

extension UIView {
    func applyGradientBackground() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.bounds

        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.withAlphaComponent(0.5).cgColor]
        gradientLayer.locations = [0.0, 1.0]

        // 그레디언트 방향 설정 (위에서 아래로)
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.6)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)

        // 뷰의 배경으로 그레디언트 레이어 추가
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
}

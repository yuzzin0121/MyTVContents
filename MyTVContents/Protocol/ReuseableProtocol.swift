//
//  ReuseableProtocol.swift
//  MyTVContents
//
//  Created by 조유진 on 2/9/24.
//

import UIKit

protocol ReuseableProtocol: AnyObject {
    static var identifier: String { get }
}

extension UITableViewCell: ReuseableProtocol {
    static var identifier: String {
        String(describing: self)
    }
}

extension UICollectionViewCell: ReuseableProtocol {
    static var identifier: String {
        String(describing: self)
    }
}

extension UIViewController: ReuseableProtocol {
    static var identifier: String {
        String(describing: self)
    }
}

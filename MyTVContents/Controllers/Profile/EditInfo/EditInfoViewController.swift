//
//  EditInfoViewController.swift
//  MyTVContents
//
//  Created by 조유진 on 2/14/24.
//

import UIKit

final class EditInfoViewController: BaseViewController {
    let mainView = EditInfoView()
    
    var infoTitle: String? = nil
    var index: Int? = nil
    var completionHandler: ((String?, Int) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationItem()
        configureView()
    }
    
    override func configureNavigationItem() {
        navigationItem.title = "사용자 정보 수정"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: ImageStyle.arrowLeft, style: .plain, target: self, action: #selector(popView))
    }
    
    @objc func popView() {
        guard let index = index else { return }
        completionHandler?(mainView.textField.text, index)
        navigationController?.popViewController(animated: true)
    }
    
    private func configureView() {
        guard let index = index else { return }
        guard let infoTitle = infoTitle else { return }
        navigationItem.title = infoTitle
        mainView.textField.placeholder = infoTitle
        mainView.textField.attributedPlaceholder = NSAttributedString(string: infoTitle,
                                                 attributes: [
                                                    .foregroundColor: UIColor.lightGray
                                                 ])
    }
    
    override func loadView() {
        view = mainView
    }

}

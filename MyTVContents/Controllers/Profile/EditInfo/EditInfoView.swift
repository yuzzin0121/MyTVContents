//
//  EditInfoView.swift
//  MyTVContents
//
//  Created by 조유진 on 2/14/24.
//

import UIKit
import SnapKit

final class EditInfoView: BaseView {
    let textField = ProfileTextField()
    
    override func configureHierarchy() {
        addSubview(textField)
    }
    
    override func configureLayout() {
        textField.snp.makeConstraints { make in
            make.horizontalEdges.top.equalToSuperview().inset(24)
            make.height.equalTo(50)
        }
    }
    
    override func configureView() {
        
    }
}

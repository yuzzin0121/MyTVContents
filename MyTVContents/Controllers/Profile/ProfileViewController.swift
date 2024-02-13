//
//  ProfileViewController.swift
//  MyTVContents
//
//  Created by 조유진 on 2/14/24.
//

import UIKit

enum ProfileInfo: Int, CaseIterable {
    case name
    case nickname
    case introduce
    case link
    case gender
    
    var title: String {
        switch self {
        case .name: return "이름"
        case .nickname: return "닉네임"
        case .introduce: return "자기소개"
        case .link: return "링크"
        case .gender: return "성별"
        }
    }
}

final class ProfileViewController: BaseViewController {
    let mainView = ProfileView()
    var profileInfoList = ProfileInfo.allCases
    var infoValueList: [String?] = [nil, nil, nil, nil, nil]

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureTableView()
    }

    override func loadView() {
        view = mainView
    }
    
    private func configureView() {
        mainView.imageModifyButton.addTarget(self, action: #selector(modifyProfileImageButtonClicked), for: .touchUpInside)
    }
    
    @objc private func modifyProfileImageButtonClicked() {
        showSelectProfileImageVC()
    }
    
    // 프로필 이미지 선택 화면으로 이동
    private func showSelectProfileImageVC() {
        let profileImageSelectVC = ProfileImageSelectViewController()
        profileImageSelectVC.completionHandler = { link in
            if let link = link {
                self.setProfileImage(link: link)
            }
        }
        navigationController?.pushViewController(profileImageSelectVC, animated: true)
    }
    
    // 선택된 링크로 프로필 이미지 설정
    private func setProfileImage(link: String) {
        if let url = URL(string: link) {
            mainView.profileImageView.kf.setImage(with: url, placeholder: ImageStyle.personCircle)
        } else {
            mainView.profileImageView.image = ImageStyle.personCircle
        }
    }
    
    private func configureTableView() {
        mainView.textFieldTableView.delegate = self
        mainView.textFieldTableView.dataSource = self
    }
    
    // 텍스트필드 입력 화면으로 이동
    private func showEditInfoVC(title: String, index: Int) {
        let editInfoVC = EditInfoViewController()
        editInfoVC.infoTitle = title
        editInfoVC.index = index
        editInfoVC.completionHandler = { value, index in
            self.infoValueList[index] = value
            self.mainView.textFieldTableView.reloadData()
        }
        navigationController?.pushViewController(editInfoVC, animated: true)
    }
}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        profileInfoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TextFieldTableViewCell.identifier, for: indexPath) as? TextFieldTableViewCell else {
            return UITableViewCell()
        }
        
        cell.configureCell(title: profileInfoList[indexPath.row].title)
        if let value = infoValueList[indexPath.row] {
            cell.textField.text = value
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let index = indexPath.row
        showEditInfoVC(title: profileInfoList[index].title, index: index)
    }
}

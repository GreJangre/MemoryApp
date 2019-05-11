//
//  ProfileVC.swift
//  MemoryApp
//
//  Created by 임성주 on 18/03/2019.
//  Copyright © 2019 jangre. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let profileImage = UIImageView()
    let tv = UITableView()
    let uinfo = UserInfoManager()
    
    // MARK: Override
    override func viewDidLoad() {
        self.navigationItem.title = "프로필"
        
        let backBtn = UIBarButtonItem(title: "닫기", style: .plain, target: self, action: #selector(close(_:)))
        self.navigationItem.leftBarButtonItem = backBtn
        
        let bg = UIImage(named: "profile-bg")
        let bgImage = UIImageView(image: bg)
        
        bgImage.frame.size = CGSize(width: bgImage.frame.size.width, height: bgImage.frame.size.height)
        bgImage.center = CGPoint(x: self.view.frame.width / 2, y: 40)
        
        bgImage.layer.cornerRadius = bgImage.frame.size.width / 2
        bgImage.layer.borderWidth = 0
        bgImage.layer.masksToBounds = true
        
        self.view.addSubview(bgImage)
        
        // 프로필 이미지
        let image = self.uinfo.profile
        
        self.profileImage.image = image
        self.profileImage.frame.size = CGSize(width: 100, height: 100)
        self.profileImage.center = CGPoint(x: self.view.frame.width / 2, y: 270)
        
        self.profileImage.layer.cornerRadius = self.profileImage.frame.width / 2
        self.profileImage.layer.borderWidth = 0
        self.profileImage.layer.masksToBounds = true
        
        self.view.addSubview(self.profileImage)
        
        // 프로필 내용
        self.tv.frame = CGRect(x: 0, y: self.profileImage.frame.origin.y + self.profileImage.frame.size.height + 20, width: self.view.frame.width, height: 100)
        self.tv.dataSource = self
        self.tv.delegate = self
        
        self.view.addSubview(self.tv)
        
        self.navigationController?.navigationBar.isHidden = true
    }
    
    // MARK: Data source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value1, reuseIdentifier: "cell")
        
        cell.textLabel?.font = UIFont.systemFont(ofSize: 14)
        cell.detailTextLabel?.font = UIFont.systemFont(ofSize: 13)
        cell.accessoryType = .disclosureIndicator
        
        switch indexPath.row {
        case 0:
            cell.textLabel?.text = "이름"
            cell.detailTextLabel?.text = self.uinfo.name ?? "Login please"
        case 1:
            cell.textLabel?.text = "계정"
            cell.detailTextLabel?.text = self.uinfo.account ?? "Login please"
        default:
            ()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if self.uinfo.isLogin == false {
            self.doLogin(self.tv)
        }
    }
    
    // MARK: @objc
    @objc func close(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true)
    }
    
    @objc func doLogin(_ sender: Any) {
        let loginAlert = UIAlertController(title: "LOGIN", message: nil, preferredStyle: .alert)

        loginAlert.addTextField() { (tf) in
            tf.placeholder = "Your Account"
        }
        loginAlert.addTextField() { (tf) in
            tf.placeholder = "Password"
            tf.isSecureTextEntry = true
        }
        loginAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        loginAlert.addAction(UIAlertAction(title: "Login", style: .destructive) { (_) in
            let account = loginAlert.textFields?[0].text ?? ""
            let passwd = loginAlert.textFields?[1].text ?? ""

            if self.uinfo.login(account: account, passwd: passwd) {
                self.tv.reloadData()
                self.profileImage.image = self.uinfo.profile
            } else {
                let msg = "로그인에 실패하였습니다."
                let alert = UIAlertController(title: nil, message: msg, preferredStyle: .alert)

                alert.addAction(UIAlertAction(title: "OK", style: .cancel))
                self.present(alert, animated: false)
            }
        })
        self.present(loginAlert, animated: false)
    }

    @objc func doLogout(_ sender: Any) {
        let msg = "로그아웃하시겠습니까?"
        let alert = UIAlertController(title: nil, message: msg, preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "취소", style: .cancel))
        alert.addAction(UIAlertAction(title: "확인", style: .destructive) { (_) in
            if self.uinfo.logout() {
                self.tv.reloadData()
                self.profileImage.image = self.uinfo.profile
            }
        })
        self.present(alert, animated: false)
    }
}

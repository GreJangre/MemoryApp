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
    
    // MARK: Override
    override func viewDidLoad() {
        self.navigationItem.title = "프로필"
        
        let backBtn = UIBarButtonItem(title: "닫기", style: .plain, target: self, action: #selector(close(_:)))
        self.navigationItem.leftBarButtonItem = backBtn
    }
    
    // MARK: Data source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        return cell
    }
    
    // MARK: objc
    @objc func close(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true)
    }
}

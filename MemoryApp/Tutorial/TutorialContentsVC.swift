//
//  TutorialContentsVC.swift
//  MemoryApp
//
//  Created by 임성주 on 26/05/2019.
//  Copyright © 2019 jangre. All rights reserved.
//

import Foundation

class TutorialContentsVC: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bgImageView: UIImageView!
    
    var pageIndex: Int!
    var titleText: String!
    var imageFile: String!
    
    override func viewDidLoad() {
        // 외부에서 전달받은 정보 대입
        self.titleLabel.text = self.titleText
        self.titleLabel.sizeToFit()
        self.bgImageView.image = UIImage(named: self.imageFile)
    }
}

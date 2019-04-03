//
//  CSLogButton.swift
//  MemoryApp
//
//  Created by 임성주 on 12/03/2019.
//  Copyright © 2019 jangre. All rights reserved.
//

import UIKit

public enum CSLogType: Int {
    case basic
    case title
    case tag
}

// API
public class CSLogButton: UIButton {
    public var logType: CSLogType = .basic
    
    // MARK: init
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.setBackgroundImage(UIImage(named: "button-bg"), for: .normal)
        self.tintColor = UIColor.white
        
        self.addTarget(self, action: #selector(logging(_:)), for: .touchUpInside)
    }
    
    // MARK: objc
    @objc func logging(_ sender: UIButton) {
        switch self.logType {
        case .basic:
            NSLog("버튼이 클릭되었습니다.")
        case .title:
            let btnTitle = sender.titleLabel?.text ?? "타이틀 없는"
            NSLog("\(btnTitle) 버튼이 클릭되었습니다.")
        case .tag:
            NSLog("\(sender.tag) 버튼이 클릭되었습니다.")
        }
    }
}

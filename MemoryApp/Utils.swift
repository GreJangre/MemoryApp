//
//  Utils.swift
//  MemoryApp
//
//  Created by 임성주 on 26/05/2019.
//  Copyright © 2019 jangre. All rights reserved.
//

import Foundation

extension UIViewController {
    var tutorialSB: UIStoryboard {
        return UIStoryboard(name: "Tutorial", bundle: Bundle.main)
    }
    func instanceTutorialVC(name: String) -> UIViewController? {
        return self.tutorialSB.instantiateViewController(withIdentifier: name)
    }
}

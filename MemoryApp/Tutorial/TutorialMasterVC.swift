//
//  TutorialMasterVC.swift
//  MemoryApp
//
//  Created by 임성주 on 26/05/2019.
//  Copyright © 2019 jangre. All rights reserved.
//

import Foundation

class TutorialMasterVC: UIViewController, UIPageViewControllerDataSource {
    var pageVC: UIPageViewController!
    
    var contentTitles = ["STEP 1", "STEP 2", "STEP 3", "STEP 4"]
    var contentImages = ["Page0", "Page1", "Page2", "Page3"]
    
    @IBAction func close(_ sender: Any) {
        let ud = UserDefaults.standard
        ud.set(true, forKey: UserInfoKey.tutorial)
        ud.synchronize()
        
        self.presentingViewController?.dismiss(animated: true)
    }
    override func viewDidLoad() {
        
        // 페이지 뷰 컨트롤러 객체 생성
        self.pageVC = self.instanceTutorialVC(name: "PageVC") as? UIPageViewController
        self.pageVC.dataSource = self
        
        // 기본 페이지
        let startContentVC = self.getContentVC(atIndex: 0)!
        self.pageVC.setViewControllers([startContentVC], direction: .forward, animated: true)
        
        // 출력 영역 지정
        self.pageVC.view.frame.origin = CGPoint(x: 0, y: 0)
        self.pageVC.view.frame.size.width = self.view.frame.width
        self.pageVC.view.frame.size.height = self.view.frame.height - 50
        
        // 자식 뷰 컨트롤러 설정
        self.addChild(self.pageVC)
        self.view.addSubview(self.pageVC.view)
        self.pageVC.didMove(toParent: self)
    }
    
    func getContentVC(atIndex idx: Int) -> UIViewController? {
        // 인덱스가 데이터 배열 크기 범위를 벗어나면 nil
        guard self.contentTitles.count >= idx && self.contentTitles.count > 0 else {
            return nil
        }
        
        guard let cvc = self.instanceTutorialVC(name: "ContentsVC") as? TutorialContentsVC else {
            return nil
        }
        
        cvc.titleText = self.contentTitles[idx]
        cvc.imageFile = self.contentImages[idx]
        cvc.pageIndex = idx
        return cvc
    }
    
    // before
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        // 현재 index
        guard var index = (viewController as! TutorialContentsVC).pageIndex else {
            return nil
        }
        
        // index < 0 -> nil
        guard index > 0 else {
            return nil
        }
        
        index -= 1
        return self.getContentVC(atIndex: index)
    }
    
    // after
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        // 현재 index
        guard var index = (viewController as! TutorialContentsVC).pageIndex else {
            return nil
        }
        
        index += 1
        
        // 배열 크기 > 다음 인덱스 -> nil
        guard index < self.contentTitles.count else {
            return nil
        }
        
        return self.getContentVC(atIndex: index)
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return self.contentTitles.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0
    }
}


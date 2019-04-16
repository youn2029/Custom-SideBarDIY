//
//  FrontViewController.swift
//  Custom-SideBarDIY
//
//  Created by 윤성호 on 16/04/2019.
//  Copyright © 2019 윤성호. All rights reserved.
//

import UIKit

class FrontViewController: UIViewController {
    
    // 사이드 바 오픈 기능을 위임할 델리게이트
    var delegate: RevealViewController?

    override func viewDidLoad() {
        super.viewDidLoad()

        // 사이드 바 버튼
        let btnSideBar = UIBarButtonItem(
            image: UIImage(named: "sidemenu"),
            style: .plain,
            target: self,
            action: #selector(moveSide(_:)))
        
        // 왼쪽 영역에 사이드 바 버튼 추가
        self.navigationItem.leftBarButtonItem = btnSideBar
    }
    
    // 사용자의 액션에 따라 델리게이트 메소드를 호출
    @objc func moveSide(_ sender: Any){
        if self.delegate?.isSideBarShowing == false {
            self.delegate?.openSideBar(nil)
        }else {
            self.delegate?.closeSideBar(nil)
        }
    }

}

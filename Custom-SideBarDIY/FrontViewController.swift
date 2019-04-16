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
        
        // 화면 끝에서 다른 쪽으로 패닝하는 제스처를 정의 (열기)
        let dragLeft = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(moveSide(_:)))
        dragLeft.edges = UIRectEdge.left            // 시작 모서리는 왼쪽
        self.view.addGestureRecognizer(dragLeft)    // 뷰에 제스처 객체를 등록
        
        // 화면을 스와이프하는 제스처를 정의 (닫기)
        let dragRight = UISwipeGestureRecognizer(target: self, action: #selector(moveSide(_:)))
        dragRight.direction = .left     // 방향은 왼쪽
        self.view.addGestureRecognizer(dragRight)
    }
    
    // 사용자의 액션에 따라 델리게이트 메소드를 호출
    @objc func moveSide(_ sender: Any){
        
        if sender is UIScreenEdgePanGestureRecognizer {     // 왼쪽 끝에서 오른쪽 끝으로 드래그하는 동작일 때
            self.delegate?.openSideBar(nil)
        }else if sender is UISwipeGestureRecognizer {       // 중간 위치에서 드래그하는 동작일 때
            self.delegate?.closeSideBar(nil)
        }else if sender is UIBarButtonItem {                // 버튼을 이용했을 때
            if self.delegate?.isSideBarShowing == false {
                self.delegate?.openSideBar(nil)
            }else {
                self.delegate?.closeSideBar(nil)
            }
        }
        
        
    }

}

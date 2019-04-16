//
//  RevealViewController.swift
//  Custom-SideBarDIY
//
//  Created by 윤성호 on 16/04/2019.
//  Copyright © 2019 윤성호. All rights reserved.
//

import UIKit

// 프론트 컨트롤러에서 뷰를 가져아 메인 화면에 보여주는 역할
// 사이드 바 컨트롤러에서 뷰를 가져와 필요한 시기에 열어주는 역할
class RevealViewController: UIViewController {
    
    var contentVC: UIViewController?        // 콘텐츠를 담당할 뷰 컨트롤러
    var sideVC: UIViewController?           // 사이드 바 뷰 컨트롤러
    
    var isSideBarShowing = false            // 사이드 바가 열려 있는지 여부
    
    let SLIDE_TIME = 0.3                    // 사이드 바 애니메이션 시간
    let SIDEBAR_WIDTH: CGFloat = 260        // 사이드 바가 표시될 너비

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupView()
    }
    
    // 초기 화면을 설정
    func setupView(){
        
        // _프론트 컨트롤러 객체를 읽어온다
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "sw_front") as? UINavigationController {
            
            // 읽어온 컨트롤러를 클래스 전체에서 참조할 수 있도록 contentVC 속성에 저장
            self.contentVC = vc
            
            // _프론트 컨트롤러 객체를 메인 컨트롤러의 자식으로 등록
            self.addChild(vc)
            
            // _프론트 컨트롤러의 뷰를 메인 컨트롤러의 서브 뷰로 등록
            self.view.addSubview(vc.view)
            
            // _프론트 컨트롤러에 부모 뷰 컨트롤러가 바뀌었음을 알려준다
            vc.didMove(toParent: self)
        }
    }
    
    // 사이드 바의 뷰를 읽어옴
    func getSideView(){
        
        if self.sideVC == nil {
        
            // 사이드 바 컨트롤러 객체를 읽어온다
            if let vc = self.storyboard?.instantiateViewController(withIdentifier: "sw_rear"){
                
                // 다른 메소드에서도 참조할 수 있도록 sideVC 속성에 저장
                self.sideVC = vc
                
                // 읽어온 사이드 바 컨트롤러 객체를 컨테이너 뷰 컨트롤러에 연결
                self.addChild(vc)
                self.view.addSubview(vc.view)
                
                // _프론트 컨트롤러에 부모 뷰 컨트롤러가 바뀌었음을 알려준다
                vc.didMove(toParent: self)
                
                // _프론트 컨트롤러의 뷰를 제일 위로 올린다
                self.view.bringSubviewToFront((self.contentVC?.view)!)
            }
        }
    }
    
    // 콘텐츠 뷰에 그림자 효과를 준다
    func setShadowEffect(shadow: Bool, offset: CGFloat){
        
        if (shadow == true) {   // 그림자 효과 설정
            self.contentVC?.view.layer.cornerRadius = 10                                        // 그림자 모서리 둥글기
            self.contentVC?.view.layer.shadowOpacity = 0.8                                      // 그림자 투명도
            self.contentVC?.view.layer.shadowColor = UIColor.black.cgColor                      // 그림자 색상
            self.contentVC?.view.layer.shadowOffset = CGSize(width: offset, height: offset)     // 그림자 크기
        } else {
            self.contentVC?.view.layer.cornerRadius = 0.0
            self.contentVC?.view.layer.shadowOffset = CGSize(width: 0, height: 0)
        }
    }
    
    // 사이드 바 열기
    func openSideBar(_ complete: ( () -> Void)? ) {
        
        self.getSideView()
        self.setShadowEffect(shadow: true, offset: -2)
        
        // 애니메이션
        let options = UIView.AnimationOptions(arrayLiteral: [.curveEaseInOut, .beginFromCurrentState])
        
        // 애니메이션 실행
        UIView.animate(
            withDuration: TimeInterval(self.SLIDE_TIME),
            delay: TimeInterval(0), options: options,
            animations: {
                self.contentVC?.view.frame = CGRect(x: self.SIDEBAR_WIDTH, y: 0, width: self.view.frame.width, height: self.view.frame.height)
            }, completion: {
                if $0 == true { // 애니메이션이 정상적으로 종료되었을 때 true
                    self.isSideBarShowing = true        // 열림 상태로 플래그를 변경한다.
                    complete?()
                }
            }
        )
        
        
    }
    
    // 사이드 바 닫기
    func closeSideBar(_ complete: ( () -> Void)? ) {
        
        // 애니메이션 옵션을 정의한다
        let options = UIView.AnimationOptions(arrayLiteral: [.curveEaseInOut, .beginFromCurrentState])
        
        // 애니메이션을 실행
        UIView.animate(
            withDuration: TimeInterval(self.SLIDE_TIME),
            delay: TimeInterval(0),
            options: options,
            animations: {
                // 옆으로 밀려난 콘튼츠 뷰의 위치를 제자리로
                self.contentVC?.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
            },
            completion: {
                if $0 == true {
                    
                    // 사이드 바 뷰를 제거
                    self.sideVC?.view.removeFromSuperview()
                    self.sideVC = nil
                    
                    // 닫힘 상태로 프래그를 변경
                    self.isSideBarShowing = false
                    
                    // 그림자 효과를 제거
                    self.setShadowEffect(shadow: false, offset: 0)
                    
                    // 인자값으로 입력받은 완료 함수를 실행
                    complete?()
                }
            }
        )
    }

}

//
//  SideBarViewController.swift
//  Custom-SideBarDIY
//
//  Created by 윤성호 on 16/04/2019.
//  Copyright © 2019 윤성호. All rights reserved.
//

import UIKit

class SideBarViewController: UITableViewController {
    
    // 메뉴 제목 배열
    let titles = [
        "메뉴 01",
        "메뉴 02",
        "메뉴 03",
        "메뉴 04",
        "메뉴 05"
    ]
    
    // 메뉴 아이콘 배열
    let icons = [
        UIImage(named: "icon01"),
        UIImage(named: "icon02"),
        UIImage(named: "icon03"),
        UIImage(named: "icon04"),
        UIImage(named: "icon05")
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 계정 정보를 표시할 레이블 객체를 정의
        let accountLabel = UILabel()
        accountLabel.frame = CGRect(x: 10, y: 30, width: self.view.frame.width, height: 30)
        accountLabel.text = "youn2029@naver.com"
        accountLabel.textColor = .white
        accountLabel.font = .boldSystemFont(ofSize: 15)
        
        // 레이블 뷰 상단에 표시될 뷰를 정의
        let v = UIView()
        v.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 70)
        v.backgroundColor = .brown
        v.addSubview(accountLabel)
        
        // 생성한 뷰를 레이블 헤더 뷰 영역에 등록
        self.tableView.tableHeaderView = v
    }

    // 테이블 셀의 갯수
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.titles.count
    }
    
    // 테이블 셀의 구성
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        /*
        /// 테이블에 사용되는 데이터가 많은 경우
         
        // 재사용 큐로부터 테이블 셀 꺼내오기, nil이면 셀이 없다면 새로 추가
        let id = "menucell"
        let cell = tableView.dequeueReusableCell(withIdentifier: id) ?? UITableViewCell(style: .default, reuseIdentifier: id)
        
        // 타이틀과 이미지를 태입
        cell.textLabel?.text = self.titles[indexPath.row]
        cell.imageView?.image = self.icons[indexPath.row]
        
        // 폰트 설정
        cell.textLabel?.font = UIFont.systemFont(ofSize: 14)
         */
        
        /// 테이블에 사용되는 데이터가 적은 경우
        
        // 매번 셀을 새로 생성
        let cell = UITableViewCell()
        
        cell.textLabel?.text = self.titles[indexPath.row]
        cell.textLabel?.font = .systemFont(ofSize: 14)
        cell.imageView?.image = self.icons[indexPath.row]
        
        return cell
        
    }
    
}

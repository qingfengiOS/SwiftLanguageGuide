//
//  patternMatching.swift
//  SwiftDemo
//
//  Created by ios on 2019/2/22.
//  Copyright © 2019年 情风. All rights reserved.
//
// where和模式匹配
import UIKit

class patternMatching: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        whereInSwitchCase()
    }
    
    func whereInSwitchCase() {
        let name = ["Aiden", "Nice", "Alen"]
        name.forEach {
            switch $0 {
            case let x where x.hasPrefix("A"):
                print("\(x) hasPrefix:A")
            default:
                print("Hello \($0)")
            }
        }
        
        let num: [Int?] = [58, 99, 68, nil]
        let num2 = num.compactMap { $0 }
        for score in num2 where score >= 60 {
            print("合格分数有：\(score)")
        }
        
        
    }

}

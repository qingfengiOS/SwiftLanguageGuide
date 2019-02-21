//
//  MutiParamterFunction.swift
//  SwiftDemo
//
//  Created by ios on 2019/2/19.
//  Copyright © 2019年 情风. All rights reserved.
//
// 可变参数函数
import UIKit

class MutiParamterFunction: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        let result = sum(input: 1, 2, 3, 4, 5)
        print("result = \(result)")
        
        myFunc(numbers: 1, 2, 3, string: "Hello")
    }
    
    /**
     写一个可变参数的函数只需要在声明参数时在类型后面加上 ... 就可以了。比如下面就声明了一个接受可变参数的 Int 累加函数
     
     输入的 input 在函数体内部将被作为数组 [Int] 来使用，让我们来完成上面的方法吧。当然你可以用传统的 for...in 做累加，但是这里我们选择了一种看起来更 Swift 的方式:
     */
    func sum(input: Int...) -> Int {
        return input.reduce(0, +)
    }

    func myFunc(numbers: Int..., string: String) {
        numbers.forEach { (num) in
            print("\(num * 10):\(string)")
        }
        
//        numbers.forEach {
//            for i in 0..<$0 {
//                print("\(i):\(string)")
//            }
//        }
    }
}

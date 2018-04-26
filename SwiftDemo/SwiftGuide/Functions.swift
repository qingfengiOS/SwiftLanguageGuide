//
//  Functions.swift
//  SwiftDemo
//
//  Created by liyiping on 2018/4/26.
//  Copyright © 2018年 情风. All rights reserved.
//

import UIKit

class Functions: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.white
        
        print(greet(person: "Anna"))
        
        print(sayHello())
        
        let bounds = minMax(array: [8, -6, 2, 109, 3, 71])
        print("min is \(bounds.min) and max is \(bounds.max)")
        
        if let bound = minMaxOption(array: []) {
            print("min is \(bound.min) and max is \(bound.max)")
        } else {
            print("return value is nil")
        }
    }

    
    // 方法的定义和调用
    func greet(person: String) -> String {
        let greeting = "hello," + person + "!"
        return greeting
    }
    
    func greetAgain(person: String) -> String {
        let greeting = "hello," + person + "again" + "!"
        return greeting
    }
    
    //MARK:-方法的参数和返回值
    
    //无参数有返回值
    func sayHello() -> String {
        return "hello world"
    }
    
    //多个参数
    func greet(person: String, alreadyGreeted: Bool) -> String {
        if alreadyGreeted {
            return greetAgain(person: person)
        } else {
            return greet(person: person)
        }
    }
    
    //无返回值
    func greeting(person: String) {
        print("Hello, \(person)!")
        
    }
   
    //多重返回值
    func minMax(array: [Int]) -> (min: Int, max: Int) {
        var currentMin = array[0]
        var currentMax = array[0]
        for value in array[1..<array.count] {
            if value < currentMin {
                currentMin = value
            } else if value > currentMax {
                currentMax = value
            }
        }
        return (currentMin, currentMax)
    }
    
    
    //可选元组返回类型
    //如果函数返回的元组类型有可能整个元组都“没有值”，你可以使用可选的( optional ) 元组返回类型反映 整个元组可以是nil的事实。你可以通过在元组类型的右括号后放置一个问号来定义一个可选元组，例如 (Int, Int)? 或 (String, Int, Bool)?
    
    func minMaxOption(array: [Int]) -> (min: Int, max:Int)? {
        if array.isEmpty {
            return nil;
        }
        var currentMin = array[0]
        var currentMax = array[0]
        for value in array[1..<array.count] {
            if value < currentMin {
                currentMin = value
            } else if value > currentMax {
                currentMax = value
            }
        }
        return (currentMin, currentMax)
    }
    
    
}

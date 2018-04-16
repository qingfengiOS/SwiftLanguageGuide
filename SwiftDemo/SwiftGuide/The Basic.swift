//
//  The Basic.swift
//  SwiftDemo
//
//  Created by liyiping on 2018/4/11.
//  Copyright © 2018年 情风. All rights reserved.
//

import UIKit

class The_Basic: UIViewController {

    var taArray = ["The Basic","Basic Operations"]
   
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        declaring()
        typeAnnotations()
        nameVariables()
        varAndLet()
        IntegerBounds()
        typeInference()
        numericLiterals()
    }
    
    /// 定义常量/变量
    func declaring() {
        let maximumNumberOfLoginAttempts = 10
        var currentLoginAttempt = 0
        currentLoginAttempt = 1
        let x = 2, y = 3 ,z = 5
        print(maximumNumberOfLoginAttempts,currentLoginAttempt,x,y,z)
    }
   
    
    /// 类型注释
    func typeAnnotations () {
        var welcome : String
        welcome = "hello"
        print(welcome)
        
        var red,blue,green : Double
        red = 0.98
        blue = 0.09
        green = 0.56
        print(red,blue,green)
    }
    
    /// 灵活的命名
    func nameVariables() {
        let π = 3.1415926
        let 🐶 = "dog"
        print(π,🐶)
    }
    
    func varAndLet() {
        var welcome = "hello"
        welcome = "hello world"
        
        let languageName = "Swift"
//        languageName = "Swift++" ,编译报错，常来那个无法被修改
        print(welcome + languageName)
    }
    
    
    /// 整形边界
    func IntegerBounds() {
        let minValue = Int64.min
        let maxValue = Int64.max
        print(minValue,maxValue)
    }
    
    /// 类型推断
    func typeInference()  {
        let meanOfLife = 42//类型推断为Int
        
        let pi = 3 + 0.14159//类型推断为Double
        
        print(meanOfLife,pi)
    }
    
    /// 数字的前缀
    /*
     A decimal number, with no prefix
     A binary number, with a 0b prefix
     An octal number, with a 0o prefix
     A hexadecimal number, with a 0x prefix
     */
    func numericLiterals() {
        let decimalInteger = 17
        let binaryInteger = 0b10001       // 17 in binary notation
        let octalInteger = 0o21           // 17 in octal notation
        let hexadecimalInteger = 0x11     // 17 in hexadecimal notation
        print(decimalInteger,binaryInteger,octalInteger,hexadecimalInteger)
    }
    
}

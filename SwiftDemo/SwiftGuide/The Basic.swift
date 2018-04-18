//
//  The Basic.swift
//  SwiftDemo
//
//  Created by liyiping on 2018/4/11.
//  Copyright © 2018年 情风. All rights reserved.
//

import UIKit

typealias AudioSample = UInt16//类型别名

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
        integerConversion()
        integerAndFloatConversion()
        typeAliases()
        Boolean()
        tuples()
        optionals()
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
    
    
    /// 整数转换
    func integerConversion() {
//        let cannotBeNegative: UInt8 = -1 //无符号数不能表示负数
//        let tooBig: Int8 = Int8.max + 1  //Int8 cannot store a number larger than its maximum value,
        
        let twoThousand: UInt16 = 2_000
        let one: UInt8 = 1
        let twoThousandAndOne = twoThousand + UInt16(one) //类型不同 不能相加 需要转换
        print(twoThousandAndOne)
    }
    
    
    /// 整数和浮点型
    func integerAndFloatConversion()  {
        let three = 3
        let pointOneFourOneFiveNine = 0.14159
        
        let pi = Double(three) + pointOneFourOneFiveNine//类型推断为Double
        
        print(Double(three),pi)
    }
    
    /// 类型别名
    func typeAliases() {
        let maxAmplitudeFound = AudioSample.min//AudioSample是UInt16的别名
        print(maxAmplitudeFound)
    }
    
    
    /// 布尔类型
    func Boolean() {
        let turnipsAreDelicious = false
        if turnipsAreDelicious {
            print("Mmm, tasty turnips!")
        } else {
            print("Eww, turnips are horrible.")
        }
        
        //Swiftz阻止非Boolean值代表Boolean
        let i = 1
//        if i {// 'Int' is not convertible to 'Bool'
//            print("")
//        }
        if i == 1 {//这样才是可以的
            
        }
    }
    
    
    /// 元组
    func tuples() {
        let http404Error = (404, "NotFound")// http404Error is of type (Int, String), and equals (404, "Not Found")
        print(http404Error)
        
        let (statusCode, statusMessage) = (403, "Forbidion")
        print("the statusCode is \(statusCode)")
        print("the statusCode is \(statusMessage)")
        
        let (code, _) = (500, "Error")//如果只需要其中的某个值，其他值可以用_代替
        print("the statusCode is \(code)")
        
        //可以在定义的时候赋初值
        let http200Status = (statusCode: 200, description: "OK")
        print("The status code is \(http200Status.statusCode)")
        print("The status description is \(http200Status.description)")
        
    }
    
    
    /// 可选值
    func optionals() {
        let possibleNumber = "12"
        let conversionNumber = Int(possibleNumber)
        print(conversionNumber as Any)
        
        var serverResponseCode: Int? = 404
        serverResponseCode = nil
        
        let sureAnswer: String?//可选值自动初始化为nil
        
        if conversionNumber != nil {
            print("convertedNumber contains some integer value.")
        }
    }
    
    func ifStatementsForcedUnwrapping() {
       
    }
    
    
}

//
//  Extensions.swift
//  SwiftDemo
//
//  by qingfengiOS on 2018/5/25.
//  Copyright © 2018年 情风. All rights reserved.
//
/*
扩展 就是为一个已有的类、结构体、枚举类型或者协议类型添加新功能。这包括在没有权限获取原始源代码的情 况下扩展类型的能力(即 逆向建模 )。扩展和 Objective-C 中的分类类似。(与 Objective-C 不同的是，Swi ft 的扩展没有名字。)
 
 Swift中的扩展可以：
 1、添加计算型属性和计算型类型属性
 2、定义实例方法和类型方法
 3、提供新的构造器
 4、定义下标
 5、定义和使用新的嵌套类型
 6、定义和使用新的嵌套类型
 */

import UIKit

//MARK:-扩展语法
/*
 //使用关键字extension来定义扩展
 extension UIViewController {
 // 为 SomeType 添加的新功能写到这里
 }
 extension UIViewController: SomeProtocol, AnotherProctocol {
 // 协议实现写到这里
 }
 */

//MARK:-计算属性
extension Double {
    var km: Double {return self * 1_000}
    var m: Double {return self}
    var cm: Double {return self / 100.0}
    var mm: Double {return self / 1000.0}
    var ft: Double {return self / 3.28084}
}

//MARK:-构造器
struct ExtensionsSize {
    var width = 0.0, height = 0.0
}

struct ExtensionsPoint {
    var x = 0.0, y = 0.0
}

struct ExtensionsRect {
    var origin = ExtensionsPoint()
    var size = ExtensionsSize()
    //因为结构体 因为结构体 Rect 未提供定制的构造器，因此它会获得一个逐一成员构造器。又因为它为所有存储型属性提供了 默认值，它又会获得一个默认构造器。 未提供定制的构造器，因此它会获得一个逐一成员构造器。又因为它为所有存储型属性提供了 默认值，它又会获得一个默认构造器。
}

extension ExtensionsRect {//扩展ExtensionsRect
    init(center: ExtensionsPoint, size: ExtensionsSize) {
        let originX = center.x - (size.width / 2)
        let originY = center.y - (size.height / 2)
        self.init(origin: ExtensionsPoint(x: originX, y: originY), size: size)
    }
}

//MARK:-方法
extension Int {//为Int类型添加方法
    func repetitions(task: () -> Void)  {
        for _ in 0..<self {
            task()
        }
    }
}

//MARK:-可变实例方法
extension Int {
    mutating func square() {
        self = self * self
    }
}

//MARK:-下标
/*扩展可以为已有类型添加新下标。这个例子为 Swift 内建类型 Int 添加了一个整型下标。该下标 [n] 返回十进制数字从右向左数的第 n 个数字:
• 123456789[0] 返回 9
• 123456789[1] 返回 8
*/
extension Int {
    subscript(digitIndex: Int) -> Int {
        var decimalBase = 1
        for _ in 0..<digitIndex {
            decimalBase *= 10
        }
        return (self / decimalBase) % 10
    }
}

//MARK:-嵌套类型
/*
 该例子为 Int 添加了嵌套枚举。这个名为 Kind 的枚举表示特定整数的类型。具体来说，就是表示整数是正 数、零或者负数。
 这个例子还为 Int 添加了一个计算型实例属性，即 kind ，用来根据整数返回适当的 Kind 枚举成员。
 现在，这个嵌套枚举可以和任意 Int 值一起使用了:
 */
extension Int {
    
    enum Kind {
        case Negative, Zero, Positive
    }
    
    var kind: Kind {
        switch self {
        case 0:
            return .Zero
        case let x where x > 0:
            return .Positive
        default:
            return .Negative
        }
    }
    
    
}

class Extensions: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        let oneInch = 25.4.mm
        print("One inch is \(oneInch) meters")
        let threeFeet = 3.ft
        print("three feet is \(threeFeet) meters")
        let aMarathon = 42.km + 195.m
        print("a marathon is \(aMarathon) meters long")
        
        let defaultRect = ExtensionsRect()
        let memberwiseRect = ExtensionsRect(origin: ExtensionsPoint(x: 2.0, y: 2.0), size: ExtensionsSize(width: 20.0, height: 20.0))
        let centerRect = ExtensionsRect(center:  ExtensionsPoint(x: 4.0, y: 4.0), size: ExtensionsSize(width: 3.0, height: 3.0))
        print(defaultRect,memberwiseRect,centerRect)

        3.repetitions {
            print("the extension for Int!")
        }
        
        var someInt = 3
        someInt.square()
        print("the square of 3 is \(someInt.square())")
        
        print(123456789[0],1234567[2],34567[4])
        
        printIntegerKinds([3, 19, -27, 0, -6, 0, 7])
    }
    
    
    /// 遍历判断数组元素是否大于0
    ///
    /// - Parameter numbers: 目标数组
    func printIntegerKinds(_ numbers: [Int]) {
        for number in numbers {
            switch number.kind {
            case .Negative:
                print("- ", terminator: "")
            case .Zero:
                print("0 ", terminator: "")
            case .Positive:
                print("+ ", terminator: "")
            }
        }
        print("")
    }
    
    
}


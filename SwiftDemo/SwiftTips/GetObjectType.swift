//
//  GetObjectType.swift
//  SwiftDemo
//
//  Created by ios on 2019/3/13.
//  Copyright © 2019年 情风. All rights reserved.
//

import UIKit

class GetObjectType: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.white
        getObjectType()
        selfCheck()
    }
    
    
    /// 获取对象类型
    func getObjectType() {
        let date = NSDate()
        let name: Any! = object_getClass(date)
        print(name)
        
        let name2 = type(of: date)
        print(name2)
    }
    
    //为了快速确定类型，Swift 提供了一个简洁的写法：对于一个不确定的类型，我们现在可以使用 is 来进行判断。is 在功能上相当于原来的 isKindOfClass，可以检查一个对象是否属于某类型或其子类型。is 和原来的区别主要在于亮点，首先它不仅可以用于 class 类型上，也可以对 Swift 的其他像是 struct 或 enum 类型进行判断。
    func selfCheck() {//自省
        let obj: AnyObject = Class1()
        
        if obj .isKind(of: Class1.self) {
            print("属于Class1")
        }
        if obj is Class1 {
            print("属于Class1")
        }
        
        if obj .isKind(of: Class2.self) {
            print("属于Class2")
        }
        if obj is Class2 {
            print("属于Class2")
        }
    }
}

class Class1 {
    
}
class Class2: Class1 {
    
}

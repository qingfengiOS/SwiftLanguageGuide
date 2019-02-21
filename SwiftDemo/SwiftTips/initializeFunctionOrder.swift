//
//  initializeFunctionOrder.swift
//  SwiftDemo
//
//  Created by ios on 2019/2/19.
//  Copyright © 2019年 情风. All rights reserved.
//

import UIKit

class initializeFunctionOrder: UIViewController {

    
    /**
     与OC不同，Swift的初始化方法需要保证类型的所有属性被初始化。所以初始化方法的调用顺序就很有讲究。
     
     在某个类的子类中，初始化方法里语句的顺序并不是随意的，我们需要保证在当前子类实例的成员初始化完成后才能调用父类的初始化方法：
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        let tiger = Tiger()
        print(tiger.power, tiger.name)
        
        let mixed: [CustomStringConvertible] = [1, "two", 3]
        for obj in mixed {
            print(obj.description)
        }
        
    }
}

extension initializeFunctionOrder {
    class Cat {
        var name: String
        init() {
            name = "cat"
        }
    }
    
    class Tiger: Cat {
        let power: Int
        
        override init() {
            power = 10
//            super.init()
//            name = "tiger"
            
            // 如果我们不需要打改变 name 的话，
            // 虽然我们没有显式地对 super.init() 进行调用
            // 不过由于这是初始化的最后了，Swift 替我们自动完成了
            

        }
    }
    /*
     一般来说，子类的初始化顺序是：
     
     设置子类自己需要初始化的参数，power = 10
     调用父类的相应的初始化方法，super.init()
     对父类中的需要改变的成员进行设定，name = "tiger"
     */
    
    /*
     其中第三步是根据具体情况决定的，如果我们在子类中不需要对父类的成员做出改变的话，就不存在第 3 步。而在这种情况下，Swift 会自动地对父类的对应 init 方法进行调用，也就是说，第 2 步的 super.init() 也是可以不用写的 (但是实际上还是调用的，只不过是为了简便 Swift 帮我们完成了)。
     */
    
    
}


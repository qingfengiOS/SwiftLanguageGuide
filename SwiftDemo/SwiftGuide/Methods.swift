//
//  Methods.swift
//  SwiftDemo
//
//  Created by liyiping on 2018/5/7.
//  Copyright © 2018年 情风. All rights reserved.
//

import UIKit
/*
 结构体和枚举能够定义方法是 Swift 与 C/Objective-C 的主要区别之一。在 Objective-C 中，类是唯一能定义 方法的类型。但在 Swift 中，你不仅能选择是否要定义一个类/结构体/枚举，还能灵活地在你创建的类型(类/ 结构体/枚举)上定义方法。
 */
class Methods: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white

        instanceMethod()
        theSelfProperty()
        modifyingValueTypesFromWithinInstanceMethods()
        assigningToSelfWithinMutatingMethod()
    }
    
    //MARK:--实例方法
    func instanceMethod() {
        let counter = Counter()
        
        print(counter.increment())
        print(counter.increment(by: 5))
        print(counter.reset())
    }
    
    func theSelfProperty() {
        /*
         类型的每一个实例都有一个隐含属性叫做 self ， self 完全等同于该实例本身。你可以在一个实例的实例方法中 使用这个隐含的 self 属性来引用当前实例。
         */
        
        let counter = Counter()
        
        print(counter.increments())
        /*实际上，你不必在你的代码里面经常写 self 。不论何时，只要在一个方法中使用一个已知的属性或者方法名 称，如果你没有明确地写 self ，Swift 假定你是指当前实例的属性或者方法。这种假定在上面的 Counter 中已经 示范了: Counter 中的三个实例方法中都使用的是 count (而不是 self.count )。

         使用这条规则的主要场景是实例方法的某个参数名称与实例的某个属性名称相同的时候。在这种情况下，参数名 称享有优先权，并且在引用属性时必须使用一种更严格的方式。这时你可以使用 self 属性来区分参数名称和属性 名称。
        */
        
        let thePoint = ThePoint(x: 4.0, y: 5.0)
        if thePoint.isToTheRightOfX(x: 1.0) {
            print("This point is to the right of the line where x == 1.0")
        }
        
    }
    
    //在实例方法中修改值类型
    func modifyingValueTypesFromWithinInstanceMethods() {
        var somePoint = SecondPoint(x: 1.0, y: 1.0)
        somePoint.moveByX(deltaX: 2.0, y: 3.0)
        print("The point is now at (\(somePoint.x), \(somePoint.y))")
        
    }
    
    //在可变方法中给 self 赋值
    func assigningToSelfWithinMutatingMethod() {
        var somePoint = ThirdPoint(x: 1.0, y: 1.0)
        somePoint.moveBy(x: 2.0, y: 3.0)
        print("The point is now at (\(somePoint.x), \(somePoint.y))")
    }
    
}




class Counter {
    var count = 0
    
    func increment() {
        count += 1
    }
    
    func increment(by amount: Int) {
        count += amount
    }
    
    func reset() {
        count = 0
    }
    
    //MARK:--self 属性
    /// 使用self属性，此方法与increment等价
    func increments() {
        self.count += 1
    }
    
}

//MARK:-- self 消除方法参数 x 和实例属性 x 之间的歧义:
struct ThePoint {
    var x = 0.0, y = 0.0
    
    func isToTheRightOfX(x: Double) -> Bool {
        return self.x > x
    }
}

//MARK:--在实例方法中修改值类型
struct SecondPoint {
    /*
     结构体和枚举是值类型。默认情况下，值类型的属性不能在它的实例方法中被修改。
     但是，如果你确实需要在某个特定的方法中修改结构体或者枚举的属性，你可以为这个方法选择 可变(mutatin g) 行为，然后就可以从其方法内部改变它的属性;并且这个方法做的任何改变都会在方法执行结束时写回到原始 结构中。方法还可以给它隐含的 self 属性赋予一个全新的实例，这个新实例在方法结束时会替换现存实例。
     要使用可变方法，将关键字mutating 放到方法的func关键字之前就可以了:
     */
    var x = 0.0, y = 0.0
    mutating func moveByX(deltaX: Double, y deltaY: Double) {
        x += deltaX
        y += deltaY
    }
    
    /*
     上面的Point结构体定义了一个可变方法 moveByX(_:y:) 来移动Point实例到给定的位置。该方法被调用时修 改了这个点，而不是返回一个新的点。方法定义时加上了 mutating 关键字，从而允许修改属性。
     注意，不能在结构体类型的常量(a constant of structure type)上调用可变方法，因为其属性不能被改变，即使属性是变量属性。
     */
}

struct ThirdPoint {
    var x = 0.0, y = 0.0
    mutating func moveBy(x deltaX: Double, y deltaY: Double) {
        self = ThirdPoint(x: x + deltaX, y: y + deltaY)
    }
    /*
     新版的可变方法 moveBy(x:y:) 创建了一个新的结构体实例，它的 x 和 y 的值都被设定为目标值。调用这个版本 的方法和调用上个版本的最终结果是一样的。
     */
}



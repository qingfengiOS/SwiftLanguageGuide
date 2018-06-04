//
//  Inheritance.swift
//  SwiftDemo
//
//  Created by qingfengiOS on 2018/5/12.
//  Copyright © 2018年 情风. All rights reserved.
//

import UIKit

class Inheritance: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        let someVehicle = Vehicle()
        print("Vehicle:\(someVehicle.description)")
        
        
        let bicycle = Bicycle()
        bicycle.hasBasket = true
        bicycle.currentSpeed = 15.0
        print("Bicycle:\(bicycle.description)")
        
        
        let tandem = Tandem()
        tandem.hasBasket = true
        tandem.currentNumberOfPassengers = 2
        tandem.currentSpeed = 22.0
        print("Tandem:\(tandem.description)")
        
        
        let train = Train()
        train.makeNoise()
        
        
        let car = Car()
        car.currentSpeed = 40.0
        car.gear = 3
        print("Car:\(car.description)")
        
        
        let automaticCar = AutomaticCar()
        automaticCar.currentSpeed = 35.0
        print("AutomaticCar: \(automaticCar.description)")
        
    }
}

//MARK:--定义基类
/*
 不继承于其它类的类，称之为基类。

 Swift 中的类并不是从一个通用的基类继承而来。如果你不为你定义的类指定一个超类的话，这个类就自动成为 基类。
 */
class Vehicle {
    var currentSpeed = 0.0
    var description: String {
        return "traveling at \(currentSpeed) miles per hour"
    }
    
    func makeNoise() {
        
    }
}

//MARK:--子类
class Bicycle: Vehicle {
    var hasBasket = false
    
}

class Tandem: Bicycle {
    var currentNumberOfPassengers = 0
}

//MARK:--访问超类的方法，属性及下标
/*
 当你在子类中重写超类的方法，属性或下标时，有时在你的重写版本中使用已经存在的超类实现会大有裨益。比如，你可以完善已有实现的行为，或在一个继承来的变量中存储一个修改过的值。
 在合适的地方，你可以通过使用 super 前缀来访问超类版本的方法，属性或下标:
 • 在方法 someMethod() 的重写实现中，可以通过 super.someMethod() 来调用超类版本的 someMethod() 方法。
 • 在属性 someProperty 的 getter 或 setter 的重写实现中，可以通过 super.someProperty 来访问超类版本的 someProperty 属性。
 • 在下标的重写实现中，可以通过 super[someIndex] 来访问超类版本中的相同下标。
 */

//MARK:--重写方法
//在子类中，你可以重写继承来的实例方法或类方法，提供一个定制或替代的方法实现。
class Train: Vehicle {
    override func makeNoise() {
        print("Choo Choo")
    }
}

//MARK:--重写属性
//你可以重写继承来的实例属性或类型属性，提供自己定制的 getter 和 setter，或添加属性观察器使重写的属性 可以观察属性值什么时候发生改变。
class Car: Vehicle {
    var gear = 1
    override var description: String {
        return super.description + "in gear\(gear)"
    }
    //重写的 description 属性首先要调用 super.description 返回 Vehicle 类的 description 属性。之后， Car 类版 本的 description 在末尾增加了一些额外的文本来提供关于当前档位的信息。
}

//MARK:--重写属性观察器
//你可以通过重写属性为一个继承来的属性添加属性观察器。这样一来，当继承来的属性值发生改变时，你就会被 通知到，无论那个属性原本是如何实现的。
/*
 不可以为继承来的常量存储型属性或继承来的只读计算型属性添加属性观察器。这些属性的值是不可以被设置 的，所以，为它们提供 willSet 或 didSet 实现是不恰当。
 
 此外还要注意，你不可以同时提供重写的 setter 和重写的属性观察器。如果你想观察属性值的变化，并且你已 经为那个属性提供了定制的 setter，那么你在 setter 中就可以观察到任何值变化了。
 */
class AutomaticCar: Car {
    override var currentSpeed: Double {
        
        didSet {
            gear = Int(currentSpeed / 1.0) + 1
        }
        
    }
}

//MARK:--防止重写
/*
 你可以通过把方法，属性或下标标记为final来防止它们被重写，只需要在声明关键字前加上final修饰符即 可(例如:final var，final func，final class func ，以及final subscript)。
 如果你重写了带有final标记的方法，属性或下标，在编译时会报错。在类扩展中的方法，属性或下标也可以在 扩展的定义里标记为 final 的。
 你可以通过在关键字class前添加final修饰符(final class)来将整个类标记为 final 的。这样的类是不可被继承的，试图继承这样的类会导致编译报错。
 */



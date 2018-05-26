//
//  Protocols.swift
//  SwiftDemo
//
//  Created by liyiping on 2018/5/26.
//  Copyright © 2018年 情风. All rights reserved.
//
/*
 协议 定义了一个蓝图，规定了用来实现某一特定任务或者功能的方法、属性，以及其他需要的东西。类、结构体 或枚举都可以遵循协议，并为协议定义的这些要求提供具体实现。某个类型能够满足某个协议的要求，就可以说 该类型遵循这个协议。
 
 除了遵循协议的类型必须实现的要求外，还可以对协议进行扩展，通过扩展来实现一部分要求或者实现一些附加功能，这样遵循协议的类型就能够使用这些功能。
 */
import UIKit

//MARK:-协议语法
protocol SomeProtocol {//协议的定义方式与类、结构体和枚举的定义非常相似
    // 这里是协议的定义部分
}

protocol OtherProtocol {
    
}

//要让自定义类型遵循某个协议，在定义类型时，需要在类型名称后加上协议名称，中间以冒号( : )分隔。遵循 多个协议时，各协议之间用逗号( , )分隔:
struct SomeStruct2: SomeProtocol, OtherProtocol {
    
}

class SomeSuperClass {//父类
    
}

class SomeClass2: SomeSuperClass, SomeProtocol, OtherProtocol {
    // 这里是类的定义部分
}

//MARK:-属性要求
/*
 协议可以要求遵循协议的类型提供特定名称和类型的实例属性或类型属性。协议不指定属性是存储型属性还是计算型属性，它只指定属性的名称和类型。此外，协议还指定属性是可读的还是可读可写的。
 
 如果协议要求属性是可读可写的，那么该属性不能是常量属性或只读的计算型属性。如果协议只要求属性是可读的，那么该属性不仅可以是可读的，如果代码需要的话，还可以是可写的。
 
 协议总是用 var 关键字来声明变量属性，在类型声明后加上 { set get } 来表示属性是可读可写的，可读属性则用 { get 来表示:
 */
protocol ProtocolProperty {
    var mustBeSettable: Int { set get }
    var doesNotNeedToBesettable: Int {get}
}

/*
 协议中定义类型属性时，总是使用 static 关键字作为前缀。当类类型遵循协议时，除了 static 关键 字，还可以使用 class 关键字来声明类型属性:
 */
protocol AnotherProtocol {
    static var someTypeProperty: Int {set get}
    
}

//这是个只含有一个实例属性要求的协议:
protocol FullyNamed {
    var fullName: String { get }
    //FullyNamed 协议除了要求遵循协议的类型提供 fullName 属性外，并没有其他特别的要求。这个协议表示，任 何遵循 FullyNamed 的类型，都必须有一个可读的 String 类型的实例属性 fullName 。
}


//下面是一个遵循 FullyNamed 协议的简单结构体:
struct Person: FullyNamed {
    var fullName: String
    //Person 结构体的每一个实例都有一个 String 类型的存储型属性 fullName 。这正好满足了 FullyNamed 协 议的要求，也就意味着 Person 结构体正确地符合了协议。(如果协议要求未被完全满足，在编译时会报错。
}

class Starship: FullyNamed {
    var prefix: String?
    var name: String
    init(name: String, prefix: String? = nil) {
        self.name = name
        self.prefix = prefix
    }
    
    var fullName: String {
        return (prefix != nil ? prefix! + " " : " ") + name
    }
}

//MARK:-方法要求
/*
 协议可以要求遵循协议的类型实现某些指定的实例方法或类方法。这些方法作为协议的一部分，像普通方法一样放在协议的定义中，但是不需要大括号和方法体。可以在协议中定义具有可变参数的方法，和普通方法的定义方式相同。但是，不支持为协议中的方法的参数提供默认值。
 
 正如属性要求中所述，在协议中定义类方法的时候，总是使用 static 关键字作为前缀。当类类型遵循协议 时，除了 static 关键字，还可以使用 class 关键字作为前缀:
 */
protocol MethodProtocol {
    static func someTypeMethod()
}

protocol RandomNumberGenerator {
    func random() -> Double
}

class LinearCongruentialGenerator: RandomNumberGenerator {
    var lastRandom = 42.0
    let m = 139968.0
    let a = 3887.0
    let c = 2973.0
    func random() -> Double {
        lastRandom = ((lastRandom * a + c).truncatingRemainder(dividingBy: m))
        return lastRandom / m
    }
}

//MARK:-Mutating 方法要求
/*
 有时需要在方法中改变方法所属的实例。例如，在值类型(即结构体和枚举)的实例方法中，将 mutating 关键 字作为方法的前缀，写在 func 关键字之前，表示可以在该方法中修改它所属的实例以及实例的任意属性的 值。
 
 如果你在协议中定义了一个实例方法，该方法会改变遵循该协议的类型的实例，那么在定义协议时需要在方法前 加 mutating 关键字。这使得结构体和枚举能够遵循此协议并满足此方法要求。
 */
protocol Togglable {
    mutating func toggle()
}
enum OnOffSwitch: Togglable {
    case Off, On
    mutating func toggle() {
        switch self {
        case .Off:
            self = .On
        case .On:
            self = .Off
        }
    }
}

class Protocols: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        let john = Person(fullName: "John Applessed")
        print(john.fullName)
        
        let ncc1701 = Starship(name: "Enterprise", prefix: "USS")
        print(ncc1701.fullName)
        
        let generator = LinearCongruentialGenerator()
        for i in 0...10 {
            print("the \(i) random number is:\(generator.random()) ")
        }
        
        var lightSwitch = OnOffSwitch.Off
        lightSwitch.toggle()
        if lightSwitch == .On {
            print("On")
        } else {
            print("Off")
        }
    
        lightSwitch.toggle()
        if lightSwitch == .On {
            print("On")
        } else {
            print("Off")
        }
    }
    
}











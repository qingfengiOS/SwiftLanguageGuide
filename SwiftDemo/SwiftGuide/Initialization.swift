//
//  Initialization.swift
//  SwiftDemo
//
//  Created by liyiping on 2018/5/13.
//  Copyright © 2018年 情风. All rights reserved.
//

import UIKit
/*
 定义构造器来实现构造过程，这些构造器可以看做是用来创建特定类型新实例的特殊方法。
 与 Objective-C 中的构造器不同，Swift 的构造器无需返回值，它们的主要任务是保证新实例在第一次使用前完成正确的初始 化。
 */
class Initialization: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        
        let f = Fahrenheit()
        print("The default temperature is \(f.temperature)° Fahrenheit")
        
        let boilingPointOfWater = Celsius(formFahrenheit: 212.0)
        let freezingPointOfWater = Celsius(formKelvin: 273.15)
        print(boilingPointOfWater)
        print(freezingPointOfWater)
        
        let magenta = Color(red: 1.0, green: 0.0, blue: 1.0)
        let halfGray = Color(white: 0.5)
        print(magenta)
        print(halfGray)
        /*
         如果不通过外部参数名字传值，你是没法调用这个构造器的。只要构造器定义了某个外部参数名，你就必
         须使用它，忽略它将导致编译错误
         let veryGreen = Color(0.0, 1.0, 0.0) // 报编译时错误，需要外部名称
         */
        
        let bodyTemperature = Celsius2(37.0)
        print("bodyTemperature = \(bodyTemperature)")
        
        
        let cheeseQuestion = SurveyQuestion(text: "Do you like cheese?")
        cheeseQuestion.ask()
        cheeseQuestion.response = "Yes, I do like cheese."
        //调查问题的答案在回答前是无法确定的，因此我们将属性 response 声明为 String? 类型，或者说是 可选字符串类 型 。当 SurveyQuestion 实例化时，它将自动赋值为 nil ，表明此字符串暂时还没有值。
        
        let beetsQuestion = SurveyQuestion2(text: "How about beets?")
        beetsQuestion.ask()// 打印 "How about beets?"
        beetsQuestion.response = "I also like beets. (But not with cheese.)"
        
        
        let item = ShoppingListItem()
        print(item)
        
        
        let twoByTwo = Size2(width: 2.0, height: 2.0)
        print(twoByTwo)
        
        /*
         第一个 Rect 构造器 init() ，在功能上跟没有自定义构造器时自动获得的默认构造器是一样的。这个构造器是一 个空函数，使用一对大括号 {} 来表示，它没有执行任何构造过程。调用这个构造器将返回一个 Rect 实例，它的
         origin 和 size 属性都使用定义时的默认值 Point(x: 0.0, y: 0.0) 和 Size(width: 0.0, height: 0.0)
         */
        let basicRect = Rect3()// basicRect 的 origin 是 (0.0, 0.0)，size 是 (0.0, 0.0)
        print(basicRect)
        
        /*
         第二个 Rect 构造器 init(origin:size:) ，在功能上跟结构体在没有自定义构造器时获得的逐一成员构造器是一 样的。这个构造器只是简单地将 origin 和 size 的参数值赋给对应的存储型属性:
         */
        let originRect = Rect3(origin: Point3(x: 2.0, y: 2.0),size: Size3(width: 5.0, height: 5.0))
        print(originRect)
        
        /*
         第三个 Rect 构造器 init(center:size:) 稍微复杂一点。它先通过 center 和 size 的值计算出 origin 的坐标，然 后再调用(或者说代理给) init(origin:size:) 构造器来将新的 origin 和 size 值赋值到对应的属性中:
         */
        let centerRect = Rect3(center: Point3(x: 4.0, y: 4.0), size: Size3(width: 3.0, height: 3.0))// centerRect 的 origin 是 (2.5, 2.5)，size 是 (3.0, 3.0)
        print(centerRect)
        
    }


}

//MARK:--存储属性的初始赋值
/*
 类和结构体在创建实例时，必须为所有存储型属性设置合适的初始值。存储型属性的值不能处于一个未知的状
 态。
 你可以在构造器中为存储型属性赋初值，也可以在定义属性时为其设置默认值。以下小节将详细介绍这两种方
 法。
 */

//构造器
//构造器在创建某个特定类型的新实例时被调用。它的最简形式类似于一个不带任何参数的实例方法，以关键字 init 命名
struct Fahrenheit {
    var temperature: Double
    init() {
        temperature = 32.0
    }
    //这个结构体定义了一个不带参数的构造器 init ，并在里面将存储型属性 temperature 的值初始化为 32.0 (华氏 温度下水的冰点)。
}

//默认属性值
struct Fahrenheit2 {
    var temperature = 32.0
}

//MARK:--自定义构造过程
//自定义 构造过程 时，可以在定义中提供构造参数，指定所需值的类型和名字。构造参数的功能和语法跟函数和方 法的参数相同。
struct Celsius {
    var temperatureInCelsius: Double
    init(formFahrenheit fahrenheut: Double) {
        temperatureInCelsius = (fahrenheut - 32.0) / 1.8
    }
    
    init(formKelvin kevin: Double) {
        temperatureInCelsius = kevin - 273.15
    }
    /*
     第一个构造器拥有一个构造参数，其外部名字为 fromFahrenheit ，内部名字为 fahrenheit ;第二个构造器也拥 有一个构造参数，其外部名字为 fromKelvin ，内部名字为 kelvin 。这两个构造器都将唯一的参数值转换成摄氏 温度值，并保存在属性 temperatureInCelsius 中。
     */
}

//MARK:--参数的内部名称和外部名称
struct Color {
    let red, green, blue: Double
    init(red: Double, green: Double, blue: Double) {
        self.red = red
        self.blue = blue
        self.green = green
    }
    
    init(white: Double) {
        red = white
        green = white
        blue = white
    }
}

//MARK:--不带外部名的构造器参数
struct Celsius2 {
    var temperatureInCelsius: Double
    init(formFahrenheit fahrenheit: Double) {
        temperatureInCelsius = (fahrenheit - 32.0) / 1.8
    }
    
    init(formKelvin kelvin: Double) {
        temperatureInCelsius = kelvin - 273.15
    }
    
    init(_ celsius: Double) {
        temperatureInCelsius = celsius
    }
    
}

//MARK:--可选属性类型
/*
 
 如果你定制的类型包含一个逻辑上允许取值为空的存储型属性——无论是因为它无法在初始化时赋值，还是因为 它在之后某个时间点可以赋值为空——你都需要将它定义为 可选类型 。可选类型的属性将自动初始化为 nil ，表 示这个属性是有意在初始化时设置为空的。
 */
class SurveyQuestion {
    var text: String
    var response: String?
    
    init(text: String) {
        self.text = text
    }
    
    func ask() {
        print(text)
    }
    
}

//MARK:--构造过程中常量属性的修改
//你可以在构造过程中的任意时间点给常量属性指定一个值，只要在构造过程结束时是一个确定的值。一旦常量属性被赋值，它将永远不可更改。
class SurveyQuestion2 {
    let text: String
    var response: String?
    init(text: String) {
        self.text = text
    }
    func ask() {
        print(text)
    }
}

//MARK:--默认构造器
//如果结构体或类的所有属性都有默认值，同时没有自定义的构造器，那么 Swift 会给这些结构体或类提供一个默 认构造器(default initializers)。这个默认构造器将简单地创建一个所有属性值都设置为默认值的实例。
class ShoppingListItem {
    var name: String?
    var quantity = 1
    var purchase = false
    
    /*
     由于ShoppingListItem类中的所有属性都有默认值，且它是没有父类的基类，它将自动获得一个可以为所有属性 设置默认值的默认构造器(尽管代码中没有显式为name属性设置默认值，但由于name是可选字符串类型，它将默认设置为nil)。上面例子中使用默认构造器创造了一个ShoppingListItem类的实例(使用ShoppingListItem()形式的构造器语法)，并将其赋值给变量item。

     */
}

//MARK:--结构体的逐一成员构造器
/*
 除了上面提到的默认构造器，如果结构体没有提供自定义的构造器，它们将自动获得一个逐一成员构造器，即使
 结构体的存储型属性没有默认值。
 
 逐一成员构造器是用来初始化结构体新实例里成员属性的快捷方法。我们在调用逐一成员构造器时，通过与成员
 属性名相同的参数名进行传值来完成对成员属性的初始赋值。
 */
struct Size2 {
    var width = 0.0, height = 0.0
}

//MARK:--值类型的构造器代理
/*
 构造器可以通过调用其它构造器来完成实例的部分构造过程。这一过程称为构造器代理，它能减少多个构造器间
 的代码重复。
 
 构造器代理的实现规则和形式在值类型和类类型中有所不同。值类型(结构体和枚举类型)不支持继承，所以构 造器代理的过程相对简单，因为它们只能代理给自己的其它构造器。类则不同，它可以继承自其它类(请参考继 承)，这意味着类有责任保证其所有继承的存储型属性在构造时也能正确的初始化。
 
 对于值类型，你可以使用 self.init 在自定义的构造器中引用相同类型中的其它构造器。并且你只能在构造器内 部调用 self.init 。

 如果你为某个值类型定义了一个自定义的构造器，你将无法访问到默认构造器(如果是结构体，还将无法访问逐 一成员构造器)。这种限制可以防止你为值类型增加了一个额外的且十分复杂的构造器之后,仍然有人错误的使用 自动生成的构造器
 */
struct Size3 {
    var width = 0.0, height = 0.0
}

struct Point3 {
    var x = 0.0, y = 0.0
}

struct Rect3 {
    var origin = Point3()
    var size = Size3()
    init() {
        
    }
    
    init(origin: Point3, size: Size3) {
        self.origin = origin
        self.size = size
    }
    
    init(center: Point3, size: Size3) {
        let originX = center.x - (size.width / 2)
        let originY = center.y - (size.height / 2)
        self.init(origin: Point3(x: originX, y: originY), size: size)
    }
    /*
     构造器 init(center:size:) 可以直接将 origin 和 size 的新值赋值到对应的属性中。然而，利用恰好提供了相关 功能的现有构造器会更为方便，构造器 init(center:size:) 的意图也会更加清晰。
     */
}


//MARK:--类的继承和构造过程
/*
 类里面的所有存储型属性——包括所有继承自父类的属性——都必须在构造过程中设置初始值。
 Swift 为类类型提供了两种构造器来确保实例中所有存储型属性都能获得初始值，它们分别是指定构造器和便利构造器。
 */










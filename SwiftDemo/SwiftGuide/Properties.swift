//
//  Properties.swift
//  SwiftDemo
//
//  Created by liyiping on 2018/5/6.
//  Copyright © 2018年 情风. All rights reserved.
//

import UIKit
/*
 属性将值跟特定的类、结构或枚举关联。存储属性存储常量或变量作为实例的一部分，而计算属性计算(不是存
 储)一个值。计算属性可以用于类、结构体和枚举，存储属性只能用于类和结构体。
 */
class Properties: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.white
        
        storedProperties()
        storedPropertiesOfConstantStructureInstances()
        lazyStoredProperties()
        storedPropertiesAndInstanceVariables()
        
        computedProperties()
    }

    //MARK:--存储属性
    /*
     简单来说，一个存储属性就是存储在特定类或结构体实例里的一个常量或变量。存储属性可以是变量存储属
     性(用关键字 var 定义)，也可以是常量存储属性(用关键字 let 定义)。
     */
    func storedProperties() {
        var rangeOfThreeItems = FixedLengthRange(firstValue: 0, length: 3)
        print(rangeOfThreeItems)
        rangeOfThreeItems.firstValue = 6
        print(rangeOfThreeItems)
        /*
         FixedLengthRange 的实例包含一个名为 firstValue 的变量存储属性和一个名为 length 的常量存储属 性。在上面的例子中，length 在创建实例的时候被初始化，因为它是一个常量存储属性，所以之后无法修改它 的值。
         */
    }
   
    //MARK:--常量结构体的存储属性
    func storedPropertiesOfConstantStructureInstances() {
        //如果创建了一个结构体的实例并将其赋值给一个常量，则无法修改该实例的任何属性，即使有属性被声明为变量也不行
 
        let rangeOfFourItems = FixedLengthRange(firstValue: 0, length: 4)
//        rangeOfFourItems.firstValue = 6// 尽管 firstValue 是个变量属性，这里还是会报错
        
        /*
         因为 rangeOfFourItems 被声明成了常量(用 let 关键字)，即使 firstValue 是一个变量属性，也无法再 修改它了。
         这种行为是由于结构体(struct)属于值类型。当值类型的实例被声明为常量的时候，它的所有属性也就成了常量。
         属于引用类型的类(class)则不一样。把一个引用类型的实例赋给一个常量后，仍然可以修改该实例的变量属性。
         */
    }

    //MARK:--延迟存储属性
    func lazyStoredProperties() {
        //延迟存储属性是指当第一次被调用的时候才会计算其初始值的属性。在属性声明前使用 lazy 来标示一个延迟存储属性。
        let manager = DataManager()
        manager.data.append("Some data")
        manager.data.append("Some more data")
        // DataImporter 实例的 importer 属性还没有被创建
        
        //DataManager 管理数据时也可能不从文件中导入数据。所以当 DataManager 的实例被创建时，没必要创建一个 DataImporter 的实例，更明智的做法是第一次用到 DataImporter 的时候才去创建它。
        //由于使用了 lazy ，importer 属性只有在第一次被访问的时候才被创建。比如访问它的属性 fileName 时:
        print(manager.importer.fileName)//DataImporter 实例的 importer 属性现在被创建了(输出 "data.txt”)
        
        /*
         如果一个被标记为 lazy 的属性在没有初始化时就同时被多个线程访问，则无法保证该属性只会被初始化一 次。
         */
        
    }
    
    //MARK:--存储属性和实例变量
    func storedPropertiesAndInstanceVariables() {
        /*
         如果您有过 Objective-C 经验，应该知道 Objective-C 为类实例存储值和引用提供两种方法。除了属性之 外，还可以使用实例变量作为属性值的后端存储。
         Swift 编程语言中把这些理论统一用属性来实现。Swift 中的属性没有对应的实例变量，属性的后端存储也无法 直接访问。这就避免了不同场景下访问方式的困扰，同时也将属性的定义简化成一个语句。属性的全部信 息——包括命名、类型和内存管理特征——都在唯一一个地方(类型定义中)定义。
         */
    }
    
    
    //MARK:--计算属性
    func computedProperties() {
        //除存储属性外，类、结构体和枚举可以定义计算属性。计算属性不直接存储值，而是提供一个 getter 和一个可 选的 setter，来间接获取和设置其他属性或变量的值。
        var square = Rect(origin:Point(x: 0, y: 0),size: Size(width: 10.0, height: 10.0))
        let initialSquareCenter = square.center
        print("square.origin at (\(initialSquareCenter.x), \(initialSquareCenter.y))")
        
        square.center = Point(x: 15.0, y: 15.0)
        print("square.origin is now at (\(square.origin.x), \(square.origin.y))")
    }
    
}


//MARK:--------------------------------------------------------------------
struct FixedLengthRange {
    var firstValue: Int
    let length: Int
}


class DataImporter {
    /*
     DataImporter 是一个负责将外部文件中的数据导入的类。 这个类的初始化会消耗不少时间。
     */
    var fileName = "data.txt"//// 这里会提供数据导入功能
    
}

class DataManager {
    lazy var importer = DataImporter()
    var data = [String]()//这里会提供数据管理功能
}

struct Point {
    var x = 0.0, y = 0.0
}

struct Size {
    var width = 0.0, height = 0.0
}

struct Rect {
    var origin = Point()
    var size = Size()
    var center: Point {
        
        get {
            let centerX = origin.x + (size.width / 2)
            let centerY = origin.y + (size.height / 2)
            return Point(x: centerX, y: centerY)
        }
        
        set(newCenter) {
            origin.x = newCenter.x - (size.width / 2)
            origin.y = newCenter.y - (size.height / 2)
        }
    }
    
    
    
}





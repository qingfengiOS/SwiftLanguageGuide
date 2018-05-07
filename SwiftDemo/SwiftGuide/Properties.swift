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
        readOnlyComputedProperties()
        propertyObservers()
        
        globalAndLocalVariables()
        typeProperties()
        
        queryingAndSettingTypeProperties()
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
        print(rangeOfFourItems)
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
        /*
         Rect也提供了一个名为center 的计算属性。一个矩形的中心点可以从原点(origin)和大小(size)算 出，所以不需要将它以显式声明的 Point 来保存。 Rect 的计算属性 center 提供了自定义的 getter 和 se tter 来获取和设置矩形的中心点，就像它有一个存储属性一样。
         */
    }
    
    //MARK:--只读计算属性
    func readOnlyComputedProperties() {
        //A computed property with a getter but no setter is known as a read-only computed property. A read-only computed property always returns a value, and can be accessed through dot syntax, but cannot be set to a different value.
        let fourByFiveByTwo = Cuboid(width: 4, height: 5, depth: 2)
        print("the volume of fourByFiveByTwo is \(fourByFiveByTwo.volume)")
        
    }
    
    //MARK:--属性观察器
    func propertyObservers() {
        /*
         属性观察器监控和响应属性值的变化，每次属性被设置值的时候都会调用属性观察器，即使新值和当前值相同的
         时候也不例外。
         
         可以为除了延迟存储属性之外的其他存储属性添加属性观察器，也可以通过重写属性的方式为继承的属性(包括 存储属性和计算属性)添加属性观察器。你不必为非重写的计算属性添加属性观察器，因为可以通过它的 setter 直接监控和响应值的变化。
         
         可以为属性添加如下的一个或全部观察器:
         • 在新的值被设置之前调用
         • 在新的值被设置之后立即调用
         
         wilSet观察器会将新的属性值作为常量参数传入，在wilSet的实现代码中可以为这个参数指定一个名称，如果不指定则参数仍然可用，这时使用默认名newValue表示。
         同样，didSet观察器会将旧的属性值作为参数传入，可以为该参数命名或者使用默认参数名oldValue。如果在didSet方法中再次对该属性赋值，那么新值会覆盖旧的值。
         
         父类的属性在子类的构造器中被赋值时，它在父类中的wilSet和didSet观察器会被调用，随后才会调用子类的观察器。在父类初始化方法调用之前，子类给属性赋值时，观察器不会被调用。
         */
        
        let stepCounter = StepCounter()

        stepCounter.totalSteps = 200
        // About to set totalSteps to 200
        // Added 200 steps
        stepCounter.totalSteps = 360
        // About to set totalSteps to 360
        // Added 160 steps
        stepCounter.totalSteps = 896
        // About to set totalSteps to 896
        // Added 536 steps
        
    }
    
    //MARK:--全局变量和局部变量
    func globalAndLocalVariables() {
        /*
         计算属性和属性观察器所描述的功能也可以用于全局变量和局部变量。全局变量是在函数、方法、闭包或任何类型之外定义的变量。局部变量是在函数、方法或闭包内部定义的变量。
         
         前面章节提到的全局或局部变量都属于存储型变量，跟存储属性类似，它为特定类型的值提供存储空间，并允许读取和写入。
         
         另外，在全局或局部范围都可以定义计算型变量和为存储型变量定义观察器。计算型变量跟计算属性一样，返回一个计算结果而不是存储值，声明格式也完全一样。
         */
    }
    
    //MARK:--类型属性
    func typeProperties() {
        /*
         实例属性属于一个特定类型的实例，每创建一个实例，实例都拥有属于自己的一套属性值，实例之间的属性相互
         独立。
         
         也可以为类型本身定义属性，无论创建了多少个该类型的实例，这些属性都只有唯一一份。这种属性就是类型属
         性。
         
         类型属性用于定义某个类型所有实例共享的数据，比如所有实例都能用的一个常量(就像 C 语言中的静态常 量)，或者所有实例都能访问的一个变量(就像 C 语言中的静态变量)。
         
         存储型类型属性可以是变量或常量，计算型类型属性跟实例的计算型属性一样只能定义成变量属性。
         
         
         跟实例的存储型属性不同，必须给存储型类型属性指定默认值，因为类型本身没有构造器，也就无法在初始化过 程中使用构造器给类型属性赋值。
         存储型类型属性是延迟初始化的，它们只有在第一次被访问的时候才会被初始化。即使它们被多个线程同时访 问，系统也保证只会对其进行一次初始化，并且不需要对其使用 lazy 修饰符。
         */
    }
    
    //MARK:--获取和设置类型属性的值
    func queryingAndSettingTypeProperties() {
        print(SomeStructure.storedTypeProperty)
        // 打印 "Some value."
        SomeStructure.storedTypeProperty = "Another value."
        print(SomeStructure.storedTypeProperty)
        // 打印 "Another value.”
        print(SomeEnumeration.computedTypeProperty)
        // 打印 "6"
        print(OtherClass.computedTypeProperty)
        // 打印 "27"
        
        //可以使用结构体 AudioChannel 创建两个声道 leftChannel 和 rightChannel ，用以表示立体声系统的音量:
        var leftChannel = AudioChannel()
        var rightChannel = AudioChannel()
        
        leftChannel.currentLevel = 7
        print(leftChannel.currentLevel)
        print(AudioChannel.maxInputLevelForAllChannels)
        //如果将左声道的 currentLevel 设置成 7 ，类型属性 maxInputLevelForAllChannels 也会更新成 7
        
        rightChannel.currentLevel = 11
        print(rightChannel.currentLevel)// 输出 "10"
        print(AudioChannel.maxInputLevelForAllChannels) // 输出 "10"
        //如果试图将右声道的 currentLevel 设置成 11 ，它会被修正到最大值 10 ，同时 maxInputLevelForAllChanne ls 的值也会更新到 10 :

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

struct Cuboid {
    var width = 0.0, height = 0.0, depth = 0.0
    var volume: Double {
        return width * height * depth
    }
    //必须使用var关键字定义计算属性，包括只读计算属性，因为它们的值不是固定的。let关键字只用来声明常量属性，表示初始化后再也无法修改的值。
}

class StepCounter {
    var totalSteps: Int = 0 {
        willSet(newTotalSteps) {
            print("About to set totalSteps to \(newTotalSteps)")
        }
        
        didSet {
            if totalSteps > oldValue {
                print("Added \(totalSteps - oldValue) steps")
            }
        }
        
    }
}

//MARK:--类型属性语法
struct SomeStructure {
    static var storedTypeProperty = "Some value."
    static var computedTypeProperty: Int {
        return 1
    }
}
enum SomeEnumeration {
    static var storedTypeProperty = "Some value."
    static var computedTypeProperty: Int {
        return 6
    }
}
class OtherClass {
    static var storedTypeProperty = "Some value."
    static var computedTypeProperty: Int {
        return 27
    }
    class var overrideableComputedTypeProperty: Int {
        return 107
    }
}


struct AudioChannel {
    static let thresholdLevel = 10
    static var maxInputLevelForAllChannels = 0
    var currentLevel: Int = 0 {
        didSet {
            if currentLevel > AudioChannel.thresholdLevel {
                currentLevel = AudioChannel.thresholdLevel// 将当前音量限制在阀值之内
            }
            if currentLevel > AudioChannel.maxInputLevelForAllChannels { // 存储当前音量作为新的最大输入音量
                AudioChannel.maxInputLevelForAllChannels = currentLevel
            }
            
        }
    }
    
    /*
     
     结构 AudioChannel 定义了 2 个存储型类型属性来实现上述功能。第一个是 thresholdLevel ，表示音量的最大上限阈值，它是一个值为10的常量，对所有实例都可见，如果音量高于 10 ，则取最大上限值 10 (见后面 描述)。
     第二个类型属性是变量存储型属性 maxInputLevelForAllChannels ，它用来表示所有 AudioChannel 实例的最大音量，初始值是 0 。
     AudioChannel 也定义了一个名为 currentLevel 的存储型实例属性，表示当前声道现在的音量，取值为 0 到 10。
     属性 currentLevel 包含 didSet 属性观察器来检查每次设置后的属性值，它做如下两个检查:
     • 如果 currentLevel 的新值大于允许的阈值 thresholdLevel ，属性观察器将 currentLevel 的值限定为阈 值 thresholdLevel 。
     • 如果修正后的 currentLevel 值大于静态类型属性 maxInputLevelForAllChannels 的值，属性观察器就将 新值保存在 maxInputLevelForAllChannels 中。
     */
}



//
//  ClassesAndStructures.swift
//  SwiftDemo
//
//  Created by liyiping on 2018/5/5.
//  Copyright © 2018年 情风. All rights reserved.
//

import UIKit

/*
 类和结构体是人们构建代码所用的一种通用且灵活的构造体。我们可以使用完全相同的语法规则来为类和结构体
 定义属性(常量、变量)和添加方法，从而扩展类和结构体的功能。
 */

/*
 类和结构体对比:
 Swift 中类和结构体有很多共同点。共同处在于:
 • 定义属性用于存储值
 • 定义方法用于提供功能
 • 定义下标操作使得可以通过下标语法来访问实例所包含的值
 • 定义构造器用于生成初始化值
 • 通过扩展以增加默认实现的功能
 • 实现协议以提供某种标准功能
 
 与结构体相比，类还有如下的附加功能:
 • 继承允许一个类继承另一个类的特征
 • 类型转换允许在运行时检查和解释一个类实例的类型
 • 析构器允许一个类实例释放任何其所被分配的资源
 • 引用计数允许对一个类的多次引用
 */

class ClassesAndStructures: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        
        let 元组 = classAndStructureInstances()
        print(元组.a,元组.b)
        
        accessingProperties()
        memberwiseInitializersForStructureTypes()
        structuresAndEnumerationsAreValueTypes()
        identityOperators()
        
    }

    
    //MARK:--类和结构体实例
    func classAndStructureInstances() -> (a:Resolution,b:VideoMode) {
     
        let someResolution = Resolution()
        let someVideoModel = VideoMode()
        print(someResolution,someVideoModel)
        /*
         结构体和类都使用构造器语法来生成新的实例。构造器语法的最简单形式是在结构体或者类的类型名称后跟随一 对空括号，如 Resolution() 或 VideoMode() 。通过这种方式所创建的类或者结构体实例，其属性均会被初始化为 默认值。构造过程章节会对类和结构体的初始化进行更详细的讨论。
         */
        return (someResolution,someVideoModel)
    }
    
    //MARK:--属性访问
    func accessingProperties() {
        var someResolution = Resolution()
        let someVideoModel = VideoMode()
        
        print("The width of someResolution is \(someResolution.width)")
        print("The width of someVideoMode is \(someVideoModel.resolution.width)")
        
        someResolution.height = 10
        print("The width of someResolution is \(someResolution.height)")
        print("The width of someVideoMode is \(someVideoModel.resolution.height)")
    }
    
    //MARK:--结构体类型的成员逐一构造器
    func memberwiseInitializersForStructureTypes() {
        let vga = Resolution(width: 640, height: 480)
        print(vga.width,vga.height)
    }
    
    //MARK:--结构体和枚举是值类型
    func structuresAndEnumerationsAreValueTypes() {
        //值类型被赋予给一个变量、常量或者被传递给一个函数的时候，其值会被拷贝。
        /*
         在之前的章节中，我们已经大量使用了值类型。实际上，在 Swift 中，所有的基本类型:整数(Integer)、浮 点数(floating-point)、布尔值(Boolean)、字符串(string)、数组(array)和字典(dictionary)，都是 值类型，并且在底层都是以结构体的形式所实现。
         在 Swift 中，所有的结构体和枚举类型都是值类型。这意味着它们的实例，以及实例中所包含的任何值类型属 性，在代码中传递的时候都会被复制。
         */
        let hd = Resolution(width: 1920, height: 1080)
        var cinema = hd
        
        cinema.width = 2048
        
        
        print("cinema is now \(cinema.width) pixels wide")
        print("hd is still \(hd.width) pixels wide")
        /*
         在将 hd 赋予给 cinema 的时候，实际上是将 hd 中所存储的值进行拷贝，然后将拷贝的数据存储到新的 cinema 实 例中。结果就是两个完全独立的实例碰巧包含有相同的数值。由于两者相互独立，因此将 cinema 的 width 修改为
         2048 并不会影响 hd 中的 width 的值。
         */
        
        enum CompassPoint {
            case North, South, East, West
        }
        var currentDirection = CompassPoint.West
        let rememberedDirection = currentDirection
        currentDirection = .East
        if rememberedDirection == .West {
            print("The remembered direction is still .West")
        }
    }
    
    //MARK:--类是引用类型
    func classesAreReferenceTypes() {
        //与值类型不同，引用类型在被赋予到一个变量、常量或者被传递到一个函数时，其值不会被拷贝。因此，引用的是已存在的实例本身而不是其拷贝。
        let hd = Resolution(width: 1920, height: 1080)
        
        let tenEighty = VideoMode()
        tenEighty.resolution = hd
        tenEighty.interlaced = true
        tenEighty.name = "1080i"
        tenEighty.frameRate = 25.0
        
        
        let alsoTenEighty = tenEighty
        alsoTenEighty.frameRate = 30.0
        print("The frameRate property of tenEighty is now \(tenEighty.frameRate)")
        /*
         因为类是引用类型，所以 tenEight 和 alsoTenEight 实际上引用的是相同的 VideoMode 实例。换句话说，它们是 同一个实例的两种叫法。
         
         需要注意的是 tenEighty 和 alsoTenEighty 被声明为常量而不是变量。然而你依然可以改变 tenEighty.frameRate 和 alsoTenEighty.frameRate ，因为 tenEighty 和 alsoTenEighty 这两个常量的值并未改变。它们并不“存储”这 个 VideoMode 实例，而仅仅是对 VideoMode 实例的引用。所以，改变的是被引用的 VideoMode 的 frameRate 属 性，而不是引用 VideoMode 的常量的值。
         */
        
    }
    
    //MARK:--恒等运算符
    func identityOperators() {
        /*
         因为类是引用类型，有可能有多个常量和变量在幕后同时引用同一个类实例。(对于结构体和枚举来说，这并不
         成立。因为它们作为值类型，在被赋予到常量、变量或者传递到函数时，其值总是会被拷贝。)
         如果能够判定两个常量或者变量是否引用同一个类实例将会很有帮助。为了达到这个目的，Swift 内建了两个恒 等运算符:
         • 等价于(===)
         • 不等价于( !== )
         */
        
        let hd = Resolution(width: 1920, height: 1080)
        
        let tenEighty = VideoMode()
        tenEighty.resolution = hd
        tenEighty.interlaced = true
        tenEighty.name = "1080i"
        tenEighty.frameRate = 25.0
        
        let alsoTenEighty = tenEighty
        
        if tenEighty === alsoTenEighty {//他们是否引用的同一个实例（同一份内存空间）
            print("tenEighty and alsoTenEighty refer to the same Resolution instance.")
        } else {
           print("tenEighty and alsoTenEighty refer to the difference Resolution instance.")
        }
        
    }
    
    //MARK:--指针
    /*
    如果你有 C，C++ 或者 Objective-C 语言的经验，那么你也许会知道这些语言使用指针来引用内存中的地址。一 个引用某个引用类型实例的 Swift 常量或者变量，与 C 语言中的指针类似，但是并不直接指向某个内存地 址，也不要求你使用星号( * )来表明你在创建一个引用。Swift 中的这些引用与其它的常量或变量的定义方式 相同。
    */
    
    //MARK:--类和结构体的选择
    /*
     按照通用的准则，当符合一条或多条以下条件时，请考虑构建结构体:
     • 该数据结构的主要目的是用来封装少量相关简单数据值。
     • 有理由预计该数据结构的实例在被赋值或传递时，封装的数据将会被拷贝而不是被引用。
     • 该数据结构中储存的值类型属性，也应该被拷贝，而不是被引用。
     • 该数据结构不需要去继承另一个既有类型的属性或者行为。
     
     举例来说，以下情境中适合使用结构体:
     • 几何形状的大小，封装一个 width 属性和 height 属性，两者均为 Double 类型。
     • 一定范围内的路径，封装一个 start 属性和 length 属性，两者均为 Int 类型。
     • 三维坐标系内一点，封装 x ， y 和 z 属性，三者均为 Double 类型。
     在所有其它案例中，定义一个类，生成一个它的实例，并通过引用来管理和传递。实际中，这意味着绝大部分的
     自定义数据构造都应该是类，而非结构体。
     */
    
    //MARK:--字符串、数组、和字典类型的赋值与复制行为
    /*
     Swift 中，许多基本类型，诸如 String ， Array 和 Dictionary 类型均以结构体的形式实现。这意味着被赋值给 新的常量或变量，或者被传入函数或方法中时，它们的值会被拷贝。
     
     Objective-C 中 NSString ， NSArray 和 NSDictionary 类型均以类的形式实现，而并非结构体。它们在被赋值或 者被传入函数或方法时，不会发生值拷贝，而是传递现有实例的引用。
     
     注意:
     以上是对字符串、数组、字典的“拷贝”行为的描述。在你的代码中，拷贝行为看起来似乎总会发生。然而，Sw ift 在幕后只在绝对必要时才执行实际的拷贝。Swift 管理所有的值拷贝以确保性能最优化，所以你没必要去回 避赋值来保证性能最优化。
     */
}

//MARK:-------------------------------------------------------------------------
//MARK:--Definition Syntax(定义语法)
class SomeClass {
    // 在这里定义类
}

struct someStruct {
    // 在这里定义结构体
}
/*
 在你每次定义一个新类或者结构体的时候，实际上你是定义了一个新的 Swift 类型。因此请使用UperCameCase 这种方式来命名(如 SomeClass 和 SomeStructure 等)，以便符合标准 Swift 类型的大写命名风格(如 String ， Int 和 Bool )。相反的，请使用 lowerCamelCase 这种方式为属性和方法命名(如framerate 和 incrementCount )，以便和类型名区分。
*/

struct Resolution {
    var width = 0
    var height = 0
    /*
      在上面的示例中我们定义了一个名为 Resolution 的结构体，用来描述一个显示器的像素分辨率。这个结构体包含 了两个名为 width 和 height 的存储属性。存储属性是被捆绑和存储在类或结构体中的常量或变量。当这两个属性 被初始化为整数 0 的时候，它们会被推断为 Int 类型。
     */
}

class VideoMode {
    var resolution = Resolution()
    var interlaced = false
    var frameRate = 0.0
    var name: String?
    /*
     在上面的示例中我们还定义了一个名为 VideoMode 的类，用来描述一个视频显示器的特定模式。这个类包含了四 个变量存储属性。第一个是 分辨率 ，它被初始化为一个新的 Resolution 结构体的实例，属性类型被推断为 Reso lution 。新 VideoMode 实例同时还会初始化其它三个属性，它们分别是，初始值为 false 的 interlaced ，初始 值为 0.0 的 frameRate ，以及值为可选 String 的 name 。 name 属性会被自动赋予一个默认值 nil ，意为“没有
     name 值”，因为它是一个可选类型。
     */
}




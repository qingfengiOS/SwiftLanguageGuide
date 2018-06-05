//
//  AccessControl.swift
//  SwiftDemo
//
//  Created by 李一平 on 2018/6/5.
//  Copyright © 2018年 情风. All rights reserved.
//

/**
 访问控制可以限定其它源文件或模块中的代码对你的代码的访问级别。这个特性可以让我们隐藏代码的一些实现细节，并且可以为其他人可以访问和使用的代码提供接口。
 
 可以限定其它源文件或模块中的代码对你的代码的访问级别。这个特性可以让我们隐藏代码的一些实现细节，并且可以为其他人可以访问和使用的代码提供接口。
 
 Swift 不仅提供了多种不同的访问级别，还为某些典型场景提供了默认的访问级别，这样就不需要我们在每段代码中都申明显式访问级别。其实，如果只是开发一个单一 target 的应用程序，我们完全可以不用显式声明代码的访问级别。
 
 为了简单起见，对于代码中可以设置访问级别的特性（属性、基本类型、函数等），在下面的章节中我们会称之为“实体”。
 */
import UIKit

class AccessControl: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        let test = TestForSetterGetter()
        test.test()
    }
}

//MARK:-1、模块和源文件
/*
 Swift 中的访问控制模型基于模块和源文件这两个概念。
 
 模块是指的独立的代码单元，框架或者应用程序会作为一个独立的模块来构建和发布。在 Swift 中，一个模块可以使用 import 关键字导入另外一个模块。
 
 在 Swift 中，Xcode 的每个 target（例如框架或应用程序）都被当作独立的模块处理。如果你是为了实现某个通用的功能，或者是为了封装一些常用方法而将代码打包成独立的框架，这个框架就是 Swift 中的一个模块。当它被导入到某个应用程序或者其他框架时，框架内容都将属于这个独立的模块。
 
 源文件就是 Swift 中的源代码文件，它通常属于一个模块，即一个应用程序或者框架。尽管我们一般会将不同的类型分别定义在不同的源文件中，但是同一个源文件也可以包含多个类型、函数之类的定义。
 */


//MARK:-2、访问级别
/*
 Swift 为代码中的实体提供了五种不同的访问级别。这些访问级别不仅与源文件中定义的实体相关，同时也与源文件所属的模块相关。
 
 1、Open 和 Public 级别可以让实体被同一模块源文件中的所有实体访问，在模块外也可以通过导入该模块来访问源文件里的所有实体。通常情况下，你会使用 Open 或 Public 级别来指定框架的外部接口。Open 和 Public 的区别在后面会提到。
 2、Internal 级别让实体被同一模块源文件中的任何实体访问，但是不能被模块外的实体访问。通常情况下，如果某个接口只在应用程序或框架内部使用，就可以将其设置为 Internal 级别。
 3、File-private 限制实体只能在其定义的文件内部访问。如果功能的部分细节只需要在文件内使用时，可以使用 File-private 来将其隐藏。
 4、Private 限制实体只能在其定义的作用域，以及同一文件内的 extension 访问。如果功能的部分细节只需要在当前作用域内使用时，可以使用 Private 来将其隐藏。
 
 Open 为最高访问级别（限制最少），Private 为最低访问级别（限制最多）。
 
 Open 只能作用于类和类的成员，它和 Public 的区别如下：
 1、Public 或者其它更严访问级别的类，只能在其定义的模块内部被继承。
 2、Public 或者其它更严访问级别的类成员，只能在其定义的模块内部的子类中重写。
 3、Open 的类，可以在其定义的模块中被继承，也可以在引用它的模块中被继承。
 4、Open 的类成员，可以在其定义的模块中子类中重写，也可以在引用它的模块中的子类重写。
 
 把一个类标记为 open，明确的表示你已经充分考虑过外部模块使用此类作为父类的影响，并且设计好了你的类的代码了。
 */

//MARK:--2.1、访问级别基本原则
/*
 Swift 中的访问级别遵循一个基本原则：不可以在某个实体中定义访问级别更低（更严格）的实体。
 
 2.1.1、一个 Public 的变量，其类型的访问级别不能是 Internal，File-private 或是 Private。因为无法保证变量的类型在使用变量的地方也具有访问权限。
 2.1.2、函数的访问级别不能高于它的参数类型和返回类型的访问级别。因为这样就会出现函数可以在任何地方被访问，但是它的参数类型和返回类型却不可以的情况。
 */

//MARK:--2.2、默认访问级别
/*
 如果你没有为代码中的实体显式指定访问级别，那么它们默认为 internal 级别（有一些例外情况，稍后会进行说明）。因此，在大多数情况下，我们不需要显式指定实体的访问级别。
 */

//MARK:--2.3、单 target 应用程序的访问级别
/*
 当你编写一个单目标应用程序时，应用的所有功能都是为该应用服务，而不需要提供给其他应用或者模块使用，所以我们不需要明确设置访问级别，使用默认的访问级别 Internal 即可。但是，你也可以使用 fileprivate 访问或 private 访问级别，用于隐藏一些功能的实现细节。
 */

//MARK:--2.4、框架的访问级别
/*
 当你开发框架时，就需要把一些对外的接口定义为 Open 或 Public，以便使用者导入该框架后可以正常使用其功能。这些被你定义为对外的接口，就是这个框架的 API。
 
 注意 框架依然会使用默认的 internal ，也可以指定为 fileprivate 访问或者 private 访问级别。当你想把某个实体作为框架的 API 的时候，需显式为其指定开放访问或公开访问级别。
 */

//MARK:--2.5、单元测试 target 的访问级别
/*
 当你的应用程序包含单元测试 target 时，为了测试，测试模块需要访问应用程序模块中的代码。默认情况下只有 open 或 public 级别的实体才可以被其他模块访问。然而，如果在导入应用程序模块的语句前使用 @testable 特性，然后在允许测试的编译设置（Build Options -> Enable Testability）下编译这个应用程序模块，单元测试目标就可以访问应用程序模块中所有内部级别的实体。
 */

//MARK:-3、访问控制语法
/*
 通过修饰符 open，public，internal，fileprivate，private 来声明实体的访问级别：
 */
public class SomePublicClass {
    
}
internal class SomeInternalClass {
    
}
fileprivate class SomeFilePrivateClass {
    
}
private class SomePrivateClass {
    
}

public var somePublicVariable = 0
internal let someInternalConstant = 0

fileprivate func someFilePrivateFunction() {
    
}
private func somePrivateFunction() {
    
}
/*
 除非专门指定，否则实体默认的访问级别为 internal，可以查阅默认访问级别这一节。这意味着在不使用修饰符显式声明访问级别的情况下，SomeInternalClass 和 someInternalConstant 仍然拥有隐式的 internal ：
 */
class SomeInternalClasss {}   // 隐式 internal
var someInternalConstants = 0 // 隐式 internal

//MARK:-4、自定义类型
/*
 如果想为一个自定义类型指定访问级别，在定义类型时进行指定即可。新类型只能在它的访问级别限制范围内使用。例如，你定义了一个 fileprivate 级别的类，那这个类就只能在定义它的源文件中使用，可以作为属性类型、函数参数类型或者返回类型，等等。
 
 一个类型的访问级别也会影响到类型成员（属性、方法、构造器、下标）的默认访问级别。如果你将类型指定为 private 或者 fileprivate 级别，那么该类型的所有成员的默认访问级别也会变成 private 或者 fileprivate 级别。如果你将类型指定为公开或者 internal （或者不明确指定访问级别，而使用默认的 internal ），那么该类型的所有成员的默认访问级别将是内部访问。
 
 care:
 上面提到，一个 public 类型的所有成员的访问级别默认为 internal 级别，而不是 public 级别。如果你想将某个成员指定为 public 级别，那么你必须显式指定。这样做的好处是，在你定义公共接口的时候，可以明确地选择哪些接口是需要公开的，哪些是内部使用的，避免不小心将内部使用的接口公开。
 */
public class SomePublicClass2 {                  // 显式 public 类
    public var somePublicProperty = 0            // 显式 public 类成员
    var someInternalProperty = 0                 // 隐式 internal 类成员
    fileprivate func someFilePrivateMethod() {}  // 显式 fileprivate 类成员
    private func somePrivateMethod() {}          // 显式 private 类成员
}

class SomeInternalClass2 {                       // 隐式 internal 类
    var someInternalProperty = 0                 // 隐式 internal 类成员
    fileprivate func someFilePrivateMethod() {}  // 显式 fileprivate 类成员
    private func somePrivateMethod() {}          // 显式 private 类成员
}

fileprivate class SomeFilePrivateClass2 {        // 显式 fileprivate 类
    func someFilePrivateMethod() {}              // 隐式 fileprivate 类成员
    private func somePrivateMethod() {}          // 显式 private 类成员
}

private class SomePrivateClass2 {                // 显式 private 类
    func somePrivateMethod() {}                  // 隐式 private 类成员
}

//MARK:--4.1、元祖类型
/*
 元组的访问级别将由元组中访问级别最严格的类型来决定。例如，如果你构建了一个包含两种不同类型的元组，其中一个类型为 internal，另一个类型为 private，那么这个元组的访问级别为 private。
 
 care:
 元组不同于类、结构体、枚举、函数那样有单独的定义。元组的访问级别是在它被使用时自动推断出的，而无法明确指定。
 */

//MARK:--4.2、函数类型
/*
 函数的访问级别根据访问级别最严格的参数类型或返回类型的访问级别来决定。但是，如果这种访问级别不符合函数定义所在环境的默认访问级别，那么就需要明确地指定该函数的访问级别。
 
 下面的例子定义了一个名为 someFunction() 的全局函数，并且没有明确地指定其访问级别。也许你会认为该函数应该拥有默认的访问级别 internal，但事实并非如此。事实上，如果按下面这种写法，代码将无法通过编译：
 */

//func someTestFunction() -> (SomeInternalClass, SomePrivateClass) {}//提示需要制定访问类型


/*
 我们可以看到，这个函数的返回类型是一个元组，该元组中包含两个自定义的类（可查阅自定义类型）。其中一个类的访问级别是 internal，另一个的访问级别是 private，所以根据元组访问级别的原则，该元组的访问级别是 private（元组的访问级别与元组中访问级别最低的类型一致）
 
 因为该函数返回类型的访问级别是 private，所以你必须使用 private 修饰符，明确指定该函数的访问级别：
 */
private func someTestFunction() -> (SomeInternalClass, SomePrivateClass)? {
    // 此处是函数实现部分
    return nil
}
/*
 care:
 将该函数指定为 public 或 internal，或者使用默认的访问级别 internal 都是错误的，因为如果把该函数当做 public 或 internal 级别来使用的话，可能会无法访问 private 级别的返回值。
 */

//MARK:--4.3、枚举类型
/*
 枚举成员的访问级别和该枚举类型相同，你不能为枚举成员单独指定不同的访问级别。
 
 比如下面的例子，枚举 CompassPoint 被明确指定为 public，那么它的成员 North、South、East、West 的访问级别同样也是 public：
 */
public enum CompassPoints {
    case North
    case South
    case East
    case West
}

//MARK:--4.4、原始值和关联值
/*
 枚举定义中的任何原始值或关联值的类型的访问级别至少不能低于枚举类型的访问级别。例如，你不能在一个 internal 的枚举中定义 private 的原始值类型。
 */

//MARK:--4.5、嵌套类型
/*
 如果在 private 的类型中定义嵌套类型，那么该嵌套类型就自动拥有 private 访问级别。如果在 public 或者 internal 级别的类型中定义嵌套类型，那么该嵌套类型自动拥有 internal 访问级别。如果想让嵌套类型拥有 public 访问级别，那么需要明确指定该嵌套类型的访问级别。
 */

//MARK:-5、子类
/*
 子类的访问级别不得高于父类的访问级别。例如，父类的访问级别是 internal，子类的访问级别就不能是 public。
 
 此外，你可以在符合当前访问级别的条件下重写任意类成员（方法、属性、构造器、下标等）。
 
 可以通过重写为继承来的类成员提供更高的访问级别。下面的例子中，类 A 的访问级别是 public，它包含一个方法 someMethod()，访问级别为 private。类 B 继承自类 A，访问级别为 internal，但是在类 B 中重写了类 A 中访问级别为 private 的方法 someMethod()，并重新指定为 internal 级别。通过这种方式，我们就可以将某类中 private 级别的类成员重新指定为更高的访问级别，以便其他人使用：
 */
public class A {
    fileprivate func someMethod() {}
}

internal class B: A {
    override internal func someMethod() {}
}
/*
 我们甚至可以在子类中，用子类成员去访问访问级别更低的父类成员，只要这一操作在相应访问级别的限制范围内（也就是说，在同一源文件中访问父类 private 级别的成员，在同一模块内访问父类 internal 级别的成员）：
 */
public class ClassA {
    fileprivate func someMethod() {}
}

internal class ClassB: ClassA {
    override internal func someMethod() {
        super.someMethod()
        //因为父类 A 和子类 B 定义在同一个源文件中，所以在子类 B 可以在重写的 someMethod() 方法中调用 super.someMethod()。
    }
}

//MARK:-6、常量、变量、属性、下标
/*
 常量、变量、属性不能拥有比它们的类型更高的访问级别。例如，你不能定义一个 public 级别的属性，但是它的类型却是 private 级别的。同样，下标也不能拥有比索引类型或返回类型更高的访问级别。
 
 如果常量、变量、属性、下标的类型是 private 级别的，那么它们必须明确指定访问级别为 private：
 */
private var privateInstance = SomePrivateClass()

//MARK:--6.1、Getter 和 Setter
/*
 常量、变量、属性、下标的 Getters 和 Setters 的访问级别和它们所属类型的访问级别相同。
 
 Setter 的访问级别可以低于对应的 Getter 的访问级别，这样就可以控制变量、属性或下标的读写权限。在 var 或 subscript 关键字之前，你可以通过 fileprivate(set)，private(set) 或 internal(set) 为它们的写入权限指定更低的访问级别。
 
 care:
 这个规则同时适用于存储型属性和计算型属性。即使你不明确指定存储型属性的 Getter 和 Setter，Swift 也会隐式地为其创建 Getter 和 Setter，用于访问该属性的后备存储。使用 fileprivate(set)，private(set) 和 internal(set) 可以改变 Setter 的访问级别，这对计算型属性也同样适用。
 */
struct TrackedString {
    private(set) var numberOfEdits = 0
    var value: String = "" {
        didSet {
            numberOfEdits += 1
        }
    }
}

/*
 TrackedString 结构体定义了一个用于存储 String 值的属性 value，并将初始值设为 ""（一个空字符串）。该结构体还定义了另一个用于存储 Int 值的属性 numberOfEdits，它用于记录属性 value 被修改的次数。这个功能通过属性 value 的 didSet 观察器实现，每当给 value 赋新值时就会调用 didSet 方法，然后将 numberOfEdits 的值加一。
 
 结构体 TrackedString 和它的属性 value 都没有显式地指定访问级别，所以它们都是用默认的访问级别 internal。但是该结构体的 numberOfEdits 属性使用了 private(set) 修饰符，这意味着 numberOfEdits 属性只能在结构体的定义中进行赋值。numberOfEdits 属性的 Getter 依然是默认的访问级别 internal，但是 Setter 的访问级别是 private，这表示该属性只能在内部修改，而在结构体的外部则表现为一个只读属性。
 
 如果你实例化 TrackedString 结构体，并多次对 value 属性的值进行修改，你就会看到 numberOfEdits 的值会随着修改次数而变化：
 */
class TestForSetterGetter {
    var stringToEdit = TrackedString()
    
    func test() {
        stringToEdit.value = "This string will be tracked."
        stringToEdit.value += " This edit will increment numberOfEdits."
        stringToEdit.value += " So will this one."
        print("The number of edits is \(stringToEdit.numberOfEdits)")
    }
    
}
/*
 虽然你可以在其他的源文件中实例化该结构体并且获取到 numberOfEdits 属性的值，但是你不能对其进行赋值。这一限制保护了该记录功能的实现细节，同时还提供了方便的访问方式。
 
 你可以在必要时为 Getter 和 Setter 显式指定访问级别。下面的例子将 TrackedString 结构体明确指定为了 public 访问级别。结构体的成员（包括 numberOfEdits 属性）拥有默认的访问级别 internal。你可以结合 public 和 private(set) 修饰符把结构体中的 numberOfEdits 属性的 Getter 的访问级别设置为 public，而 Setter 的访问级别设置为 private：
 */
public struct TrackedString2 {
    public private(set) var numberOfEdits = 0
    public var value: String = "" {
        didSet {
            numberOfEdits += 1
        }
    }
    public init() {}
}

//MARK:-构造器


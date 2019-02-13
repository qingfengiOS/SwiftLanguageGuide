//
//  Closures.swift
//  SwiftDemo
//
//  Created by qingfeng on 2018/4/27.
//  Copyright © 2018年 情风. All rights reserved.
//

import UIKit

class Closures: UIViewController {
    /*
     闭包是自包含的函数代码块，可以在代码中被传递和使用。Swift 中的闭包与 C 和 Objective-C 中的代码块(blocks)以及其他一些编程语言中的匿名函数比较相似。
     
     闭包可以捕获和存储其所在上下文中任意常量和变量的引用。被称为包裹常量和变量。 Swift会为你管理在捕获过程中涉及到的所有内存操作。
     
     在函数章节中介绍的全局和嵌套函数实际上也是特殊的闭包，闭包采取如下三种形式之一:
     • 全局函数是一个有名字但不会捕获任何值的闭包
     • 嵌套函数是一个有名字并可以捕获其封闭函数域内值的闭包
     • 闭包表达式是一个利用轻量级语法所写的可以捕获其上下文中变量或常量值的匿名闭包
     
     
     Swift的闭包表达式拥有简洁的风格，并鼓励在常见场景中进行语法优化，主要优化如下:
     • 利用上下文推断参数和返回值类型
     • 隐式返回单表达式闭包，即单表达式闭包可以省略 return 关键字
     • 参数名称缩写
     • 尾随闭包语法
     
     */
    var completionHandlers: [() -> Void] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
    
        //sorted(by:) 方法接受一个闭包，该闭包函数需要传入与数组元素类型相同的两个值，并返回一个布尔类型值来 表明当排序结束后传入的第一个参数排在第二个参数前面还是后面。如果第一个参数值出现在第二个参数值前 面，排序闭包函数需要返回 true ，反之返回 false 。
        let names = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
        let reversedNames = names.sorted(by: backward)
        print(reversedNames)
        
        closureExpressionSyntax()
        inferringTypeFromContext()
        implicitReturnsFromSingleExpressionClosures()
        shorthandArgumentNames()
        operatorMethods()
        
        captureValue()
        autoClosure()
    }
    
    /// sorted 方法
    func backward(_ s1: String, _ s2:String) -> Bool {
        return s1 > s2
    }
    
    /// 闭包表达式语法
    func closureExpressionSyntax() {
        /**闭包表达式语法有如下的一般形式:
         
         { (parameters) -> retuenType in
         statements
         }
         
         闭包表达式的参数可以使in-out参数，但是不能设定默认值。也可以使用具名的可变参数。元组也可以作为参数和返回值
         
         使用闭包展示上面backward(_:_:)函数对应的闭包表达式版本的代码
         */
        let names = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
        let reversedNames = names.sorted(by: { (s1: String, s2: String) -> Bool in
            return s1 > s2
        })
        print(reversedNames)
        
        //reversedNames = names.sorted(by: { (s1: String, s2: String) -> Bool in return s1 > s2 } )//由于这个闭包的函数体部分如此短，以至于可以将其改写成一行
        /*
         需要注意的是
         1、内联闭包参数和返回值类型声明与 backward(_:_:) 函数类型声明相同。在这两种方式中，都写成 了 (s1: String, s2: String) -> Bool 。然而在内联闭包表达式中，函数和返回值类型都写在大括号内，而不是大括号外。

         2、闭包的函数体部分由关键字in引入。该关键字表示闭包的参数和返回值类型定义已经完成，闭包函数体即将开始。
         */
        
    }
    
    
    
    /// 根据上下文推断类型
    func inferringTypeFromContext() {
        
        /**
         因为排序闭包函数是作为 sorted(by:) 方法的参数传入的，Swift 可以推断其参数和返回值的类型。 sorted(b y:) 方法被一个字符串数组调用，因此其参数必须是 (String, String) -> Bool 类型的函数。这意味着 (Stri ng, String) 和 Bool 类型并不需要作为闭包表达式定义的一部分。因为所有的类型都可以被正确推断，返回箭 头( -> )和围绕在参数周围的括号也可以被省略:
         */
        
        let names = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
        let reversedNames = names.sorted(by: { s1, s2 in return s1 > s2})
        print(reversedNames)
        /*
         实际上，通过内联闭包表达式构造的闭包作为参数传递给函数或方法时，总是能够推断出闭包的参数和返回值类型。这意味着闭包作为函数或者方法的参数时，你几乎不需要利用完整格式构造内联闭包。
         尽管如此，你仍然可以明确写出有着完整格式的闭包。如果完整格式的闭包能够提高代码的可读性，则我们更鼓 励采用完整格式的闭包。而在 sorted(by:) 方法这个例子里，显然闭包的目的就是排序。由于这个闭包是为了 处理字符串数组的排序，因此读者能够推测出这个闭包是用于字符串处理的。
         */
    }
    
    
    /// 单表达式闭包隐式返回
    func implicitReturnsFromSingleExpressionClosures() {
        //单行表达式闭包可以通过省略 return 关键字来隐式返回单行表达式的结果，如上版本的例子可以改写为:
        let names = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
        let reversedNames = names.sorted(by: {s1, s2 in s1 > s2})
        print(reversedNames)
        
        /*
         在这个例子中，sorted(by:) 方法的参数类型明确了闭包必须返回一个 Bool 类型值。因为闭包函数体只包含 了一个单一表达式( s1 > s2 )，该表达式返回 Bool 类型值，因此这里没有歧义， return 关键字可以省 略。
         */
    }
    
    
    /// 参数名称缩写
    func shorthandArgumentNames() {
        /*
         Swift自动为内联闭包提供了参数名称缩写功能，你可以直接通过$0，$1，$2来顺序调用闭包的参数，以此类推
         
         如果你在闭包表达式中使用参数名缩写，你可以在闭包定义中省略参数列表，并且对应参数名称所写的类型会通过函数类型进行推断。in关键字也同样可以被省略，因为此时闭包表达式完全有闭包函数体构成
        */
        let names = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
        let reversedNames = names.sorted(by: {$0 > $1})
        print(reversedNames)
        
        /*
         在这个例子中，$0和$1表示闭包中第一个和第二个 String 类型的参数。
         */
        
    }
    
    
    /// 运算符方法
    func operatorMethods() {
        /*
         实际上还有一种更简短的方式来编写上面例子中的闭包表达式。Swift 的 String 类型定义了关于大于 号(>)的字符串实现，其作为一个函数接受两个 String 类型的参数并返回 Bool 类型的值。而这正好与
         sorted(by:) 方法的参数需要的函数类型相符合。因此，你可以简单地传递一个大于号，Swift 可以自动推断出 你想使用大于号的字符串函数实现:
         */
        let names = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
        let reversedNames = names.sorted(by: <)
        print(reversedNames)
    }
    
    
    //MARK: -尾随闭包
    //如果你需要将一个很长的闭包表达式作为最后一个参数传递给函数，可以使用尾随闭包来增强函数的可读性。尾随闭包是一个书写在函数括号之后的闭包表达式，函数支持将其作为最后一个参数调用。在使用尾随闭包时，你不用写出它的参数标签:
    func functionThatTakesAClosure(closure: () -> Void) {
        //函数主题部分
    }
    
    
    func trailingClosures() {
        
        //以下是不使用尾随闭包进行函数调用
        functionThatTakesAClosure(closure: {
            //闭包主体部分
        })
        
        // 以下是使用尾随闭包进行函数调用
        functionThatTakesAClosure {
            //闭包主体部分
        }
        
        //尾随闭包调用sorted函数
        let names = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
        let reversedNames = names.sorted() {
            $0 > $1
        }
        print(reversedNames)
        
        //如果闭包表达式是函数或方法的唯一参数，则当你使用尾随闭包时，你甚至可以把 () 省略掉:
        let reverseNames = names.sorted { $0 > $1 }
        print(reverseNames)
        
        
        /*
         当闭包非常长以至于不能在一行中进行书写时，尾随闭包变得非常有用。举例来说，Swift 的 Array 类型有一 个 map(_:) 方法，这个方法获取一个闭包表达式作为其唯一参数。该闭包函数会为数组中的每一个元素调用一 次，并返回该元素所映射的值。具体的映射方式和返回值类型由闭包来指定。
         */
        
        //下例介绍了如何在 map(_:) 方法中使用尾随闭包将 Int 类型数组 [16, 58, 510] 转换为包含对应 String 类型的值的数组 ["OneSix", "FiveEight", "FiveOneZero"] :
        let digitNames = [0: "Zero", 1: "One", 2: "Two",   3: "Three", 4: "Four",5: "Five", 6: "Six", 7: "Seven", 8: "Eight", 9: "Nine"]
        
        let numbers = [16, 58, 510]
        
        let strings = numbers.map {
            (number) -> String in
            var number = number
            var output = ""
            repeat {
                output = digitNames[number % 10]! + output
                number /= 10
            } while number > 0
            return output
        }
        print(strings)
        /*
         map(_:) 为数组中每一个元素调用了一次闭包表达式。你不需要指定闭包的输入参数 number 的类型，因为可 以通过要映射的数组类型进行推断。
         
         在该例中，局部变量 number 的值由闭包中的 number 参数获得，因此可以在闭包函数体内对其进行修改，(闭 包或者函数的参数总是常量)，闭包表达式指定了返回类型为 String ，以表明存储映射值的新数组类型为 String。

         */
        
    }
    
    //MARK: --值捕获
    func makeIncrementer(forIncrement amount: Int) -> () -> Int {
        //Swift 中，可以捕获值的闭包的最简单形式是嵌套函数，也就是定义在其他函数的函数体内的函数。嵌套函数可以捕获其外部函数所有的参数以及定义的常量和变量。
        
        //举个例子，这有一个叫做 makeIncrementor 的函数，其包含了一个叫做 incrementor 的嵌套函数。嵌套函数 incrementor() 从上下文中捕获了两个值，runningTotal 和 amount。捕获这些值之后，makeIncrementor 将 incrementor 作为闭包返回。每次调用 incrementor 时，其会以 amount 作为增量增加 runningTotal 的值。
        
        var runningTotal = 0
        func incrementer() -> Int {
            runningTotal += amount
            return runningTotal
        }
        return incrementer
        /*
         incrementer() 函数并没有任何参数，但是在函数体内访问了 runningTotal 和 amount 变量。这是因为它从 外围函数捕获了 runningTotal 和 amount 变量的引用。捕获引用保证了 runningTotal 和 amount 变量在 调用完 makeIncrementer 后不会消失，并且保证了在下一次执行 incrementer 函数时，runningTotal 依旧存在。
         */
    }
    
    
    func captureValue() {
        
        let incrementByTen = makeIncrementer(forIncrement: 10)
        print(incrementByTen)
        let incrementBySeven = makeIncrementer(forIncrement: 7)
        print(incrementBySeven())
        /*
         闭包是引用类型
         上面的例子中，incrementBySeven 和 incrementByTen 都是常量，但是这些常量指向的闭包仍然可以增加其捕 获的变量的值。这是因为函数和闭包都是引用类型。
         无论你将函数或闭包赋值给一个常量还是变量，你实际上都是将常量或变量的值设置为对应函数或闭包的引 用。上面的例子中，指向闭包的引用incrementByTen是一个常量，而并非闭包内容本身。
         */
        
        //这也意味着如果你将闭包赋值给了两个不同的常量或变量，两个值都会指向同一个闭包:
        let alsoIncrementByTen = incrementByTen
        print(alsoIncrementByTen())
        
    }
    
    //MARK:--逃逸闭包
    //当一个闭包作为参数传到一个函数中，但是这个闭包在函数返回之后才被执行，我们称该闭包从函数中逃逸。当 你定义接受闭包作为参数的函数时，你可以在参数名之前标注 @escaping ，用来指明这个闭包是允许“逃逸”出 这个函数的。
    
    //一种能使闭包“逃逸”出函数的方法是，将这个闭包保存在一个函数外部定义的变量中。举个例子，很多启动异 步操作的函数接受一个闭包参数作为 completion handler。这类函数会在异步操作开始之后立刻返回，但是闭包 直到异步操作结束后才会被调用。在这种情况下，闭包需要“逃逸”出函数，因为闭包需要在函数返回之后被调 用。例如
    
    func someFunctionWithEscapingClosure(completionHandler: @escaping() -> Void) {
        completionHandlers.append(completionHandler)
    }
    /*
     someFunctionWithEscapingClosure(_:) 函数接受一个闭包作为参数，该闭包被添加到一个函数外定义的数组 中。如果你不将这个参数标记为 @escaping ，就会得到一个编译错误。
     
     将一个闭包标记为 @escaping 意味着你必须在闭包中显式地引用 self 。比如说，在下面的代码中，传递到 s omeFunctionWithEscapingClosure(_:) 中的闭包是一个逃逸闭包，这意味着它需要显式地引用 self 。相对的，传递到 someFunctionWithNonescapingClosure(_:) 中的闭包是一个非逃逸闭包，这意味着它可以隐式引用self 。
     */
    
    func someFutionWithNoneescapingClosure(closure: () -> Void) {
        closure()

    }
    
    var x = 10
    func doSomethig() {
        someFunctionWithEscapingClosure { self.x = 100}
        someFutionWithNoneescapingClosure { x = 200 }
    }
    
    //MARK: --自动闭包
    //自动闭包是一种自动创建的闭包，用于包装传递给函数作为参数的表达式。这种闭包不接受任何参数，当它被调用的时候，会返回被包装在其中的表达式的值。这种便利语法让你能够省略闭包的花括号，用一个普通的表达式来代替显式的闭包。
    func autoClosure() {
        
        var customersInLine = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
        print(customersInLine.count)// 打印出 "5"

        let customerProvider = { customersInLine.remove(at: 0) }
        print(customersInLine.count)// 打印出 "5"

        
        print("Now serving \(customerProvider())!") // Prints "Now serving Chris!"
        print(customersInLine.count)// 打印出 "4"
        /*
         尽管在闭包的代码中,customersInLine的第一个元素被移除了，不过在闭包被调用之前，这个元素是不会被移除的。如果这个闭包永远不被调用，那么在闭包里面的表达式将永远不会执行，那意味着列表中的元素永远不会 被移除。请注意，customersInLine的类型不是String，而是() -> String ，一个没有参数且返回值为String的函数。
         */
 
        
//        serve { () -> String in
//            customersInLine.remove(at: 0)
//        }
        serve { customersInLine.remove(at: 0)}//这两种调用一样
        
        
        serve(customer: customersInLine.remove(at: 0))
        
        
        customersInLine = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
        collectCustomerProviders(customersInLine.remove(at: 0))
        collectCustomerProviders(customersInLine.remove(at: 0))
        print("Collected \(customerProviders.count) closures.")
        for customerProvider in customerProviders {
            print("Now serving \(customerProvider())!")
        }
        
        
    }
    
    //将闭包作为参数传递给函数时，你能获得同样的延时求值行为。
    func serve(customer customerProvider: () -> String) {
        print("Now serving \(customerProvider())!")
        print(customerProvider().count)
    }
    
    
    //上面的 serve(customer:) 函数接受一个返回顾客名字的显式的闭包。下面这个版本的 serve(customer:) 完成 了相同的操作，不过它并没有接受一个显式的闭包，而是通过将参数标记为 @autoclosure 来接收一个自动闭 包。现在你可以将该函数当作接受 String 类型参数(而非闭包)的函数来调用。customerProvider 参数将自 动转化为一个闭包，因为该参数被标记了 @autoclosure 特性
    func serve(customer cuntomerProvide: @autoclosure () -> String) {
        print("Now serving \(cuntomerProvide())!")
        print(cuntomerProvide().count)
    }
    
    
    
    //如果你想让一个自动闭包可以“逃逸”，则应该同时使用 @autoclosure 和 @escaping 属性。
    var customerProviders: [() -> String] = []
    func collectCustomerProviders(_ customerProvider: @autoclosure @escaping () -> String) {
        customerProviders.append(customerProvider)
        /*
         在上面的代码中，collectCustomerProviders(_:) 函数并没有调用传入的 customerProvider 闭包，而是将闭包 追加到了 customerProviders 数组中。这个数组定义在函数作用域范围外，这意味着数组内的闭包能够在函数返 回之后被调用。因此，customerProvider 参数必须允许“逃逸”出函数作用域。
         */
    }
   
    
    
}



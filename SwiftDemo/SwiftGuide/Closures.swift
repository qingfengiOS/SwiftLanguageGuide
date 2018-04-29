//
//  Closures.swift
//  SwiftDemo
//
//  Created by liyiping on 2018/4/27.
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
    
    
    
    
}

//
//  Functions.swift
//  SwiftDemo
//
//  Created by qingfeng on 2018/4/26.
//  Copyright © 2018年 情风. All rights reserved.
//

import UIKit

class Functions: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.white
        
        print(greet(person: "Anna"))
        
        print(sayHello())
        
        let bounds = minMax(array: [8, -6, 2, 109, 3, 71])
        print("min is \(bounds.min) and max is \(bounds.max)")
        
        if let bound = minMaxOption(array: []) {
            print("min is \(bound.min) and max is \(bound.max)")
        } else {
            print("return value is nil")
        }
        
        someFunction(firstParameterName: 1, secondParameterName: 2)
        
        print(greet(person: "Bill", from: "Cupertuno"))
        
        somFuncton(1, 2)
        
        someFunctionDefaultValue(parameterWithoutDefault: 10)
        someFunctionDefaultValue(parameterWithoutDefault: 10, parameterWithDefault: 11)
        print(arithmeticMean(1,2,3,5,9))
        
        var someInt = 3
        var anotherInt = 107
        swapTwoInts(&someInt, &anotherInt)
        print("someInt is now \(someInt), and anotherInt is now \(anotherInt)")
        
        printMathResult(addTwoInts, 3, 5)//函数类型做参数
        
        //函数类型做返回值
        var value = 3
        let moveNearZero = chooseStepFunction(backward: value > 0)
        // moveNearerToZero 现在指向 stepBackward() 函数。
        
        print("Counting to zero:")
        // Counting to zero:
        while value != 0 {
            print("\(value)... ")
            value = moveNearZero(value)
        }
        print("zero!")
        
        //函数嵌套
        var currentValue = -4
        let moveNearerToZero = chooseStepFunction(backward: currentValue > 0)
        // moveNearerToZero now refers to the nested stepForward() function
        while currentValue != 0 {
            print("\(currentValue)... ")
            currentValue = moveNearerToZero(currentValue)
        }
        print("zero!")
        
    }

    
    // 方法的定义和调用
    func greet(person: String) -> String {
        let greeting = "hello," + person + "!"
        return greeting
    }
    
    func greetAgain(person: String) -> String {
        let greeting = "hello," + person + "again" + "!"
        return greeting
    }
    
    //MARK:-方法的参数和返回值
    
    //无参数有返回值
    func sayHello() -> String {
        return "hello world"
    }
    
    //多个参数
    func greet(person: String, alreadyGreeted: Bool) -> String {
        if alreadyGreeted {
            return greetAgain(person: person)
        } else {
            return greet(person: person)
        }
    }
    
    //无返回值
    func greeting(person: String) {
        print("Hello, \(person)!")
        
    }
   
    //多重返回值
    func minMax(array: [Int]) -> (min: Int, max: Int) {
        var currentMin = array[0]
        var currentMax = array[0]
        for value in array[1..<array.count] {
            if value < currentMin {
                currentMin = value
            } else if value > currentMax {
                currentMax = value
            }
        }
        return (currentMin, currentMax)
    }
    
    
    //可选元组返回类型
    //如果函数返回的元组类型有可能整个元组都“没有值”，你可以使用可选的( optional ) 元组返回类型反映 整个元组可以是nil的事实。你可以通过在元组类型的右括号后放置一个问号来定义一个可选元组，例如 (Int, Int)? 或 (String, Int, Bool)?
    
    func minMaxOption(array: [Int]) -> (min: Int, max:Int)? {
        if array.isEmpty {
            return nil;
        }
        var currentMin = array[0]
        var currentMax = array[0]
        for value in array[1..<array.count] {
            if value < currentMin {
                currentMin = value
            } else if value > currentMax {
                currentMax = value
            }
        }
        return (currentMin, currentMax)
    }
    
    //MARK:-- 参数标签和参数名称
    /// 默认情况下，函数参数使用参数名称来作为它们的参数标签
    func someFunction(firstParameterName: Int, secondParameterName: Int) {
        // In the function body, firstParameterName and secondParameterName
        // refer to the argument values for the first and second parameters.
    }
    
    //MARK:-- 指定参数标签
    /// 参数标签的使用能够让一个函数在调用时更有表达力，更类似自然语言，并且仍保持了函数内部的可读性以及清晰的意图。
    func greet(person: String, from hometown: String) -> String {
        return "Hello \(person)!  Glad you could visit from \(hometown)."
    }
    
    //MARK:-- 忽略参数标签
    /// 如果不希望为某个参数添加一个标签，可以使用一个下划线( _ )来代替一个明确的参数标签。
    func somFuncton(_ firstParameterName: Int, _ secondParameterName: Int) {
        print("在函数体内，firstParameterName 和 secondParameterName 代表参数中的第一个和第二个参数值")
    }
    
    //MARK:-- 默认参数值
    /// 可以在函数体中通过给参数赋值来为任意一个参数定义默认值(Deafult Value)。当默认值被定义后，调用这 个函数时可以忽略这个参数。
    func someFunctionDefaultValue(parameterWithoutDefault: Int, parameterWithDefault: Int = 12)  {
        print("parameterWithoutDefault = \(parameterWithoutDefault),parameterWithDefault = \(parameterWithDefault)")
    }
    
    //MARK:-- 可变参数
    /**
     一个可变参数(variadic parameter)可以接受零个或多个值。函数调用时，你可以用可变参数来指定函数参数 可以被传入不确定数量的输入值。通过在变量类型名后面加入( ... )的方式来定义可变参数。
     可变参数的传入值在函数体中变为此类型的一个数组。例如，一个叫做 numbers 的 Double... 型可变参 数，在函数体内可以当做一个叫 numbers 的 [Double] 型的数组常量。
     */
    func arithmeticMean(_ numbers: Double...) -> Double {
        var total: Double = 0
        for number in numbers {
            total += number
        }
        return total / Double(numbers.count)
        
        //care: 一个函数最多只能拥有一个可变参数
    }
    
    //MARK:-- 输入输出参数
    
    /// 函数参数默认是常量。试图在函数体中更改参数值将会导致编译错误(compile-time error)。这意味着你不能错 误地更改参数值。如果你想要一个函数可以修改参数的值，并且想要在这些修改在函数调用结束后仍然存在，那 么就应该把这个参数定义为输入输出参数(In-Out Parameters)。 定义一个输入输出参数时，在参数定义前加 inout 关键字。一个输入输出参数有传入函数的值，这个值被函数 修改，然后被传出函数，替换原来的值
    func swapTwoInts(_ a: inout Int, _ b: inout Int) {
        let temp = a
        a = b
        b = temp
        
        /*
         输入输出参数和返回值是不一样的。上面的swapTwoInts函数并没有定义任何返回值，但仍然修改了someInt和anotherInt的值。输入输出参数是函数对函数体外产生影响的另一种方式。
         */
    }
    
    //MARK:-- 函数类型
    //每个函数都有种特定的函数类型，函数的类型由函数的参数类型和返回类型组成。
    
    func addTwoInts(_ a: Int, _ b: Int) -> Int {
        return a + b
    }
    func multiplyTwoInts(_ a: Int, _ b: Int) -> Int {
        return a * b
    }
    /*
     这个例子中定义了两个简单的数学函数:addTwoInts 和 multiplyTwoInts。这两个函数都接受两个 Int 值， 返回一个 Int 值。
     */
    
    func printHelloWorld() {
        print("hello, world")
    }
    /*
     这个函数的类型是: () -> Void ，或者叫“没有参数，并返回 Void 类型的函数”。
     */
    
    
    func useFuncType() {
        // 在 Swift 中，使用函数类型就像使用其他类型一样。例如，你可以定义一个类型为函数的常量或变量，并将适当 的函数赋值给它:
        var mathFunction: (Int, Int) -> Int = addTwoInts
        
        /**
         这段代码可以被解读为:
         定义一个叫做mathFunction的变量，类型是‘一个有两个Int型的参数并返回一个Int型的值的函
         数’，并让这个新变量指向addTwoInts的函数。
         addTwoInts和mathFunction有同样的类型，所以这个赋值过程在 Swift 类型检查(type-check）中是允许的。
         现在，你可以用mathFunction来调用被赋值的函数了:
         */
        print("Result is : \(mathFunction(2,3))")
    }
    
    //MARK:-- 函数类型作为参数类型
    //你可以用 (Int, Int) -> Int 这样的函数类型作为另一个函数的参数类型。这样你可以将函数的一部分实现留给 函数的调用者来提供。
    //下面是另一个例子，正如上面的函数一样，同样是输出某种数学运算结果:（函数参数提供运算方法，根据运算方法来计算第二三个参数）
    func printMathResult(_ mathFunction: (Int, Int) -> Int, _ a: Int, _ b: Int) {
        print("Result \(mathFunction(a,b))")//使用第一个函数参数，求第二个和第三个蚕食的和
        
        /*
         这个例子定义了 printMathResult(_:_:_:) 函数，它有三个参数:第一个参数叫 mathFunction ，类型是 (Int, Int) -> Int ，你可以传入任何这种类型的函数;第二个和第三个参数叫 a 和 b ，它们的类型都是 Int ，这 两个值作为已给出的函数的输入值。
         当 printMathResult(_:_:_:) 被调用时，它被传入 addTwoInts 函数和整数 3 和 5 。它用传入 3 和 5 调用 addTwoInts ，并输出结果: 8 。
         printMathResult(_:_:_:) 函数的作用就是输出另一个适当类型的数学函数的调用结果。它不关心传入函数是如 何实现的，只关心传入的函数是不是一个正确的类型。这使得 printMathResult(_:_:_:) 能以一种类型安全(ty pe-safe)的方式将一部分功能转给调用者实现。
         */
    }
    
    //MARK:-- 函数类型作为返回类型
    //可以用函数类型作为另一个函数的返回类型。你需要做的是在返回箭头(->)后写一个完整的函数类型
    func stepForward(_ input: Int) -> Int {
        return input + 1
    }
    func stepBackward(_ input: Int) -> Int {
        return input - 1
    }
    //如下名为 chooseStepFunction(backward:) 的函数，它的返回类型是 (Int) -> Int 类型的函数。 chooseStepF unction(backward:) 根据布尔值 backwards 来返回 stepForward(_:) 函数或 stepBackward(_:) 函数:
    func chooseStepFunction(backward: Bool) -> (Int) -> Int {
        return backward ? stepBackward : stepForward
    }
    
    
    //MARK:-嵌套函数
    /**到目前为止本章中你所见到的所有函数都叫全局函数(global functions)，它们定义在全局域中。你也可以把 函数定义在别的函数体中，称作 嵌套函数(nested functions)。
    默认情况下，嵌套函数是对外界不可见的，但是可以被它们的外围函数(enclosing function)调用。一个外围 函数也可以返回它的某一个嵌套函数，使得这个函数可以在其他域中被使用。
    你可以用返回嵌套函数的方式重写 chooseStepFunction(backward:) 函数:
     */
    func chooseStepFunctionInner(backward: Bool) -> (Int) -> Int {
        func stepForward(input: Int) -> Int { return input + 1 }
        func stepBackward(input: Int) -> Int { return input - 1 }
        return backward ? stepBackward : stepForward
    }
    
}

//
//  ControlFlow.swift
//  SwiftDemo
//
//  Created by liyiping on 2018/4/25.
//  Copyright © 2018年 情风. All rights reserved.
//

import UIKit

class ControlFlow: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        forinLoop()
        
        whileLoop()
        repeatWhileLoop()
        
        ifStatements()
        switchStatements()

    }

    
    //MARK:--forin循环
	func forinLoop() {
        
        let names = ["Anna","Alex","Brian","Jack"]
        for name in names {//遍历数组
            print("hello \(name)!")
        }
        
        let numberOfLegs = ["spider": 8, "ant": 6, "cat": 4]
        for (animal, legCount) in numberOfLegs {//遍历字典
            print("'\(animal)s have \(legCount) legs")
        }
        
        //index 是一个每次循环遍历开始时被自动赋值的常量。这种情况下， index 在使用前不需要声 明，只需要将它包含在循环的声明中，就可以对其进行隐式声明，而无需使用 let 关键字声明。如果你不需要区间序列内每一项的值，你可以使用下划线( _ )替代变量名来忽略这个值:
        let base = 3
        let power = 2
        var result = 1;
        for _ in 1...power {
            result *= base
        }
        print("\(base) to the power of \(power) is \(result)")
        
        for index in 1...5 {//循环来遍历一个集合中的所有元素，例如数字范围、数组中的元素或者字符串中的字符。
            print("\(index) times 5 is \(index * 5)")
        }
        
        let minutes = 60
        for tickMark in 0..<minutes {//遍历[0-60）左闭右开区间
            // render the tick mark each minute (60 times)
            print("\(tickMark)")
        }
        
        //跨(从:到::)函数跳过不必要的标志。
        let minuteInterval = 5//跨度为5
        for tickMark in stride(from: 0, to: minutes, by: minuteInterval) {
            print("\(tickMark)")
            // render the tick mark every 5 minutes (0, 5, 10, 15 ... 45, 50, 55)
        }
        
        //封闭的范围也可以通过使用步(从:到::):
        let hours = 12
        let hourinterval = 3
        for tickMark in stride(from: 3, to: hours, by: hourinterval) {
            print("\(tickMark)")
            // render the tick mark every 3 hours (3, 6, 9, 12)
        }
        
    }
    
    //MARK:--While循环
    /**
     while 循环会一直运行一段语句直到条件变成 false 。这类循环适合使用在第一次迭代前，迭代次数未知的情况
     下。Swift 提供两种 while 循环形式:
     • while循环，每次在循环开始时计算条件是否符合;
     • repeat-while循环，每次在循环结束时计算条件是否符合。
     */
    
    /// while 循环从计算一个条件开始。如果条件为 true ，会重复运行一段语句，直到条件变为 false 。
    func whileLoop() {
        
        var index = 0
        let max = 5
        
        while index < max {
            print("\(index)")
            index += 1
        }
        //while 循环比较适合在 while 循环开始时，我们并不知道循环需要执行多少次，只有在达成 指定条件时循环才会结束。
        
    }
    
    
    /// while 循环的另外一种形式是 repeat-while ，它和 while 的区别是在判断循环条件之前，先执行一次循环的代码 块。然后重复循环直到条件为 false 。
    func repeatWhileLoop() {
        
        let finalSquare = 25
        
        var square = 0
        var diceRoll = 0
        
        repeat {
            // 顺着梯子爬上去或者顺着蛇滑下去 square += board[square]
            // 掷骰子
            diceRoll += 1
            if diceRoll == 7 { diceRoll = 1 } // 根据点数移动
            square += diceRoll
        } while square < finalSquare
        
        /**
         循环条件( while square < finalSquare )和 while 方式相同，但是只会在循环结束后进行计算。在这个游戏 中， repeat-while 表现得比 while 循环更好。 repeat-while 方式会在条件判断 square 没有超出后直接运行 are += board[square] ，这种方式可以去掉 while 版本中的数组越界判断。
         */
    }
    
    //MARK:--条件语句
    func ifStatements() {
        
        var temperatureInFahrenheit = 30
        if temperatureInFahrenheit <= 32 {
            print("It's very cold. Consider wearing a scarf.")
            temperatureInFahrenheit += 1
        }
        
        temperatureInFahrenheit = 40
        if temperatureInFahrenheit <= 32 {
            print("It's very cold. Consider wearing a scarf.")
        } else {
            print("It's not that cold. Wear a t-shirt.")
        }
        
        temperatureInFahrenheit = 90
        if temperatureInFahrenheit <= 32 {
            print("It's very cold. Consider wearing a scarf.")
        } else if temperatureInFahrenheit >= 86 {
            print("It's really warm. Don't forget to wear sunscreen.")
        } else {
            print("It's not that cold. Wear a t-shirt.")
        }
        
        
        //实际上，当不需要完整判断情况的时候，最后的 else 语句是可选的:
        temperatureInFahrenheit = 72
        if temperatureInFahrenheit <= 32 {
            print("It's very cold. Consider wearing a scarf.")
        } else if temperatureInFahrenheit >= 86 {
            print("It's really warm. Don't forget to wear sunscreen.")
        }
        
    }
    
    func switchStatements() {
        
        let someCharacter: Character = "z"
        switch someCharacter {
        case "a":
            print("The first letter of the alphabet")
        case "z":
            print("The last letter of the alphabet")
        default:
            print("Some other character")
        }
        
        //不存在隐式的贯穿
        /*
         与 C 和 Objective-C 中的 switch 语句不同，在 Swift 中，当匹配的 case 分支中的代码执行完毕后，程序会 终止 switch 语句，而不会继续执行下一个 case 分支。这也就是说，不需要在 case 分支中显式地使用 break 语 句。这使得 switch 语句更安全、更易用，也避免了因忘记写 break 语句而产生的错误
         */
        
        let otherCharacter: Character = "a"
        switch otherCharacter {
//        case "a": // 无效，这个分支下面没有语句
        case "A":
            print("The letter A")
        default:
            print("Not the letter A")
        }
        // 这段代码会报编译错误
        //不像 C 语言里的 switch 语句，在 Swift 中， switch 语句不会一起匹配 "a" 和 "A" 。相反的，上面的代码会引 起编译期错误: case "a": 不包含任何可执行语句 ——这就避免了意外地从一个 case 分支贯穿到另外一个，使 得代码更安全、也更直观。

        //为了让单个case同时匹配 a 和 A ，可以将这个两个值组合成一个复合匹配，并且用逗号分开:
        let anotherCharacter: Character = "a"
        switch anotherCharacter {
        case "a", "A":
            print("The letter A")
        default:
            print("Not the letter A")
        }
        // 输出 "The letter A
        
        
        //区间匹配:case 分支的模式也可以是一个值的区间。下面的例子展示了如何使用区间匹配来输出任意数字对应的自然语言格 式:
        let approximateCount = Int(arc4random() % 1000)//1-1000的随机数
        let countedThings = "moons orbiting Saturn"
        var naturalCount: String
        switch approximateCount {
        case 0:
            naturalCount = "no"
        case 1..<5:
            naturalCount = "a few"
        case 5..<12:
            naturalCount = "several"
        case 12..<100:
            naturalCount = "dozens of"
        case 100..<1000:
            naturalCount = "hundreds of"
        default:
            naturalCount = "many"
        }
        print(approximateCount,"There are \(naturalCount) \(countedThings).")
        
    }

    
}

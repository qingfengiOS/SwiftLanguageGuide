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

        controlTransferStatement()
        
        labeledStatements()
        
        greet(person: ["name": "John"])
        greet(person: ["name": "Jane", "location": "Cupertino"])
        
        checkingAPIAvailability()

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
        
        
        //元组 区间匹配
        let somepoint = (1,1)
        switch somepoint {
        case (0, 0):
            print("\(somepoint) is at origin")
        case (_, 0):
            print("\(somepoint) is on the x-axis")
        case (0, _):
            print("\(somepoint) is on the y-axis")
        case(-2...2, -2...2):
            print("\(somepoint) is inside the box")
        default:
            print("\(somepoint) is outside the box")
        }
        
        //值绑定
        //case 分支允许将匹配的值绑定到一个临时的常量或变量，并且在case分支体内使用 —— 这种行为被称为值绑 定(value binding)，因为匹配的值在case分支体内，与临时的常量或变量绑定。
        let anotherPoint = (2, 0)
        switch anotherPoint {
        case (let x, 0):
            print("on the x-axis with an x value of \(x)")
        case (0, let y):
            print("on the y-axis with a y value of \(y)")
        case let (x, y):
            print("somewhere else at (\(x), \(y))")
        }
        
        
        //Where
        //case 分支的模式可以使用 where 语句来判断额外的条件。
        let yellowPoint = (1,-1)
        switch yellowPoint {
        case let (x, y) where x == y:
            print("(\(x), \(y)) is on the line x == y")
        case let (x, y) where x == -y:
            print("(\(x), \(y)) is on the line x == -y")
        case let (x, y):
            print("(\(x), \(y)) is just some arbitrary point")
        }
        
        //复合匹配
        //当多个条件可以使用同一种方法来处理时，可以将这几种可能放在同一个 case 后面，并且用逗号隔开。当case后 面的任意一种模式匹配的时候，这条分支就会被匹配。并且，如果匹配列表过长，还可以分行书写:
        let someCharacters: Character = "e"
        switch someCharacters {
        case "a", "e", "i", "o", "u":
            print("\(someCharacters) is a vowel")
        case "b", "c", "d", "f", "g", "h", "j", "k", "l", "m",
             "n", "p", "q", "r", "s", "t", "v", "w", "x", "y", "z":
            print("\(someCharacters) is a consonant")
        default:
            print("\(someCharacters) is not a vowel or a consonant")
        }
        
    }

    
    /// 控制转移语句
    func controlTransferStatement() {
        //Continue
        //continue 语句告诉一个循环体立刻停止本次循环，重新开始下次循环。就好像在说“本次循环我已经执行完 了”，但是并不会离开整个循环体。
        let puzzleInput = "greet minds think alike"
        var puzzleOutput = ""
        let charactersToRemove: [Character] = ["a", "e", "i", "o", "u", " "]
        for character in puzzleInput {
            if charactersToRemove.contains(character) {//如果字符需要被移除就不拼接到输出字符串
            continue
            } else {
                puzzleOutput.append(character)
            }
            print(puzzleOutput)
        }
        
        //break
        /*
        break 语句会立刻结束整个控制流的执行。当你想要更早的结束一个 switch 代码块或者一个循环体时，你都可以 使用 break 语句。
        
        Switch 语句中的 break
        当在一个 switch 代码块中使用 break 时，会立即中断该 switch 代码块的执行，并且跳转到表示 switch 代码块 结束的大括号( } )后的第一行代码。
        */
        
        let numberSymbol: Character = "三"//// Chinese symbol for the number 3
        var possibleIntegerValue: Int?
        switch numberSymbol {
        case "1", "١", "一", "๑":
            possibleIntegerValue = 1
        case "2", "٢", "二", "๒":
            possibleIntegerValue = 2
        case "3", "٣", "三", "๓":
            possibleIntegerValue = 3
        case "4", "٤", "四", "๔":
            possibleIntegerValue = 4
        default:
            break
        }
        if let integerValue = possibleIntegerValue {
            print("The integer value of \(numberSymbol) is \(integerValue).")
        } else {
            print("An integer value could not be found for \(numberSymbol).")
        }
        
        /*
         想要把 Character 所有的的可能性都枚举出来是不现实的，所以使用 default 分支来包含所有 上面没有匹配到字符的情况。由于这个 default 分支不需要执行任何动作，所以它只写了一条 break 语句。一旦 落入到 default 分支中后， break 语句就完成了该分支的所有代码操作，代码继续向下，开始执行 if let 语句。
         */
        
        
        //Fallthrough
        //Swift 中的 switch 不会从上一个 case 分支落入到下一个 case 分支中。相反，只要第一个匹配到的 case 分支 完成了它需要执行的语句，整个 switch 代码块完成了它的执行。相比之下，C 语言要求你显式地插入 break 语句 到每个 case 分支的末尾来阻止自动落入到下一个 case 分支中。Swift 的这种避免默认落入到下一个分支中的 特性意味着它的 switch 功能要比 C 语言的更加清晰和可预测，可以避免无意识地执行多个 case 分支从而引发 的错误。如果你确实需要 C 风格的贯穿的特性，你可以在每个需要该特性的 case 分支中使用 fallthrough 关键字
        
        let integerToDescribe = 5
        var description = "The number \(integerToDescribe) is"
        switch integerToDescribe {
        case 2, 3, 5, 7, 11, 13, 17, 19:
            description += " a prime number, and also"
            fallthrough
        default:
            description += " an integer."
        }
        print(description)
    }
    
    
    func labeledStatements() {
//        //带标签的语句
//        let finalSquare = 25
//        var board = [Int](repeating: 0, count: finalSquare + 1)
//        board[03] = +08; board[06] = +11; board[09] = +09; board[10] = +02
//        board[14] = -10; board[19] = -11; board[22] = -02; board[24] = -08
//        var square = 0
//        var diceRoll = 0
//
//        gameLoop: while square != finalSquare {
//            diceRoll += 1
//            if diceRoll == 7 { diceRoll = 1 }
//            switch square + diceRoll {
//            case finalSquare:
//                // 骰子数刚好使玩家移动到最终的方格里，游戏结束。
//                break gameLoop
//            case let newSquare where newSquare > finalSquare:
//                // 骰子数将会使玩家的移动超出最后的方格，那么这种移动是不合法的，玩家需要重新掷骰子
//                continue gameLoop
//            default:
//                // 合法移动，做正常的处理 square += diceRoll
//                square += board[square]
//            } }
//        print("Game over!")
    }
    
    //提前退出
    //像 if 语句一样， guard 的执行取决于一个表达式的布尔值。我们可以使用 guard 语句来要求条件必须为真 时，以执行 guard 语句后的代码。不同于 if 语句，一个 guard 语句总是有一个 else 从句，如果条件不为真则执 行 else 从句中的代码。
    func greet(person: [String: String]) {
        guard let name = person["name"] else {
            return
        }
        print("hello \(name)")
        
        guard let location = person["location"] else {
            print("I hope the weather is nice near you.")
            return
        }
        print("I hope the weather is nice in \(location).")
        
        /*
         如果 guard 语句的条件被满足，则继续执行 guard 语句大括号后的代码。将变量或者常量的可选绑定作为 语句的条件，都可以保护 guard 语句后面的代码。
         如果条件不被满足，在 else 分支上的代码就会被执行。这个分支必须转移控制以退出 guard 语句出现的代码 段。它可以用控制转移语句如 return , break , continue 或者 throw 做这件事，或者调用一个不返回的方法或函 数，例如 fatalError() 。
         相比于可以实现同样功能的 if 语句，按需使用 guard 语句会提升我们代码的可读性。它可以使你的代码连贯的 被执行而不需要将它包在 else 块中，它可以使你在紧邻条件判断的地方，处理违规的情况。

         */
        
    }
    
    
    /// 检测API的可用性
    func checkingAPIAvailability() {
        if #available(iOS 10, macOS 10.12, *) {
            // Use iOS 10 APIs on iOS, and use macOS 10.12 APIs on macOS
        } else {
            // Fall back to earlier iOS and macOS APIs
        }
    }
    
    
    
}

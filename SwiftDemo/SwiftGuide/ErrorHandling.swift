//
//  ErrorHandling.swift
//  SwiftDemo
//
//  Created by liyiping on 2018/5/21.
//  Copyright © 2018年 情风. All rights reserved.
//
/*
 错误处理(Error handling)是响应错误以及从错误中恢复的过程。Swift 提供了在运行时对可恢复错误的抛 出、捕获、传递和操作的支持。
 
 某些操作无法保证总是执行完所有代码或总是生成有用的结果。可选类型可用来表示值缺失，但是当某个操作失败时，最好能得知失败的原因，从而可以作出相应的应对。
 */

import UIKit

//MARK:--表示并抛出错误
enum VendingMachineError: Error {
    case invalidSelection//选择无效
    case insufficientFunds(coinsNeeded: Int) //金额不足
    case outOfStock//缺货
}

class ErrorHandling: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        convertingErrorsToOptionalValues()
        
        let x = try? someThrowingFunction()
        var y: Int?
        do {
            y = try someThrowingFunction()
        } catch  {
            y = nil
        }
        print("x = \(String(describing: x))  y = \(String(describing: y))")
        /*
         如果 someThrowingFunction() 抛出一个错误， x 和 y 的值是 nil 。否则 x 和 y 的值就是该函数的返回值。注 意，无论 someThrowingFunction() 的返回值类型是什么类型， x 和 y 都是这个类型的可选类型。例子中此函数返 回一个整型，所以 x 和 y 是可选整型。
         */
        
    }
    
    //抛出一个错误可以让你表明有意外情况发生，导致正常的执行流程无法继续执行。抛出错误使用 throw 关键 字。例如，下面的代码抛出一个错误，提示贩卖机还需要 5 个硬币:
    func throwSomething() throws -> String {
        throw VendingMachineError.insufficientFunds(coinsNeeded: 5)
    }
    
    //MARK:--用 throwing 函数传递错误
    /*为了表示一个函数、方法或构造器可以抛出错误，在函数声明的参数列表之后加上 throws 关键字。一个标有 throws 关键字的函数被称作throwing 函数。如果这个函数指明了返回值类型， throws 关键词需要写在箭头( - > )的前面。
    
    只有 throwing 函数可以传递错误。任何在某个非 throwing 函数内部抛出的错误只能在函数内部处理。
     */
    func canThrowError() throws  -> String {
        return "nil"
    }
    func cannotThrowErrors() -> String {
        return "nil"
    }

    //MARK:--用 Do-Catch 处理错误
    func convertingErrorsToOptionalValues() {
        let vendingMachine = VendingMachine()
        vendingMachine.coinsDeposited = 8
        
        do {
            try vendingMachine.buyFavoriteSnack(person: "Alice", vendingMachine: vendingMachine)
            print("Success! Yum.")
        } catch VendingMachineError.invalidSelection {
            print("Invalid Selection.")
        } catch VendingMachineError.outOfStock {
            print("Out of Stock.")
        } catch VendingMachineError.insufficientFunds(let coinsNeeded) {
            print("Insufficient funds. Please insert an additional \(coinsNeeded) coins.")
        } catch {
            print("Unexpected error: \(error).")
        }
        /*
         上面的例子中， buyFavoriteSnack(person:vendingMachine:) 函数在一个 try 表达式中调用，因为它能抛出错 误。如果错误被抛出，相应的执行会马上转移到 catch 子句中，并判断这个错误是否要被继续传递下去。如果没 有错误抛出， do 子句中余下的语句就会被执行
         */
    }
    
    //MARK:--将错误转换成可选值
    /*
     可以使用 try? 通过将错误转换成一个可选值来处理错误。如果在评估 try? 表达式时一个错误被抛出，那么表达 式的值就是 nil 。例如,在下面的代码中, x 和 y 有着相同的数值和等价的含义:
     */
    func someThrowingFunction() throws -> Int {
        return 0
    }
    
   /*
     如果你想对所有的错误都采用同样的方式来处理，用 try? 就可以让你写出简洁的错误处理代码。例如，下面的代 码用几种方式来获取数据，如果所有方式都失败了则返回 nil :
     */
    func fetchData() -> Data? {
        if let data = try? fetchDataFromDisk() { return Data() }
        if let data = try? fetchDataFromServer() { return Data() }
        return nil
    }
    
    func fetchDataFromDisk() throws {}
    func fetchDataFromServer() throws {}
    
    //MARK:--禁用错误传递
    /*
     有时你知道某个 throwing 函数实际上在运行时是不会抛出错误的，在这种情况下，你可以在表达式前面写 tr
     y! 来禁用错误传递，这会把调用包装在一个不会有错误抛出的运行时断言中。如果真的抛出了错误，你会得到一 个运行时错误。
     例如，下面的代码使用了 loadImage(atPath:) 函数，该函数从给定的路径加载图片资源，如果图片无法载入则抛 出一个错误。在这种情况下，因为图片是和应用绑定的，运行时不会有错误抛出，所以适合禁用错误传递:
     */
//     let photo = try! loadImage(atPath: "./Resources/John Appleseed.jpg")
    
    
    //MARK:--指定清理操作
    /*
     可以使用 defer 语句在即将离开当前代码块时执行一系列语句。该语句让你能执行一些必要的清理工作，不管是 以何种方式离开当前代码块的——无论是由于抛出错误而离开，还是由于诸如 return 或者 break 的语句。例 如，你可以用 defer 语句来确保文件描述符得以关闭，以及手动分配的内存得以释放。
     
     defer 语句将代码的执行延迟到当前的作用域退出之前。该语句由 defer 关键字和要被延迟执行的语句组成。延 迟执行的语句不能包含任何控制转移语句，例如 break 或是 return 语句，或是抛出一个错误。延迟执行的操作会 按照它们被指定时的顺序的相反顺序执行——也就是说，第一条 defer 语句中的代码会在第二条 defer 语句中的 代码被执行之后才执行，以此类推。
     */
    func processFile(fileName: String) throws {
//        if exit(fileName) {
//            let file = open(fileName)
//            defer {
//                close(file)
//            }
//
//            while let line = try file.readline() {
//                // 处理文件。
//            }
//            // close(file) 会在这里被调用，即作用域的最后。
//        }
        /*
         上面的代码使用一条 defer 语句来确保 open(_:) 函数有一个相应的对 close(_:) 函数的调用。
         */
    }
  
    
}


struct Item {
    var price: Int
    var count: Int
}

class VendingMachine {
    var inventory = [
        "Candy Bar" : Item(price: 12, count: 7),
        "Chips" : Item(price: 10, count: 4),
        "Pretzels": Item(price: 7, count: 11)
    ]
    
    var coinsDeposited = 0
    func dispenseSnack(snack: String) {
        print("Dispensing \(snack)")
    }
    
    func vend(itemNamed name: String) throws {
        guard let item = inventory[name] else {
            throw VendingMachineError.invalidSelection
        }
        
        guard item.count > 0 else {
            throw VendingMachineError.outOfStock
        }
        
        guard item.price <= coinsDeposited else {
            throw VendingMachineError.insufficientFunds(coinsNeeded: item.price - coinsDeposited)
        }
        
        coinsDeposited -= item.price
        
        var newItem = item
        newItem.count -= 1
        inventory[name] = newItem
        
        print("Dispensing \(name)")
        
    }
    /*
     在 vend(itemNamed:) 方法的实现中使用了 guard 语句来提前退出方法，确保在购买某个物品所需的条件中，有任意一条件不满足时，能提前退出方法并抛出相应的错误。由于 throw 语句会立即退出方法，所以物品只有在所有条件都满足时才会被售出。
     
     因为 vend(itemNamed:) 方法会传递出它抛出的任何错误，在你的代码中调用此方法的地方，必须要么直接处理这些错误——使用 do-catch 语句， try? 或 try! ;要么继续将这些错误传递下去。例如下面例子中， buyFavorite Snack(_:vendingMachine:) 同样是一个 throwing 函数，任何由 vend(itemNamed:) 方法抛出的错误会一直被传递 到 buyFavoriteSnack(person:vendingMachine:) 函数被调用的地方。
     */
    
    let favoriteSnacks = [
        "Alice": "Chips",
        "Bob": "Licorice",
        "Eve": "Pretzels"
    ]

    func buyFavoriteSnack(person: String, vendingMachine: VendingMachine) throws {
        let snackName = favoriteSnacks[person] ?? "Candy Bar"
        try vendingMachine.vend(itemNamed: snackName)
    }
    /*
     上例中， buyFavoriteSnack(person:vendingMachine:) 函数会查找某人最喜欢的零食，并通过调用 vend(itemName d:) 方法来尝试为他们购买。因为 vend(itemNamed:) 方法能抛出错误，所以在调用的它时候在它前面加了 try 关 键字。
     */
}

/*
 throwing 构造器能像 throwing 函数一样传递错误.例如下面代码中的 PurchasedSnack 构造器在构造过程中调用 了throwing函数,并且通过传递到它的调用者来处理这些错误。
 */
struct PurchaseSnack {
    let name: String
    init(name: String, vendingMachine:VendingMachine) throws {
        try vendingMachine.vend(itemNamed: name)
        self.name = name
    }
}












//
//  Enumerations.swift
//  SwiftDemo
//
//  Created by liyiping on 2018/5/3.
//  Copyright © 2018年 情风. All rights reserved.
//

import UIKit

/*
 枚举为一组相关的值定义了一个共同的类型，使你可以在你的代码中以类型安全的方式来使用这些值。
 如果你熟悉 C 语言，你会知道在 C 语言中，枚举会为一组整型值分配相关联的名称。Swift 中的枚举更加灵 活，不必给每一个枚举成员提供一个值。如果给枚举成员提供一个值(称为“原始”值)，则该值的类型可以是 字符串，字符，或是一个整型值或浮点数。
 */

enum CompassPoint {
    case north
    case south
    case east
    case west
    /*
     与 C 和 Objective-C 不同，Swift 的枚举成员在被创建时不会被赋予一个默认的整型值。在上面的CompassPoint例子中， north ， south ， east 和 west 不会被隐式地赋值为 0 ， 1 ， 2 和 3 。相反，这些枚举成员本身 就是完备的值，这些值的类型是已经明确定义好的 CompassPoint 类型。
     */
}

//多个成员值可以出现在同一行上，用逗号隔开
enum Planet {
    case mercury, venus, earth, mars, jupiter,saturn, uranus, neptune
}

//每个枚举定义了一个全新的类型。像 Swift 中其他类型一样，它们的名字(例如 CompassPoint 和 Planet )应该 以一个大写字母开头。给枚举类型起一个单数名字而不是复数名字，以便于读起来更加容易理解:

enum Barcode {
    case upc(Int, Int, Int, Int)
    case qrCode(String)
    /*
     “定义一个名为 Barcode 的枚举类型，它的一个成员值是具有 (Int，Int，Int，Int) 类型关联值的 upc ，另一个 成员值是具有 String 类型关联值的 qrCode 。”
     
     这个定义不提供任何 Int 或 String 类型的关联值，它只是定义了，当 Barcode 常量和变量等于 Barcode.upc 或 B arcode.qrCode 时，可以存储的关联值的类型。
     */
}


//这是一个使用 ASCII 码作为原始值的枚举:
enum ASCIIControlCharacter: Character {
    case tab = "\t"
    case lineFeed = "\n"
    case carriageReturn = "\r"
    /*
     原始值可以是字符串，字符，或者任意整型值或浮点型值。每个原始值在枚举声明中必须是唯一的。
     */
}

//原始值的隐式赋值
/*
 在使用原始值为整数或者字符串类型的枚举时，不需要显式地为每一个枚举成员设置原始值，Swift 将会自动为 你赋值。
 例如，当使用整数作为原始值时，隐式赋值的值依次递增 1 。如果第一个枚举成员没有设置原始值，其原始值将 为0。
 下面的枚举是对之前 Planet 这个枚举的一个细化，利用整型的原始值来表示每个行星在太阳系中的顺序
 */
enum ThePlanet: Int {
    case mercury = 1, venus, earth, mars, jupiter, saturn, uranus, neptune
    /*
     在上面的例子中， Plant.mercury 的显式原始值为 1 ， Planet.venus 的隐式原始值为 2 ，依次类推。
     
     */
}


enum TheCompassPoint: String {
    case north, south, east, west
    /*
     当使用字符串作为枚举类型的原始值时，每个枚举成员的隐式原始值为该枚举成员的名称。
     
     上面例子中， CompassPoint.south 拥有隐式原始值 south ，依次类推。
     */
}


/*
 递归枚举是一种枚举类型，它有一个或多个枚举成员使用该枚举类型的实例作为关联值。
 使用递归枚举时，编译器会插入一个间接层。你可以在枚举成员前加上 indirect 来表示该成员可递归。
 
 例如，下面的例子中，枚举类型存储了简单的算术表达式:
 */
enum ArithmeticExpression {
    case number (Int)
    indirect case addition(ArithmeticExpression,ArithmeticExpression)
    indirect case multiplication(ArithmeticExpression,ArithmeticExpression)
}

//你也可以在枚举类型开头加上 indirect 关键字来表明它的所有成员都是可递归的:
indirect enum RecursiveArithmeticExpression {
    case number (Int)
    case addition(RecursiveArithmeticExpression,RecursiveArithmeticExpression)
    case multiplication(RecursiveArithmeticExpression,RecursiveArithmeticExpression)
}

class Enumerations: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white

        var directionToHead = CompassPoint.west //directionToHead 的类型可以在它被 CompassPoint 的某个值初始化时推断出来。一旦 directionToHead 被声明为 CompassPoint 类型，你可以使用更简短的点语法将其设置为另一个 CompassPoint 的值:
        directionToHead = .east //当 directionToHead 的类型已知时，再次为其赋值可以省略枚举类型名。在使用具有显式类型的枚举值时，这种 写法让代码具有更好的可读性。
        print(directionToHead)
        
        
        matchingEnumerationValuesWithSwitchStatement()
        associatedValues()
        raValues()
        initializingFromRawValue()
        recursiveEnumerations()
        
        
    }

    //MARK:--使用 Switch 语句匹配枚举值
    func matchingEnumerationValuesWithSwitchStatement() {
        let directionToHead = CompassPoint.west
        switch directionToHead {
        case .north:
            print("Lots of planets have a north")
        case .south:
            print("Watch out for penguins")
        case .east:
            print("Where the sun rises")
        case .west:
            print("Where the skies are blue")
        }
        
        //当不需要匹配每个枚举成员的时候，你可以提供一个 default 分支来涵盖所有未明确处理的枚举成员:
        let somePlanet = Planet.earth
        switch somePlanet {
        case .earth:
            print("Mostly harmless")
        default:
            print("Not a safe place for humans")
        }
    }

    
    
    //MARK:--关联值
    func associatedValues() {
        /*
         可以定义 Swift 枚举来存储任意类型的关联值，如果需要的话，每个枚举成员的关联值类型可以各不相同。枚 举的这种特性跟其他语言中的可识别联合(discriminated unions)，标签联合(tagged unions)，或者变 体(variants)相似。
         */
        var productBarCode = Barcode.upc(8, 8670, 51226, 3)
        productBarCode = .qrCode("ABCDEFGHIJKLMNOP")
        
        switch productBarCode {
            
        case .upc(let numberSystem, let manufacturer, let product, let check):
          print("UPC : \(numberSystem),\(manufacturer),\(product),\(check)")
            
        case .qrCode(let productCode):
            print("QR code: \(productCode).")
        }
    }
    
    //MARK:--原始值
    func raValues() {
        //在associatedValues方法的条形码例子中，演示了如何声明存储不同类型关联值的枚举成员。作为关联值的替代选 择，枚举成员可以被默认值(称为原始值)预填充，这些原始值的类型必须相同。
        let earthOrder = ThePlanet.earth.rawValue
        print(earthOrder)
        
        let someDirection = TheCompassPoint.west.rawValue
        print(someDirection)
    }
    
    //MARK:--使用原始值初始化枚举实例
    func initializingFromRawValue() {
        let possiblePlanet = ThePlanet(rawValue: 7)
        print(possiblePlanet ?? ThePlanet.self)
        /*
         然而，并非所有 Int 值都可以找到一个匹配的行星。因此，原始值构造器总是返回一个可选的枚举成员。在上面 的例子中， possiblePlanet 是 ThePlanet? 类型，或者说“可选的 ThePlanet ”。
         */
        
        let positionToFind = 11
        if let somePlanet = ThePlanet(rawValue: positionToFind) {
            switch somePlanet {
            case .earth:
                print("Mostly harmless")
            default:
                print("Not a safe place for humans")
            }
        } else {
            print("There isn't a planet at position \(positionToFind)")
        }
        
        
        /*
         结果："There isn't a planet at position 11
         
         这个例子使用了可选绑定(optional binding)，试图通过原始值 11 来访问一个行星。
         anet(rawValue: 11) 语句创建了一个可选 Planet ，如果可选 Planet 的值存在，就会赋值给 somePlanet 。在这个 例子中，无法检索到位置为 11 的行星，所以 else 分支被执行。
         */
    }
    
    //MARK:--递归枚举
    func recursiveEnumerations() {
        let five = RecursiveArithmeticExpression.number(5)
        let six = RecursiveArithmeticExpression.number(6)
        
        let sum = RecursiveArithmeticExpression.addition(five,six)
        let product = RecursiveArithmeticExpression.multiplication(sum, RecursiveArithmeticExpression.number(2))
        
        print("sum = \(sum),product = \(product)")
        
        print(evaluate(product))
    }
    
     //要操作具有递归性质的数据结构，使用递归函数是一种直截了当的方式。例如，下面是一个对算术表达式求值的函数:
    func evaluate(_ expression:RecursiveArithmeticExpression) -> Int {
        
        switch expression {
        case let .number(value):
            return value
        case let .addition(left, right):
            return evaluate(left) + evaluate(right)
        case let .multiplication(left, right):
            return evaluate(left) * evaluate(right)
        }
    
    }


}

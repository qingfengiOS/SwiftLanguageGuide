//
//  NestedTypes.swift
//  SwiftDemo
//
//  Created by 李一平 on 2018/5/24.
//  Copyright © 2018年 情风. All rights reserved.
//
/*
 枚举常被用于为特定类或结构体实现某些功能。类似的，枚举可以方便的定义工具类或结构体，从而为某个复杂 的类型所使用。为了实现这种功能，Swift 允许你定义嵌套类型，可以在支持的类型中定义嵌套的枚举、类和结 构体。
 
 要在一个类型中嵌套另一个类型，将嵌套类型的定义写在其外部类型的 {} 内，而且可以根据需要定义多级嵌套
 */
import UIKit

//MARK:-嵌套类型实践
struct BlackjackCard {
    
    enum Suit: Character {// 嵌套的 Suit 枚举
        case spades = "♠", hearts = "♡", diamonds = "♢", clubs = "♣"
    }
    
    enum Rank: Int {
        case two = 2, three, four, five, six, seven, eight, nine, ten
        case jack, queen, king, ace
        struct Values {
            let first: Int, second: Int?
        }
        var values: Values {
            switch self {
            case .ace:
                return Values(first: 1, second: 11)
            case .jack, .queen, .king:
                return Values(first: 10, second: nil)
            default:
                return Values(first: self.rawValue, second: nil)
            }
        }
    }
    
    // BlackjackCard properties and methods
    let rank: Rank, suit: Suit
    var description: String {
        var output = "suit is \(suit.rawValue),"
        output += " value is \(rank.values.first)"
        if let second = rank.values.second {
            output += " or \(second)"
        }
        return output
    }
}

class NestedTypes: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        let theAceOfSpades = BlackjackCard(rank: .ace, suit: .spades)
        print("theAceOfSpades: \(theAceOfSpades.description)")
        // Prints "theAceOfSpades: suit is ♠, value is 1 or 11"
    }
}

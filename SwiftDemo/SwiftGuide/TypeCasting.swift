//
//  TypeCasting.swift
//  SwiftDemo
//
//  Created by liyiping on 2018/5/23.
//  Copyright © 2018年 情风. All rights reserved.
//
/*
 类型转换 可以判断实例的类型，也可以将实例看做是其父类或者子类的实例。
 
 类型转换在 Swift 中使用 is 和 as 操作符实现。这两个操作符提供了一种简单达意的方式去检查值的类型 或者转换它的类型。
 */
import UIKit

//MARK:-定义一个类层次作为例子
class MediaItem {
    var name: String
    init(name: String) {
        self.name = name
    }
}

class Movie: MediaItem {
    var director: String
    init(name: String, director: String) {
        self.director = director
        super.init(name: name)
    }
}

class Song: MediaItem {
    var artist: String
    init(name: String, artist: String) {
        self.artist = artist
        super.init(name: name)
    }
}



class TypeCasting: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        let result = definingAClassHierarchyForTypeCasting()
        print(result)
        
        checkingType()
        
        downcasting()
    
        typeCastingForAnyAndAnyObject()
    }

    //Defining a Class Hierarchy for Type Casting
    func definingAClassHierarchyForTypeCasting() -> Array<Any> {
        
        let library = [
            Movie(name: "Casablanca", director: "Michael Curtiz"),
            Song(name: "Blue Suede Shoes", artist: "Elvis Presley"),
            Movie(name: "Citizen Kane", director: "Orson Welles"),
            Song(name: "The One And Only", artist: "Chesney Hawkes"),
            Song(name: "Never Gonna Give You Up", artist: "Rick Astley")
        ] // 数组 library 的类型被推断为 [MediaItem]

        return library
    }
    
    //MARK:-检查类型
    func checkingType() {
        let library = definingAClassHierarchyForTypeCasting()
        var movieCount = 0
        var songCount = 0
        for item in library {
            if item is Movie {
                movieCount += 1
            } else if item is Song {
                songCount += 1
            } else {
                
            }
        }
        print("movieCunt = \(movieCount),songCount = \(songCount)")
    }
    
    //MARK:-向下转型
    /*
     某类型的一个常量或变量可能在幕后实际上属于一个子类。当确定是这种情况时，你可以尝试向下转到它的子类型，用类型转换操作符(as? 或 as!)。
     
     因为向下转型可能会失败，类型转型操作符带有两种不同形式。条件形式as? 返回一个你试图向下转成的类型的可选值。强制形式 as! 把试图向下转型和强制解包(转换结果结合为一个操作。 当你不确定向下转型可以成功时，用类型转换的条件形式( as? )。条件形式的类型转换总是返回一个可选值，并且若下转是不可能的，可选值将是 nil 。这使你能够检查向下转型是否成功。
     
     只有你可以确定向下转型一定会成功时，才使用强制形式( as! )。当你试图向下转型为一个不正确的类型时，强制形式的类型转换会触发一个运行时错误。
     */
    
    func downcasting() {
        let library = definingAClassHierarchyForTypeCasting()
        for item in library {
            if let movie = item as? Movie {
                print("Movie: \(movie.name), dir. \(movie.director)")
            } else if let song = item as? Song {
                print("Song: \(song.name), by \(song.artist)")
            } else {
                
            }
        }
        /*
         当向下转型为 Movie 应用在两个 Song 实例时将会失败。为了处理这种情况，上面的例子使用了可选绑定(op tional binding)来检查可选 Movie 真的包含一个值(这个是为了判断下转是否成功。)可选绑定是这样写 的“ if let movie = item as? Movie ”，可以这样解读:
         “尝试将 item 转为 Movie 类型。若成功，设置一个新的临时常量 movie 来存储返回的可选 Movie 中的 值”
         
         转换没有真的改变实例或它的值。根本的实例保持不变;只是简单地把它作为它被转换成的类型来使用。
         */
    }
    
    //MARK:-Any 和 AnyObject 的类型转换
    /*
     Swift 为不确定类型提供了两种特殊的类型别名:
     • Any 可以表示任何类型，包括函数类型。
     • AnyObject 可以表示任何类类型的实例。
     只有当你确实需要它们的行为和功能时才使用 Any 和 AnyObject 。在你的代码里使用你期望的明确类型总是更 好的。
     */
    func typeCastingForAnyAndAnyObject() {
        var things = [Any]()
        
        things.append(0)
        things.append(0.0)
        things.append(42)
        things.append(3.14159)
        things.append(-20.0)
        things.append("hello")
        things.append((3.0, 5.0))
        things.append(Movie(name: "Ghostbusters", director: "Ivan Reitman"))
        things.append({(name: String) -> String in "Hello, \(name)"})
        
        for thing in things {
            switch thing {
            case 0 as Int:
                print("zero as an Int")
            case 0 as Double:
                print("zero as a Double")
            case let someInt as Int:
                print("an integer value of \(someInt)")
            case let someDouble as Double where someDouble > 0:
                print("a positive double value of \(someDouble)")
            case is Double:
                print("some other double value that I don't want to print")
            case let someString as String:
                print("a string value of \"\(someString)\"")
            case let (x, y) as (Double, Double):
                print("an (x, y) point at \(x), \(y)")
            case let movie as Movie:
                print("a movie called \(movie.name), dir. \(movie.director)")
            case let stringConverter as (String) -> String:
                print(stringConverter("Michael"))
            default:
                print("something else")
            }
            
        }
        /*
         things 数组包含两个 Int 值，三个 Double 值，一个 String 值，一个元组 (Double, Double) ，一个 Movie 实例“Ghostbusters”，以及一个接受 String 值并返回另一个 String 值的闭包表达式。
         你可以在 switch 表达式的 case 中使用 is 和 as 操作符来找出只知道是 Any 或 AnyObject 类型的 常量或变量的具体类型。下面的示例迭代 things 数组中的每一项，并用 switch 语句查找每一项的类型。有 几个 switch 语句的 case 绑定它们匹配到的值到一个指定类型的常量
         */
        
        //Any 类型可以表示所有类型的值，包括可选类型。Swift 会在你用 Any 类型来表示一个可选值的时候，给你一个警告。如果你确实想使用 Any 类型来承载可选值，你可以使用 as 操作符显示转换为 Any ，如下所示
        var optionNumber: Int?
        things.append(optionNumber)//// 警告
        print(things.last!)
        
        optionNumber = 20
        things.append(optionNumber as Any)//无警告
        print(things.last!)
    }
    
}




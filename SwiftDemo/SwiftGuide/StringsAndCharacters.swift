//
//  StringsAndCharacters.swift
//  SwiftDemo
//
//  Created by liyiping on 2018/4/21.
//  Copyright © 2018年 情风. All rights reserved.
//

import UIKit

class StringsAndCharacters: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.white
        
        stringLiterals()
        specialCharactersInStringLiterals()
        initializingAnEmptyString()
        stringMutability()
        stringsAreValueTypes()
        workingWithCharacters()
        concatenatingStringsAndCharacters()
        stringInterpolation()
    }

    
    /// 字面量
    func stringLiterals() {
        let someString = "Some string literal value"//注意 someString 常量通过字符串字面量进行初始化，Swift 会推断该常量为 String 类型。
        print(someString)
        
        //多行的字符串 前后使用三个"即可
        let multilineString = """
        The White Rabbit put on his spectacles.  "Where shall I begin,
        please your Majesty?" he asked.
        "Begin at the beginning," the King said gravely, "and go on
        till you come to the end; then stop."
        """
        
        print(multilineString)
    }
    
    
    /// 特殊字符
    func specialCharactersInStringLiterals() {
        /**
         The escaped special characters \0 (null character), \\ (backslash), \t (horizontal tab), \n (line feed), \r (carriage return), \" (double quotation mark) and \' (single quotation mark)
         An arbitrary Unicode scalar, written as \u{n}, where n is a 1–8 digit hexadecimal number with a value equal to a valid Unicode code point (Unicode is discussed in Unicode below)
         */
        let wiseWords = "\"Imagination is more important than knowledge\" - Einstein"
        // "Imagination is more important than knowledge" - Einstein
        let dollarSign = "\u{24}"        // $,  Unicode scalar U+0024
        let blackHeart = "\u{2665}"      // ♥,  Unicode scalar U+2665
        let sparklingHeart = "\u{1F496}" // 💖, Unicode scalar U+1F496
        
        print(wiseWords,dollarSign,blackHeart,sparklingHeart)
    }

    
    /// 初始化一个空的字符串
    func initializingAnEmptyString() {
    
        let emptyString = ""//字面量初始化
        let otherEmptyString = String()//初始化方法
        print(emptyString,otherEmptyString)
        
        if emptyString.isEmpty {//通过isEmpty属性来判断是否为空
            print("emptyString 是空的字符串")
        }
    }
    
    
    /// 字符串可变性
    func stringMutability() {
        var variableString = "Horse"
        variableString += "and carrifage"
        
//        let constantString = "Highlander"
//        constantString += " and another Highlander"// 这会报告一个编译错误 (compile-time error) - 常量字符串不可以被修改。

        print(variableString)
        
    }
    
    
    /// 特别注意字符串在Swift中 是值类型，不是引用类型
    func stringsAreValueTypes() {
        /**
         Swift 的 String 类型是值类型。 如果您创建了一个新的字符串，那么当其进行常量、变量赋值操作，或在函数/ 方法中传递时，会进行值拷贝。 任何情况下，都会对已有字符串值创建新副本，并对该新副本进行传递或赋值操 作。
         */
        let originString = "origin"
        
        var changeString = originString;
        changeString += " string has been changed!"
        
        print(originString,changeString)
    }
    
    
    /// 使用字符串
    func workingWithCharacters() {
        for charater in "dog!🐶" {
            print(charater)
        }
        
        //字符串可以通过一个字符数组来创建
        let catCharacters: [Character] = ["C","a","t","?"]
        let catString = String(catCharacters)
        print(catCharacters,catString)
        
    }
    
    /// 连接字符串和字符
    func concatenatingStringsAndCharacters() {
        let string1 = "hello"
        let string2 = "there"
        
        var welcome = string1 + string2//直接拼接
        print(welcome)
        
        var instruction = "look over"
        instruction += string2//使用“+=”
        
        let exclamationMark: Character = "!"
        welcome.append(exclamationMark)
        /*
         不能将一个字符串或者字符添加到一个已经存在的字符变量上，因为字符变量只能包含一个字符。
         */
        
        print(welcome,instruction,welcome)
        
        //If you’re using multiline string literals to build up the lines of a longer string, you want every line in the string to end with a line break, including the last line.
        let badStart = """
        one
        two
        """
        
        let end = """
        three
        """
        print(badStart + end)
        print("-----------------------")
        
        let goodStart = """
        one
        two

        """
        print(goodStart + end)
        /*
         在上面的代码中,连接badStart与最终产生一个两行字符串,这并不是期望的结果。因为badStart的最后一行不以换行符结束,这条线会结合的第一行。相比之下,两行goodStart以换行符结束,所以当它结合最终结果三行,如预期。
         */
    }
    
    
    /// 字符串插入
    func stringInterpolation() {
        /*
         字符串插值是一种构建新字符串的方式，可以在其中包含常量、变量、字面量和表达式。 您插入的字符串字面量 的每一项都在以反斜线为前缀的圆括号中
         */
        let multiplier = 3
        let message = "\(multiplier) times 2.5 is \(Double(multiplier) * 2.5)"
        print(message)
        
        /*
         Unicode:
         Unicode是一个国际标准，用于文本的编码和表示。 它使您可以用标准格式表示来自任意语言几乎所有的字 符，并能够对文本文件或网页这样的外部资源中的字符进行读写操作。 Swift 的 String 和 Character 类型是完 全兼容 Unicode 标准的。

         Unicode 标量:
         Swift 的 String 类型是基于 Unicode 标量 建立的。 Unicode 标量是对应字符或者修饰符的唯一的21位数 字，例如 U+0061 表示小写的拉丁字母( LATIN SMALL LETTER A )(" a ")， U+1F425 表示小鸡表情(
         ABY CHICK ) (" ? ")
         
         注意不是所有的21位 Unicode 标量都代表一个字符，因为有一些标量是留作未来分配的。已经代表一个典型字符 的标量都有自己的名字，例如上面例子中的 LATIN SMALL LETTER A 和 FRONT-FACING BABY CHICK 。
         */
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}

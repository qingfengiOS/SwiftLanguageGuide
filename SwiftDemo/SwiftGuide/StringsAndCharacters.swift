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
    
    
}

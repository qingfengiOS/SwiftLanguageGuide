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
        countingCharater()
        accessingAndModifyingString()
        insertAndDelete()
        compareString()
        unicodeRepresentationsOfStrings()
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
    
    
    /// 计算字符数量
    func countingCharater() {
        let unusualMenagerie = "Koala ？，Snail ?, Penguin ?, Dromedry?"
        print("unusualMenagerie has \(unusualMenagerie.characters.count) characters")
        
        /*
         注意在 Swift 中，使用可拓展的字符群 作为   值来连接或改变字符串时，并不一定会更改字符串的字 符数量。
         例如，如果你用四个字符的单词   初始化一个新的字符串，然后添加一个
         1 )作为字符串的结尾。最终这个字符串的字符数量仍然是4，因为第四个字符是é，而不是e
         */
        var word = "cafe"
        print("the number of characters in \(word) is \(word.characters.count)") // 打印输出 "the number of characters in cafe is 4"
        let s = "\u{301}"
        word += s    // COMBINING ACUTE ACCENT, U+0301
        print("the number of characters in \(word) is \(word.characters.count)") // 打印输出 "the number of characters in café is 4"
    }
    
    
    /// 访问和修改字符串
    func accessingAndModifyingString() {
        let greeting = "Guten Tag!"
        let a = greeting[greeting.startIndex]
        let b = greeting[greeting.index(before: greeting.endIndex)]
        let c = greeting[greeting.index(after:greeting.startIndex)]
        let d = greeting[greeting.index(greeting.startIndex, offsetBy: 7)]
        
        print(a,b,c,d)
        
//        greeting[greeting.index(greeting.startIndex, offsetBy: 10)]//下标越界
//        greeting[greeting.endIndex] // error
//        greeting.index(after:greeting.endIndex) // error
        
        /*
         使用 characters 属性的 indices 属性会创建一个包含全部索引的范围(Range)，用来在一个字符串中访问单个字符
         */
        for index in greeting.characters.indices{
            print("\(greeting[index]) ", terminator: "")
        }
        
    }
    
    func insertAndDelete() {
        var welcome = "hello"
        print("......................................")
        welcome.insert("!", at: welcome.endIndex)
        print(welcome)
        welcome.insert(contentsOf: " world", at: welcome.index(before: welcome.endIndex))
        print(welcome)
        welcome.remove(at: welcome.index(before: welcome.endIndex))//单个删除
        print(welcome)
        
        let range = welcome.index(welcome.endIndex, offsetBy: -6)..<welcome.endIndex
        welcome.removeSubrange(range)
        print(welcome)
    }
    
    func compareString() {
        /*
         Swift 提供了三种方式来比较文本值:字符串字符相等、前缀相等和后缀相等。
         */
        //字符串/字符可以用等于操作符( == )和不等于操作符( != )
        let quotation = "We're a lot alike, you and I"
        let sameQuotation = "We're a lot alike, you and I"
        if quotation == sameQuotation {
            print("These two strings are considered equal")
        }
     
        /*
         如果两个字符串(或者两个字符)的可扩展的字形群 是标准相等的，那就认为它们是相等的。在这个情况 下，即使可扩展的字形群 是有不同的 Unicode 标量构成的，只要它们有同样的语言意义和外观，就认为它们标 准相等。
         例如， LATIN SMALL LETTER E WITH ACUTE ( U+00E9 )就是标准相等于 LATIN SMALL LETTER E ( U+0065 )后面加上 C OMBINING ACUTE ACCENT ( U+0301 )。这两个字符群 都是表示字符 é 的有效方式，所以它们被认为是标准相等 的:
         */
        
        // "Voulez-vous un café?" 使用 LATIN SMALL LETTER E WITH ACUTE
        let eAcuteQuestion = "Voulez-vous un caf\u{E9}?"
        // "Voulez-vous un café?" 使用 LATIN SMALL LETTER E and COMBINING ACUTE ACCENT
        let combinedEAcuteQuestion = "Voulez-vous un caf\u{65}\u{301}?"
        if eAcuteQuestion == combinedEAcuteQuestion {
            print("These two strings are considered equal")
        }
        
        
        /*
         相反，英语中的 LATIN CAPITAL LETTER A ( U+0041 ，或者 A )不等于俄语中的 CYRILLIC CAPITAL LETTER A ( 0 ，或者 A )。两个字符看着是一样的，但却有不同的语言意义:
         */
        let lationCapitalLetterA: Character = "\u{41}"
        
        let cyrillicCapitalLetterA: Character = "\u{0410}"
        
        if lationCapitalLetterA == cyrillicCapitalLetterA {
            print("These two characters are equivalent")
        } else {
            print("These two characters are not equivalent")
        }
        /*
         注意:
         在 Swift 中，字符串和字符并不区分地域(not locale-sensitive)。
         */
        
        //前缀/后缀相等
        
        //通过调用字符串的 hasPrefix(_:) / hasSuffix(_:) 方法来检查字符串是否拥有特定前缀/后缀，两个方法均接收一 个 String 类型的参数，并返回一个布尔值
        let romeoAndJuliet = [
            "Act 1 Scene 1: Verona, A public place",
            "Act 1 Scene 2: Capulet's mansion",
            "Act 1 Scene 3: A room in Capulet's mansion",
            "Act 1 Scene 4: A street outside Capulet's mansion",
            "Act 1 Scene 5: The Great Hall in Capulet's mansion",
            "Act 2 Scene 1: Outside Capulet's mansion",
            "Act 2 Scene 2: Capulet's orchard",
            "Act 2 Scene 3: Outside Friar Lawrence's cell",
            "Act 2 Scene 4: A street in Verona",
            "Act 2 Scene 5: Capulet's mansion",
            "Act 2 Scene 6: Friar Lawrence's cell"
        ]
        
        var act1Scene = 0
        var mansionCount = 0
        var cellCount = 0
        for scene in romeoAndJuliet {
            if scene.hasPrefix("Act 1") {
                act1Scene += 1
            }
            
            if scene.hasSuffix("Capulet's mansion") {
                mansionCount += 1
            } else if scene.hasSuffix("Friar Lawrence's cell") {
                cellCount += 1
            }
        }
        print(act1Scene,mansionCount,cellCount)
        /*
         注意:
         hasPrefix(_:) 和 hasSuffix(_:) 方法都是在每个字符串中逐字符比较其可扩展的字符群 是否标准相等
         */
    }
    
    /// 字符串的 Unicode 表示形式
    func unicodeRepresentationsOfStrings() {
        /**
         当一个 Unicode 字符串被写进文本文件或者其他储存时，字符串中的 Unicode 标量会用 Unicode 定义的几种 编码格式 (encoding forms)编码。每一个字符串中的小块编码都被称 代码单元 (code units)。这些包括 UT
         F-8 编码格式(编码字符串为8位的代码单元)， UTF-16 编码格式(编码字符串位16位的代码单元)，以及 UT F-32 编码格式(编码字符串32位的代码单元)。
         Swift 提供了几种不同的方式来访问字符串的 Unicode 表示形式。 您可以利用 for-in 来对字符串进行遍历，从 而以 Unicode 可扩展的字符群 的方式访问每一个 Character 值。
         */
        let dogString = "Dog‼🐶"
        
        for codeUnit in dogString.utf8 {
            print("\(codeUnit) ", terminator: "")
        }
        print("")
        // 68 111 103 226 128 188 240 159 144 182
        /*
         前三个10进制 codeUnit 值 ( 68 , 111 , 103 ) 代表了字符 D 、 o 和 g ，它们的 UTF-8 表示 与 ASCII 表示相同。 接下来的三个10进制 codeUnit 值 ( 226 , 128 , 188 ) 是 DOUBLE EXCLAMATION MARK 的3 字节 UTF-8 表示。 最后的四个 codeUnit 值 ( 240 , 159 , 144 , 182 ) 是 DOG FACE 的4字节 UTF-8 表示。
         */
        for codeUnit in dogString.utf16 {
            print("\(codeUnit) ", terminator: "")
        }
        print("")
        // 68 111 103 8252 55357 56374
        /*
         同样，前三个 codeUnit 值 ( 68 , 111 , 103 ) 代表了字符 D 、 o 和 g ，它们的 UTF-16 代码单元和 UTF-8 完全相同(因为这些 Unicode 标量表示 ASCII 字符)。
         第四个 codeUnit 值 ( 8252 ) 是一个等于十六进制 203C 的的十进制值。这个代表了 DOUBLE EXCLAMATION MARK 字 符的 Unicode 标量值 U+203C 。这个字符在 UTF-16 中可以用一个代码单元表示。
         第五和第六个 codeUnit 值 ( 55357 和 56374 ) 是 DOG FACE 字符的 UTF-16 表示。 第一个值为 U+D83D (十进制 值为 55357 )，第二个值为 U+DC36 (十进制值为 56374 )。
         */
        for scalar in dogString.unicodeScalars {
            print("\(scalar.value) ", terminator: "")
        }
        print("")
        // 68 111 103 8252 128054
        /*
         前三个 UnicodeScalar 值( 68 , 111 , 103 )的 value 属性仍然代表字符 D 、 o 和 g 。 第四个 codeUnit 值( 82 52 )仍然是一个等于十六进制 203C 的十进制值。这个代表了 DOUBLE EXCLAMATION MARK 字符的 Unicode 标量 U+2 03C 。
         第五个 UnicodeScalar 值的 value 属性， 128054 ，是一个十六进制 1F436 的十进制表示。其等同于 DOG FACE 的 Unicode 标量 U+1F436 。
         */
        
        /*
         作为查询它们的 value 属性的一种替代方法，每个 UnicodeScalar 值也可以用来构建一个新的 String 值，比如在 字符串插值中使用:
         */
        for scalar in dogString.unicodeScalars {
            print("\(scalar) ")
        }
        
        
    }
    
    
    
}

//
//  AdvancedOperators.swift
//  SwiftDemo
//
//  Created by liyiping on 2018/6/6.
//  Copyright © 2018年 情风. All rights reserved.
//
/*
 除了在之前介绍过的基本运算符，Swift 中还有许多可以对数值进行复杂运算的高级运算符。这些高级运算符包含了在 C 和 Objective-C 中已经被大家所熟知的位运算符和移位运算符。
 
 与 C 语言中的算术运算符不同，Swift 中的算术运算符默认是不会溢出的。所有溢出行为都会被捕获并报告为错误。如果想让系统允许溢出行为，可以选择使用 Swift 中另一套默认支持溢出的运算符，比如溢出加法运算符（&+）。所有的这些溢出运算符都是以 & 开头的。
 
 自定义结构体、类和枚举时，如果也为它们提供标准 Swift 运算符的实现，将会非常有用。在 Swift 中自定义运算符非常简单，运算符也会针对不同类型使用对应实现。
 
 我们不用被预定义的运算符所限制。在 Swift 中可以自由地定义中缀、前缀、后缀和赋值运算符，以及相应的优先级与结合性。这些运算符在代码中可以像预定义的运算符一样使用，我们甚至可以扩展已有的类型以支持自定义的运算符。
 */

import UIKit

class AdvancedOperators: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        bitwiseNotOperator()
        bitwiseOrOperator()
        bitwiseAndOperator()
        bitwiseXorOperator()
        shiftingBehaviorForUnsignedIntegers()
    }
    
    //MARK:-1.位运算符
    //位运算符可以操作数据结构中每个独立的比特位。它们通常被用在底层开发中，比如图形编程和创建设备驱动。位运算符在处理外部资源的原始数据时也十分有用，比如对自定义通信协议传输的数据进行编码和解码
    
    //MARK:--1.1按位取反运算符
    func bitwiseNotOperator() {
        //按位取反运算符是一个前缀运算符，需要直接放在运算的数之前，并且它们之间不能添加任何空格：
        let initialBits: UInt8 = 0b00001111
        let invertedBits = ~initialBits
        print("initialBits = \(initialBits);invertedBits = \(invertedBits)")

    }
    
    //MARK:--1.2按位与运算符
    func bitwiseAndOperator() {
        let firstSixBits: UInt8 = 0b11111100
        let lastSixBits: UInt8  = 0b00111111
        let middleForBits = firstSixBits & lastSixBits
        print("firstSixBits = \(firstSixBits),lastSixBits = \(lastSixBits),middleForBits = \(middleForBits)")
        
    }

    //MARK:--1.3按位或运算符
    func bitwiseOrOperator() {
        let someBits: UInt8 = 0b10110010
        let moreBits: UInt8 = 0b01011110
        let combinedbits = someBits | moreBits
        print("someBits = \(someBits),moreBits = \(moreBits),combinedbits = \(combinedbits)")
    }
    
    //MARK:--1.4按位异或运算符
    //按位异或运算符（^）可以对两个数的比特位进行比较。它返回一个新的数，当两个数的对应位不相同时，新数的对应位就为 1：
    func bitwiseXorOperator() {
        let firstBits: UInt8 = 0b00010100
        let otherBits: UInt8 = 0b00000101
        let outputBits = firstBits ^ otherBits  // equals 00010001
        print("firstBits = \(firstBits),otherBits = \(otherBits),outputBits = \(outputBits)")
    }
    
    //MARK:-2.按位左移、右移运算符
    /*
     按位左移运算符（<<）和按位右移运算符（>>）可以对一个数的所有位进行指定位数的左移和右移，但是需要遵守下面定义的规则。
     
     对一个数进行按位左移或按位右移，相当于对这个数进行乘以 2 或除以 2 的运算。将一个整数左移一位，等价于将这个数乘以 2，同样地，将一个整数右移一位，等价于将这个数除以 2。
     */
    //MARK:--2.1无符号整数的移位运算
    /*
     对无符号整数进行移位的规则如下：
     
     1.已经存在的位按指定的位数进行左移和右移。
     2.任何因移动而超出整型存储范围的位都会被丢弃。
     3.用 0 来填充移位后产生的空白位。
     */
    func shiftingBehaviorForUnsignedIntegers() {
        
        let shiftBits: UInt8 = 4   // 00000100
        shiftBits << 1             // 00001000
        shiftBits << 2             // 00010000
        shiftBits << 5             // 10000000
        shiftBits << 6             // 00000000
        shiftBits >> 2             // 00000001
        
        let pink: UInt32 = 0xCC6699
        let redComponent = (pink & 0xFF0000) >> 16    // redComponent is 0xCC, or 204
        let greenComponent = (pink & 0x00FF00) >> 8   // greenComponent is 0x66, or 102
        let blueComponent = pink & 0x0000FF           // blueComponent is 0x99, or 153
        print("redComponent = \(redComponent),greenComponent = \(greenComponent),blueComponent = \(blueComponent)")
    }
    
    //MARK:--2.2有符号整数的移位运算
    /*
     对比无符号整数，有符号整数的移位运算相对复杂得多，这种复杂性源于有符号整数的二进制表现形式。（为了简单起见，以下的示例都是基于 8 比特位的有符号整数的，但是其中的原理对任何位数的有符号整数都是通用的。）
     
     有符号整数使用第 1 个比特位（通常被称为符号位）来表示这个数的正负。符号位为 0 代表正数，为 1 代表负数。
     
     其余的比特位（通常被称为数值位）存储了实际的值。有符号正整数和无符号数的存储方式是一样的，都是从 0 开始算起。这是值为 4 的 Int8 型整数的二进制位表现形式：
     0000 0100 = 4
     符号位为 0，说明这是一个正数，另外 7 位则代表了十进制数值 4 的二进制表示。
     
     负数的存储方式略有不同。它存储的值的绝对值等于 2 的 n 次方减去它的实际值（也就是数值位表示的值），这里的 n 为数值位的比特位数。一个 8 比特位的数有 7 个比特位是数值位，所以是 2 的 7 次方，即 128。
     
     这是值为 -4 的 Int8 型整数的二进制位表现形式：
     11111100 = -4
     */
    
    
    //MARK:-3.溢出运算符
    
    //MARK:--3.1数值溢出
    
    //MARK:-4.优先级和结合性
    
    //MARK:-5.运算符函数
    //MARK:--5.1前缀和后缀运算符
    //MARK:--5.2复合赋值运算符
    //MARK:--5.3等价运算符
    
    //MARK:-6.自定义运算符
    //MARK:--6.1自定义中缀运算符的优先级
    
    
}

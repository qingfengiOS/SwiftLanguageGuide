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

//这两个是自定义运算符，需要定义在全局
prefix operator +++
infix operator +-: AdditionPrecedence

class AdvancedOperators: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        bitwiseNotOperator()
        bitwiseOrOperator()
        bitwiseAndOperator()
        bitwiseXorOperator()
        shiftingBehaviorForUnsignedIntegers()
        
        overflowOperators()
        valueOverflow()
        
        operatorMethods()
        
        customOperators()
        precedenceForCustomInfixOperators()
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
    /*在默认情况下，当向一个整数赋予超过它容量的值时，Swift 默认会报错，而不是生成一个无效的数。这个行为为我们在运算过大或着过小的数的时候提供了额外的安全性。
     
     例如，Int16 型整数能容纳的有符号整数范围是 -32768 到 32767，当为一个 Int16 型变量赋的值超过这个范围时，系统就会报错：
     */
    func overflowOperators() {
        var potentialOverflow = Int32.max
//        potentialOverflow += 1//报错：Arithmetic operation '2147483647 + 1' (on type 'Int32') results in an overflow
    }
    /*
     为过大或者过小的数值提供错误处理，能让我们在处理边界值时更加灵活。
     
     然而，也可以选择让系统在数值溢出的时候采取截断处理，而非报错。可以使用 Swift 提供的三个溢出运算符来让系统支持整数溢出运算。这些运算符都是以 & 开头的：
     
     1、溢出加法 &+
     2、溢出减法 &-
     3、溢出乘法 &*
     */
    
    //MARK:--3.1数值溢出
    /*
     数值有可能出现上溢或者下溢。
     
     这个示例演示了当我们对一个无符号整数使用溢出加法（&+）进行上溢运算时会发生什么：
     */
    func valueOverflow() {
        var unsignedOverFlow = UInt8.max
        unsignedOverFlow = unsignedOverFlow &+ 1
        print("unsignedOverFlow = \(unsignedOverFlow)")
        /*
           1 1 1 1 1 1 1 1 //原始值8个1
         &+              1 //加一个1
         -----------------
           0 0 0 0 0 0 0 0 //现在全部都是0（8个）所以结果为0
         */
        
//        溢出也会发生在有符号整型数值上。在对有符号整型数值进行溢出加法或溢出减法运算时，符号位也需要参与计算，正如按位左移、右移运算符所描述的。
        var signedOverflow2 = Int8.min
        // signedOverflow 等于 Int8 所能容纳的最小整数 -128
        signedOverflow2 = signedOverflow2 &- 1
        // 此时 signedOverflow 等于 127
    }
    
    
    //MARK:-4.优先级和结合性
    /*
     运算符的优先级使得一些运算符优先于其他运算符，高优先级的运算符会先被计算。
     
     结合性定义了相同优先级的运算符是如何结合的，也就是说，是与左边结合为一组，还是与右边结合为一组。可以将这意思理解为“它们是与左边的表达式结合的”或者“它们是与右边的表达式结合的”。
     
     在复合表达式的运算顺序中，运算符的优先级和结合性是非常重要的。举例来说，运算符优先级解释了为什么下面这个表达式的运算结果会是 17。
     
     2 + 3 % 4 * 5
     
     优先级高的运算符要先于优先级低的运算符进行计算。与 C 语言类似，在 Swift 中，乘法运算符（*）与取余运算符（%）的优先级高于加法运算符（+）。因此，它们的计算顺序要先于加法运算。
     2 + ((3 % 4) * 5)
     */
    
    //MARK:-5.运算符函数
    /*
     类和结构体可以为现有的运算符提供自定义的实现，这通常被称为运算符重载。
     
     下面的例子展示了如何为自定义的结构体实现加法运算符（+）。算术加法运算符是一个双目运算符，因为它可以对两个值进行运算，同时它还是中缀运算符，因为它出现在两个值中间。
     */
    
    
    //MARK:--5.1前缀和后缀运算符
    /*
     上个例子演示了一个双目中缀运算符的自定义实现。类与结构体也能提供标准单目运算符的实现。单目运算符只运算一个值。当运算符出现在值之前时，它就是前缀的（例如 -a），而当它出现在值之后时，它就是后缀的（例如 b!）。
     
     要实现前缀或者后缀运算符，需要在声明运算符函数的时候在 func 关键字之前指定 prefix 或者 postfix 修饰符：
     */
    
    //MARK:--5.2复合赋值运算符
    /*
     复合赋值运算符将赋值运算符（=）与其它运算符进行结合。例如，将加法与赋值结合成加法赋值运算符（+=）。在实现的时候，需要把运算符的左参数设置成 inout 类型，因为这个参数的值会在运算符函数内直接被修改。
     */
    
    //MARK:--5.3等价运算符
    
    func operatorMethods() {
        print("-----------运算符函数:-------------")
        let vector = Vector2D(x: 3.0, y: 1.0)
        let otherVector = Vector2D(x: 2.0, y: 4.0)
        let combineVector = vector + otherVector
        print("combineVector = \(combineVector)")
        
        print("----------前缀或者后缀运算符:--------------")
        let positive = Vector2D(x: 3.0, y: 4.0)
        let negative = -positive
        // negative 是一个值为 (-3.0, -4.0) 的 Vector2D 实例
        let alsoPositive = -negative
        // alsoPositive 是一个值为 (3.0, 4.0) 的 Vector2D 实例
        print("alsoPositive = \(alsoPositive)")
        
        print("----------复合赋值运算符:--------------")
        var original = Vector2D(x: 1.0, y: 2.0)
        var vectorToAdd = Vector2D(x: 3.0, y: 4.0)
        original += vectorToAdd
        print("original = \(original)")// original 的值现在为 (4.0, 6.0)
        
        print("----------等价运算符:--------------")
        let twoThree = Vector2D(x: 2.0, y: 3.0)
        let anotherTwoThree = Vector2D(x: 2.0, y: 3.0)
        if twoThree == anotherTwoThree {
            print("These two vectors are equivalent.")
        }
        
    }
    
    //MARK:-6.自定义运算符
    /*
     除了实现标准运算符，在 Swift 中还可以声明和实现自定义运算符。
     
     新的运算符要使用 operator 关键字在全局作用域内进行定义，同时还要指定 prefix、infix 或者 postfix 修饰符：
     
     例： prefix operator +++ (在上面已经全局定义了)
     上面的代码定义了一个新的名为 +++ 的前缀运算符。对于这个运算符，在 Swift 中并没有意义，因此我们针对 Vector2D 的实例来定义它的意义。对这个示例来讲，+++ 被实现为“前缀双自增”运算符。它使用了前面定义的复合加法运算符来让矩阵对自身进行相加，从而让 Vector2D 实例的 x 属性和 y 属性的值翻倍。实现 +++ 运算符的方式见extension Vector2D
     */
    func customOperators() {
        var toBeDoubled = Vector2D(x: 1.0, y: 4.0)
        let afterDoubling = +++toBeDoubled
        print("toBeDoubled = \(toBeDoubled),afterDoubling = \(afterDoubling)")
    }
    //MARK:--6.1自定义中缀运算符的优先级
    /*
     每个自定义中缀运算符都属于某个优先级组。这个优先级组指定了这个运算符和其他中缀运算符的优先级和结合性。优先级和结合性中详细阐述了这两个特性是如何对中缀运算符的运算产生影响的。
     
     而没有明确放入优先级组的自定义中缀运算符会放到一个默认的优先级组内，其优先级高于三元运算符。
     
     以下例子定义了一个新的自定义中缀运算符 +-，此运算符属于 AdditionPrecedence 优先组：
     */
    func precedenceForCustomInfixOperators() {
        let firstVector = Vector2D(x: 1.0, y: 2.0)
        let secondVector = Vector2D(x: 3.0, y: 4.0)
        let plusMinusVector = firstVector +- secondVector
        print("plusMinusVector = \(plusMinusVector)")
    }
}

struct Vector2D {
    var x = 0.0, y = 0.0
    
    
}

extension Vector2D {
    //运算符函数：
    static func + (left: Vector2D, right: Vector2D) -> Vector2D {
        return Vector2D(x: left.x + right.x, y: left.y + right.y)
    }
    
    /*
     前缀和后缀运算符:
     
     上个例子演示了一个双目中缀运算符的自定义实现。类与结构体也能提供标准单目运算符的实现。单目运算符只运算一个值。当运算符出现在值之前时，它就是前缀的（例如 -a），而当它出现在值之后时，它就是后缀的（例如 b!）。
     
     要实现前缀或者后缀运算符，需要在声明运算符函数的时候在 func 关键字之前指定 prefix 或者 postfix 修饰符：
     */
    static prefix func - (vector: Vector2D) -> Vector2D {
        return Vector2D(x: -vector.x, y: -vector.y)
        //这段代码为 Vector2D 类型实现了单目负号运算符。由于该运算符是前缀运算符，所以这个函数需要加上 prefix 修饰符
    }
    
    /*
     复合赋值运算符:
     
     复合赋值运算符将赋值运算符（=）与其它运算符进行结合。例如，将加法与赋值结合成加法赋值运算符（+=）。在实现的时候，需要把运算符的左参数设置成 inout 类型，因为这个参数的值会在运算符函数内直接被修改。
     */
    static func += (left: inout Vector2D, right: inout Vector2D) {
        left = left + right
    }
    
    /*
     等价运算符:
     
     自定义的类和结构体没有对等价运算符进行默认实现，等价运算符通常被称为“相等”运算符（==）与“不等”运算符（!=）。对于自定义类型，Swift 无法判断其是否“相等”，因为“相等”的含义取决于这些自定义类型在你的代码中所扮演的角色。
     
     为了使用等价运算符能对自定义的类型进行判等运算，需要为其提供自定义实现，实现的方法与其它中缀运算符一样：
     */
    static func == (left: Vector2D, right: Vector2D) -> Bool {
        return (left.x == right.x) && (left.y == right.y)
    }
    static func != (left: Vector2D, right: Vector2D) -> Bool {
        return !(left == right)
    }
    
    
    /*
     自定义运算符：
     
     针对 Vector2D 的实例来定义它的意义。对这个示例来讲，+++ 被实现为“前缀双自增”运算符。它使用了前面定义的复合加法运算符来让矩阵对自身进行相加，从而让 Vector2D 实例的 x 属性和 y 属性的值翻倍。实现 +++ 运算符的方式如下
     */
    static prefix func +++ (vector: inout Vector2D) -> Vector2D {
        var tempV = vector
        
        vector += tempV
        return vector
    }
    
    /*
     自定义中缀运算符的优先级:
     
     以下例子定义了一个新的自定义中缀运算符 +-，此运算符属于 AdditionPrecedence 优先组：
     */
    static func +- (left: Vector2D, right: Vector2D) -> Vector2D {
        return Vector2D(x: left.x + right.x, y: left.y - right.y)
    }
    
}




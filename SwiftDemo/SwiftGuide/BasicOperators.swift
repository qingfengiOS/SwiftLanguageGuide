//
//  Basic_Operators.swift
//  SwiftDemo
//
//  Created by liyiping on 2018/4/19.
//  Copyright © 2018年 情风. All rights reserved.
//

import UIKit

class BasicOperators: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
     
        assignmentOperator()
        remainderOperator()
        unaryOperator()
        comparisonOperators()
        ternaryConditionalOperator()
        nilCoalescingOperator()
        rangeOperators()
        logicalOperator()
    }

    
    /// 赋值运算符
    func assignmentOperator() {
        let b = 10
        var a = 5
        a = b
        
        let (x,y) = (1,"2")
        print(a,b,x,y)
        
//        if x = Int(y) {//care：复制运算符没有返值
//
//        }
        
    }
    
    /// 求余操作符
    func remainderOperator() {
        _ = 9 % 5
    }
    
    
    /// 一元操作符 正、负
    func unaryOperator() {
        
        let three = 3
        let minusThree = -three
        let plusThree = -minusThree
        
        let minusSix = -6
        let alsoMinusSix = +minusSix
        
        print(plusThree,alsoMinusSix)
    }
    
    /// 复合赋值操作符
    func compoundAssignmentOperators() {
        var a = 1
        a += 2
        print(a)
    }
    
    
    /// 比较操作符，一般用于条件判断
    func comparisonOperators() {
        1 == 1   // true because 1 is equal to 1
        2 != 1   // true because 2 is not equal to 1
        2 > 1    // true because 2 is greater than 1
        1 < 2    // true because 1 is less than 2
        1 >= 1   // true because 1 is greater than or equal to 1
        2 <= 1   // false because 2 is not less than or equal to 1
        
        //当元组中的值可以比较时，你也可以使用这些运算符来比较它们的大小。
        (1, "zebra") < (2, "apple")// true，因为 1 小于 2
        (3, "apple") < (3, "bird")// true，因为 3 等于 3，但是 apple 小于 bird
        (4, "dog") == (4, "dog")// true，因为 4 等于 4，dog 等于 dog
        
        /*
         在上面的例子中，你可以看到，在第一行中从左到右的比较行为。因为 1 小于 2 ，所以 (1, "zebra") 小于 (2, "apple") ，不管元组剩下的值如何。所以 "zebra" 小于 "apple" 没有任何影响，因为元组的比较已经被第一个元 素决定了。不过，当元组的第一个元素相同时候，第二个元素将会用作比较-第二行和第三行代码就发生了这样的 比较。
         */
    }
    
    
    /// 三目运算符
    func ternaryConditionalOperator() {
        let contentHeight = 40
        let hasHeader = true
        let rowHeight = contentHeight + (hasHeader ? 50 : 20) // rowHeight 现在是 90
        print(rowHeight)
    }
    
    
    /// 空合运算符
    func nilCoalescingOperator() {
        /**
         空合运算符( a ?? b )将对可选类型 a 进行空判断，如果 a 包含一个值就进行解封，否则就返回一个默认值 b 。表达式 a 必须是 Optional 类型。默认值 b 的类型必须要和 a 存储值的类型保持一致。
         
         (a != nil ? a！: b) 与 (a ?? b) 等价
         
         上述代码使用了三目运算符。当可选类型 a 的值不为空时，进行强制解封(a!)，访问 a 中的值;反之返 回默认值 b 。无疑空合运算符( ?? )提供了一种更为优 的方式去封装条件判断和解封两种行为，显得简洁以 及更具可读性
         */
        let defaultColorName = "red"
        var userDefineColorName: String?//默认为nil
        var colorToUse = userDefineColorName ?? defaultColorName
    }
    
    
    /// 区间运算符
    func rangeOperators() {
        /*
         闭区间运算符(a...b)定义一个包含从a到b(包括a和b)的所有值的区间。a的值不能超过b。闭区间运算符在迭代一个区间的所有值时是非常有用的，如在for-in循环中
         */
        for index in 1...5 {
            print("\(index) * 5 = \(index * 5)")
        }
        
        //半开区间的实用性在于当你使用一个从 0 开始的列表(如数组)时，非常方便地从0数到列表的长度。
        let names = ["Anna", "Alex", "Brian", "Jack"]
        let count = names.count
        for i in 0..<count {
            print("第 \(i + 1) 个人叫 \(names[i])")
        }
        
    }
    
    
    /// 逻辑运算
    func logicalOperator(){
        
        let enteredDoorCode = true
        let passedRetinaScan = false
        let hasDoorKey = false
        let knowsOverridePassword = true
        if (enteredDoorCode && passedRetinaScan) || hasDoorKey || knowsOverridePassword {
            print("Welcome!")
        } else {
            print("ACCESS DENIED")
        }
    // 输出 "Welcome!"
    
    }

    
}

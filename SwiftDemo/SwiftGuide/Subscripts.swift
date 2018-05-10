//
//  Subscripts.swift
//  SwiftDemo
//
//  Created by qingfeng on 2018/5/9.
//  Copyright © 2018年 情风. All rights reserved.
//

import UIKit

class Subscripts: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white

        subscriptSyntax()
        subscriptUsage()
        subscriptOptions()
    }
    
    
    
    //MARK:--下标语法
    func subscriptSyntax() {
        
        let threeTimes = TimesTable(mutiple: 3)
        print("six times three is \(threeTimes[6])")
        /*
         在上例中，创建了一个 TimesTable 实例，用来表示整数 3 的乘法表。数值 3 被传递给结构体的构造函数，作为 实例成员 multiplier 的值。
         */
    }

    //MARK:--下标用法
    func subscriptUsage() {
        var numberLegs = ["spider": 8, "ant": 6, "cat": 4]
        numberLegs["bird"] = 2
        print(numberLegs)
        /*
         上例定义一个名为 numberOfLegs 的变量，并用一个包含三对键值的字典字面量初始化它。 numberOfLegs 字典的 类型被推断为 [String: Int] 。字典创建完成后，该例子通过下标将 String 类型的键 bird 和 Int 类型的值 2 添 加到字典中。
         */
    }
    
    //MARK:--下标选项
    /*
     一个类或结构体可以根据自身需要提供多个下标实现，使用下标时将通过入参的数量和类型进行区分，自动匹配合适的下标，这就是下标的重载。
     */
    func subscriptOptions() {
        var matrix = Matrix(rows: 2, columns: 2);//Matrix 提供了一个接受两个入参的构造方法，入参分别是 rows 和 columns ，创建了一个足够容纳rows * columns 个 Double 类型的值的数组。通过传入数组长度和初始值 0.0 到数组的构造器，将矩阵中每个位置的值初始化 为 0.0 。
        matrix[0, 1] = 1.5
        matrix[1, 1] = 3.2
        /*
         上面两条语句分别调用下标的 setter 将矩阵右上角位置(即 row 为 0 、 column 为 1 的位置)的值设置为 1.5 ，将矩阵左下角位置(即 row 为 1 、 column 为 0 的位置)的值设置为 3.2
         */
        print(matrix[0,1])
        print(matrix[1,1])
        
//        let someValue = matrix[2, 2]//断言将会触发，因为 [2, 2] 已经超过了 matrix 的范围
//        print(someValue)
        
    }
    
    
}

struct TimesTable {
    let mutiple: Int
    subscript (index: Int) -> Int {
        return mutiple * index
    }
}


/// 虽然接受单一入参的下标是最常见的，但也可以根据情况定义接受多个入参的下标。例如下例定义了一个 结构体，用于表示一个 Double 类型的二维矩阵。 Matrix 结构体的下标接受两个整型参数:
struct Matrix {
    let rows: Int, columns: Int
    var grid: [Double]

    init(rows: Int, columns: Int) {
        self.rows = rows
        self.columns = columns
        
        grid = Array(repeating:0.0, count: rows * columns)
        
    }
    
    //Matrix 下标的 getter 和 setter 中都含有断言，用来检查下标入参 row 和 column 的值是否有效。为了方便进 行断言， Matrix 包含了一个名为 indexIsValidForRow(_:column:) 的便利方法，用来检查入参 row 和 column 的值 是否在矩阵范围内:
    func indexIsValid(row: Int, column: Int) -> Bool {
        
        return row >= 0 && row < rows && column >= 0 && column < columns
    }
    
    subscript(row: Int, column: Int) -> Double {
        get {
            assert(indexIsValid(row: row, column: column),"index out of range")
            return grid[(row * columns) + column]
        }
        
        set {
            assert(indexIsValid(row: row, column: column), "Index out of range")
            grid[(row * columns) + column] = newValue
            
        }
    }

}

//
//  MoreOperator.swift
//  SwiftDemo
//
//  Created by ios on 2019/2/18.
//  Copyright © 2019年 情风. All rights reserved.
//

import UIKit

class MoreOperator: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        var a = 0
        for _ in 0...10 {
            print(incrementtor(variable: &a))
        }
        
        Tiger().eat(Meat())
    }
    
    func incrementtor(variable:inout Int) -> Int {
        variable += 1
        return variable
    }
    
    
}



protocol TheFood {
    
}
/*
 在 Tiger 通过 typealias 具体指定 F 为 Meat 之前，Animal 协议中并不关心 F 的具体类型，只需要满足协议的类型中的 F 和 eat 参数一致即可。如此一来，我们就可以避免在 Tiger 的 eat 中进行判定和转换了。不过这里忽视了被吃的必须是 Food 这个前提。associatedtype 声明中可以使用冒号来指定类型满足某个协议，另外，在 Tiger 中只要实现了正确类型的 eat，F 的类型就可以被推断出来，所以我们也不需要显式地写明 F
 */
protocol TheAnimal {
    associatedtype F
    func eat(_ food: F)
}

struct Meat: TheFood {
    
}

struct Tiger: TheAnimal {
    
    typealias F = Meat
    func eat(_ food: Meat) {
        print("eat--\(food)")
    }
}

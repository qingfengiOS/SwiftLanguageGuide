//
//  Deinitialization.swift
//  SwiftDemo
//
//  Created by 李一平 on 2018/5/17.
//  Copyright © 2018年 情风. All rights reserved.
//

import UIKit

class Deinitialization: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        
        var playerOne: Players? = Players(coins: 100)
        print("A new player has joined the game with \(playerOne!.coinsInPurs) coins")
        print("There are now \(Bank.coinsInBank) coins left in the bank")
        
        playerOne!.win(coins: 2_000)
        print("PlayerOne won 2000 coins & now has \(playerOne!.coinsInPurs) coins")
        print("The bank now only has \(Bank.coinsInBank) coins left")
        
        playerOne = nil
        print("PlayerOne has left the game")// 打印 "PlayerOne has left the game"
        print("The bank now has \(Bank.coinsInBank) coins") // 打印 "The bank now has 10000 coins"
        
        
    }
    
    //MARK:--析构过程原理
    /*
     Swift 会自动释放不再需要的实例以释放资源。如自动引用计数章节中所讲述，Swift 通过 自动引用计数(ARC) 处理实例的内存管理。通常当你的实例被释放时不需要手动地去清理。但是，当使用自己的资源时，你可能 需要进行一些额外的清理。例如，如果创建了一个自定义的类来打开一个文件，并写入一些数据，你可能需要在 类实例被释放之前手动去关闭该文件。
     在类的定义中，每个类最多只能有一个析构器，而且析构器不带任何参数，如下所示:
     */
    deinit {
        print("Deinitialization执行析构过程")
    }

}

//MARK:--析构器实践
/*
 这是一个析构器实践的例子。这个例子描述了一个简单的游戏，这里定义了两种新类型，分别是 Bank 和 Player 。 Bank 类管理一种虚拟硬币，确保流通的硬币数量永远不可能超过 10,000。在游戏中有且只能有一个 Bank 存 在，因此 Bank 用类来实现，并使用类型属性和类型方法来存储和管理其当前状态。
 */
class Bank {
    static var coinsInBank = 10_000
    
    static func distribute(coins numberOfCoinsRequested: Int) -> Int {
        let numberOfCoinsToVend = min(numberOfCoinsRequested, coinsInBank)
        coinsInBank -= numberOfCoinsToVend
        return numberOfCoinsToVend
    }
    
    static func receive(coins: Int) {
        coinsInBank += coins
    }
    /*
     Bank 使用 coinsInBank 属性来跟踪它当前拥有的硬币数量。 Bank 还提供了两个方法， distribute(coins:) 和 r eceive(coins:) ，分别用来处理硬币的分发和收集。
     distribute(coins:) 方法在 Bank 对象分发硬币之前检查是否有足够的硬币。如果硬币不足， Bank 对象会返回一 个比请求时小的数字(如果 Bank 对象中没有硬币了就返回 0 )。此方法返回一个整型值，表示提供的硬币的实 际数量。
     receive(coins:) 方法只是将 Bank 实例接收到的硬币数目加回硬币存储中。
     */
}


class Players {
    var coinsInPurs: Int
    init(coins: Int) {
        coinsInPurs = Bank.distribute(coins: coins)
    }
    
    func win(coins: Int) {
        coinsInPurs += Bank.distribute(coins: coins)
    }
    
    deinit {
        Bank.receive(coins: coinsInPurs)
    }
    /*
     每个 Player 实例在初始化的过程中，都从 Bank 对象获取指定数量的硬币。如果没有足够的硬币可用， Player 实例可能会收到比指定数量少的硬币.
     
     Player 类定义了一个 win(coins:) 方法，该方法从 Bank 对象获取一定数量的硬币，并把它们添加到玩家的钱 包。 Player 类还实现了一个析构器，这个析构器在 Player 实例释放前被调用。在这里，析构器的作用只是将玩 家的所有硬币都返还给 Bank 对象:
     */
}



//
//  ViewController.swift
//  SwiftDemo
//
//  Created by qingfeng on 2018/4/11.
//  Copyright © 2018年 情风. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var dataArray = ["TheBasic",//继承
                     "BasicOperators",//基本操作
                     "StringsAndCharacters",//字符和字符串
                     "CollectionTypes",//集合类型
                     "ControlFlow",//流程控制
                     "Functions",//函数
                     "Closures",//闭包
                     "Enumerations",//枚举
                     "ClassesAndStructures",//类和结构体
                     "Properties",//属性
                     "Methods",//方法
                     "Subscripts",//下标
                     "Inheritance",//继承
                     "Initialization",//构造过程
                     "Deinitialization",//析构
                     "OptionalChaining",//可选调用
                     "ErrorHandling",//错误处理
                     "TypeCasting",//类型捕获
                     "NestedTypes",//嵌套类型
                     "Extensions",//扩展
                    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView .register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.tableView.tableFooterView = UIView()
        
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = self.dataArray[indexPath.row]
        cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
    
        return cell;
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let viewController = getViewContrlooerByClassName(className: self.dataArray[indexPath.row])
        self.navigationController? .pushViewController(viewController!, animated: true)
    }
    
    //MARK:--通过类名初始化VC
    func getViewContrlooerByClassName(className: String) -> UIViewController? {
        
        guard let nameSpace = Bundle.main.infoDictionary!["CFBundleExecutable"] as? String else {
            return nil
        }
        guard let vcName = NSClassFromString(nameSpace + "." + className) else {
            return nil
        }
        guard let type = vcName as? UIViewController.Type else {
            return nil
        }
        let viewController = type.init()
        
        return viewController
    }
    
}


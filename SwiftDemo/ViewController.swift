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
    
    var dataArray = ["TheBasic",
                     "BasicOperators",
                     "StringsAndCharacters",
                     "CollectionTypes",
                     "ControlFlow",
                     "Functions",
                     "Closures",
                     "Enumerations",
                     "ClassesAndStructures",
                     "Properties",
                     "Methods",
                     "Subscripts",
                     "Inheritance",
                     "Initialization",
                     "Deinitialization",
                     "OptionalChaining",
                     "ErrorHandling",
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


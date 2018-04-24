//
//  ViewController.swift
//  SwiftDemo
//
//  Created by liyiping on 2018/4/11.
//  Copyright © 2018年 情风. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var dataArray = ["The_Basic","Basic_Operators","StringsAndCharacters","CollectionTypes"]
    
    
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
        
        switch indexPath.row {
        case 0: self.navigationController? .pushViewController(The_Basic() as UIViewController, animated: true)
        case 1: self.navigationController? .pushViewController(Basic_Operators() as UIViewController, animated: true)
        case 2:
            self.navigationController? .pushViewController(StringsAndCharacters() as UIViewController, animated: true)
        case 3:
            self.navigationController? .pushViewController(CollectionTypes() as UIViewController, animated: true)
        default: break
        }
        
    }
    
    
}


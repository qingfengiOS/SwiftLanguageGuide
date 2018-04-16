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
    var dataArray = ["The Basic"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView .register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.tableView.tableFooterView = UIView()
        
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = self.dataArray[indexPath.row]
        cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
    
        return cell;
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let basics =  The_Basic()
        self.navigationController? .pushViewController(basics, animated: true)
    }
}


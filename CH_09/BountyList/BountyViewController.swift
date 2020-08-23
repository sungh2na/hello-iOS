//
//  BountyViewController.swift
//  BountyList
//
//  Created by Y on 2020/08/15.
//  Copyright © 2020 Y. All rights reserved.
//

import UIKit

class BountyViewController: UIViewController,
UITableViewDataSource, UITableViewDelegate{

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell =
        tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        return cell
    }
    
    // UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(" --> \(indexPath.row)")
    }
}

class ListCell: UITableViewCell {
    @IBOutlet 
}

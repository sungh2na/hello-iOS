//
//  BountyInfo.swift
//  BountyList
//
//  Created by Y on 2020/08/26.
//  Copyright © 2020 Y. All rights reserved.
//

import UIKit

struct BountyInfo {
    let name: String
    let bounty: Int
    
    var image: UIImage? {
        return UIImage(named: "\(name).jpg")
    }
    
    init(name: String, bounty: Int){
        self.name = name
        self.bounty = bounty
    }
}

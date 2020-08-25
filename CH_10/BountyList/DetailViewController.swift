//
//  DetailViewController.swift
//  BountyList
//
//  Created by Y on 2020/08/25.
//  Copyright © 2020 Y. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    // MVVM
    
    // Model
    //  - BountyInfo
    //  > BountyInfo 만들자
    
    // View
    //  - imgView, nameLabel, bountylabel
    //  > view들은 viewModel을 통해서 구성되기?
    
    // ViewModel
    //  - DetailViewModel
    //  > 뷰레이어에서 필요한 메서드 만들기
    //  > Model 가지고 있기, BountyInfo 들
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var bountyLabel: UILabel!
    
    let viewModel = DetailViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateUI()
    }

    func updateUI() {
        if let bountyInfo = self.viewModel.bountyInfo {
            imgView.image = bountyInfo.image
            nameLabel.text = bountyInfo.name
            bountyLabel.text = "\(bountyInfo.bounty)"
        }
    }
    
    @IBAction func close(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}

class DetailViewModel {
    var bountyInfo: BountyInfo?         // Model을 가지고 있음
    func update(model: BountyInfo?) {
        bountyInfo = model
    }
}

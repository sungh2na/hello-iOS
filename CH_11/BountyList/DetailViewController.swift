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
    @IBOutlet weak var nameLabelCenterX: NSLayoutConstraint!
    @IBOutlet weak var bountyLabelCenterX: NSLayoutConstraint!
    
    let viewModel = DetailViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        prepareAnimation()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        showAnimation()
    }
    
    private func prepareAnimation() {
        nameLabel.transform = CGAffineTransform(translationX: view.bounds.width, y: 0).scaledBy(x:3, y:3).rotated(by:100)
        bountyLabel.transform = CGAffineTransform(translationX: view.bounds.width, y: 0).scaledBy(x:3, y:3).rotated(by:100)
        
        nameLabel.alpha = 0
        bountyLabel.alpha = 0
    }
    
    private func showAnimation() {
        nameLabelCenterX.constant = 0
        bountyLabelCenterX.constant = 0
        
        UIView.animate(withDuration: 1, delay: 0,  usingSpringWithDamping: 0.6, initialSpringVelocity: 2, options: .allowUserInteraction, animations: {
            self.nameLabel.transform = CGAffineTransform.identity
            self.nameLabel.alpha = 1
        }, completion: nil)
        
        UIView.animate(withDuration: 1, delay: 0.2,  usingSpringWithDamping: 0.6, initialSpringVelocity: 2, options: .allowUserInteraction, animations: {
            self.bountyLabel.transform = CGAffineTransform.identity
            self.bountyLabel.alpha = 1
        }, completion: nil)
    
        UIView.transition(with: imgView, duration: 0.3, options: .transitionFlipFromLeft, animations: nil, completion: nil)
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

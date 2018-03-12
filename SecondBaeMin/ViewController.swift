//
//  ViewController.swift
//  SecondBaeMin
//
//  Created by 이수한 on 2018. 3. 9..
//  Copyright © 2018년 이수한. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var moverWidthConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var entireButtonCenterConstraint: NSLayoutConstraint!
    @IBOutlet weak var newButtonCenterConstraint: NSLayoutConstraint!
    @IBOutlet weak var programmingButtonCenterConstraint: NSLayoutConstraint!
    @IBOutlet weak var marketingButtonCenterConstraint: NSLayoutConstraint!
    @IBOutlet weak var financeButtonCenterConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var entireButton: UIButton!
    @IBOutlet weak var newButton: UIButton!
    @IBOutlet weak var programmingButton: UIButton!
    @IBOutlet weak var marketingButton: UIButton!
    @IBOutlet weak var financeButton: UIButton!
    
    struct Menu {
        var title: String
        var button: UIButton
        var constraint: NSLayoutConstraint
    }
    
    var menuArray : Array<Menu> = []
    
    @IBAction func selectMenu(_ sender: Any) {
        entireButtonCenterConstraint.isActive = (sender as AnyObject).tag == 100
        newButtonCenterConstraint.isActive = (sender as AnyObject).tag == 200
        programmingButtonCenterConstraint.isActive = (sender as AnyObject).tag == 300
        marketingButtonCenterConstraint.isActive = (sender as AnyObject).tag == 400
        financeButtonCenterConstraint.isActive = (sender as AnyObject).tag == 500
        
        entireButton.setTitleColor(entireButtonCenterConstraint.isActive ? UIColor.black : UIColor.lightGray, for: .normal)
        newButton.setTitleColor(newButtonCenterConstraint.isActive ? UIColor.black : UIColor.lightGray, for: .normal)
        programmingButton.setTitleColor(programmingButtonCenterConstraint.isActive ? UIColor.black : UIColor.lightGray, for: .normal)
        marketingButton.setTitleColor(marketingButtonCenterConstraint.isActive ? UIColor.black : UIColor.lightGray, for: .normal)
        financeButton.setTitleColor(financeButtonCenterConstraint.isActive ? UIColor.black : UIColor.lightGray, for: .normal)
        
        if let title = (sender as AnyObject).title(for: .normal), let font = (sender as AnyObject).titleLabel??.font {
            let attr = [NSAttributedStringKey.font: font]
            let width = (title as NSString).size(withAttributes: attr).width
            moverWidthConstraint.constant = width + 10
        }
        
        UIView.animate(withDuration: 0.3) { [weak self] in
            self?.view.layoutIfNeeded()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        selectMenu(entireButton)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

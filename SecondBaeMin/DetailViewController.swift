//
//  DetailViewController.swift
//  SecondBaeMin
//
//  Created by 이수한 on 2018. 3. 26..
//  Copyright © 2018년 이수한. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    var course: Course?
    
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var headerBackgroundView: UIView!
    @IBOutlet weak var blackBackButton: UIButton!
    @IBOutlet weak var whiteBackButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var listTableView: UITableView!
    
    @IBAction func moveToBack(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    var whiteMode = false
    var barStyle = UIStatusBarStyle.lightContent
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return barStyle
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        headerBackgroundView.alpha = 0
        blackBackButton.alpha = 0
        whiteBackButton.alpha = 1
        titleLabel.alpha = 0
        
        titleLabel.text = course?.title
        
        listTableView.contentInset = UIEdgeInsets(top: imageHeightConstraint.constant - headerView.bounds.height, left: 0, bottom: 0, right: 0)
        
        listTableView.scrollIndicatorInsets = listTableView.contentInset
    }

}

extension DetailViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let y = scrollView.contentOffset.y
        
        let diff = y + 200
        
        if y < -200 {
            imageHeightConstraint.constant = 300 + abs(diff)
        } else {
            imageHeightConstraint.constant = 300
        }
        
        if y >= 0 {
            if !whiteMode {
                whiteMode = true
                
                UIView.animate(withDuration: 0.3, delay: 0.0, options: UIViewAnimationOptions.beginFromCurrentState, animations: { [weak self] in
                    self?.headerBackgroundView.alpha = 1.0
                    self?.blackBackButton.alpha = 1.0
                    self?.whiteBackButton.alpha = 0.0
                    self?.titleLabel.alpha = 1.0
                    }, completion: nil)
            }
            
            barStyle = .default
            setNeedsStatusBarAppearanceUpdate()
        } else {
            if whiteMode {
                whiteMode = false
                
                UIView.animate(withDuration: 0.3, delay: 0.0, options: UIViewAnimationOptions.beginFromCurrentState, animations: { [weak self] in
                    self?.headerBackgroundView.alpha = 0.0
                    self?.blackBackButton.alpha = 0.0
                    self?.whiteBackButton.alpha = 1.0
                    self?.titleLabel.alpha = 0.0
                    }, completion: nil)
            }
            barStyle = .lightContent
            setNeedsStatusBarAppearanceUpdate()
        }
    }
}

extension DetailViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: "dummy")!
    }
    
    
}

extension DetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 3000
    }
}



























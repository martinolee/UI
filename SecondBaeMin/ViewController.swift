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
    
    @IBOutlet weak var bannerCollectionView: UICollectionView!
    @IBOutlet weak var bannerCollcetionViewHeight: NSLayoutConstraint!
    
    var timer: DispatchSourceTimer?
    
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
        
        UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: [], animations: { [weak self] in
            self?.view.layoutIfNeeded()
        }, completion: nil)

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        print(bannerCollectionView.frame.size.width)
        bannerCollcetionViewHeight.constant = bannerCollectionView.frame.size.width / 2
        
        selectMenu(entireButton)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let targetIndex = IndexPath(item: 5000, section: 0)
        bannerCollectionView.selectItem(at: targetIndex, animated: false, scrollPosition: .centeredHorizontally)
        
        resumeTimer()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        timer?.suspend()
    }
    
    func resumeTimer() {
        if timer == nil {
            timer = DispatchSource.makeTimerSource(flags: [], queue: DispatchQueue.main)
            timer?.schedule(deadline: .now() + 5, repeating: .seconds(5))
            timer?.setEventHandler(handler: { [weak self] in
                if var indexPath = self?.bannerCollectionView.indexPathsForVisibleItems.first {
                    indexPath.item += 1
                    
                    self?.bannerCollectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
                }
            })
        }
        timer?.resume()
    }
    
}

extension ViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10000
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BannerCollectionViewCell.identifier, for: indexPath) as! BannerCollectionViewCell
        
        let imageName = "banner\(indexPath.row % 5)"
        cell.bannerImageView.image = UIImage(named: imageName)
        
        return cell
    }
    
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.frame.size
    }
}






























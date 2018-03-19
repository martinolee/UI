//
//  ViewController.swift
//  SecondBaeMin
//
//  Created by 이수한 on 2018. 3. 9..
//  Copyright © 2018년 이수한. All rights reserved.
//

import UIKit

struct Course {
    let title: String
    let imageName: String
    let startDate: Date
    let endDate: Date
    let tags: [String]
    let location: String
}

class ViewController: UIViewController {
    var courseList = [
        Course(title: "Swift4를 활용한 iOS 앱 개발 CAMP", imageName: "course0", startDate: Date(), endDate: Date(), tags: ["iOS", "Swift4"], location: "리틀스타 10-A"),
        Course(title: "나만의 iOS 앱 개발 입문 CAMP", imageName: "course1", startDate: Date(), endDate: Date(), tags: ["iOS", "Swift4"], location: "리틀스타 10-A"),
        Course(title: "Unity 5 게임 제작 CAMP", imageName: "course2", startDate: Date(), endDate: Date(), tags: ["iOS", "Swift4"], location: "리틀스타 10-A"),
        Course(title: "JavaScript 정복 프로젝트 CAMP", imageName: "course3", startDate: Date(), endDate: Date(), tags: ["iOS", "Swift4"], location: "리틀스타 10-A"),
        Course(title: "Node.js로 구현하는 쇼핑몰 프로젝트 CAMP", imageName: "course4", startDate: Date(), endDate: Date(), tags: ["iOS", "Swift4"], location: "리틀스타 10-A")
]
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
    
    @IBOutlet weak var courseCollectionView: UICollectionView!
    
    var timer: DispatchSourceTimer?
    
    lazy var df: DateFormatter = {
        let f = DateFormatter()
        f.dateFormat = "M월 d일(E)"
        
        return f
    }()
    
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
        switch collectionView {
        case bannerCollectionView:
            return 10000
        case courseCollectionView:
            return courseList.count
        default:
            return 0
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case bannerCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BannerCollectionViewCell.identifier, for: indexPath) as! BannerCollectionViewCell
            
            let imageName = "banner\(indexPath.row % 5)"
            cell.bannerImageView.image = UIImage(named: imageName)
            
            return cell
        case courseCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CourseCollectionViewCell.identifier, for: indexPath) as! CourseCollectionViewCell
            
            let course = courseList[indexPath.item]
            
            cell.courseImageView.image = UIImage(named: course.imageName)
            cell.courseNameLabel.text = course.title
            
            if let start = df.string(for: course.startDate), let end = df.string(for: course.endDate) {
                cell.periodLabel.text = "\(start) ~ \(end)"
            }
            
            cell.tagLabel.text = "#" + course.tags.joined(separator: " #")
            cell.locationLabel.text = course.location
            
            return cell
        default:
            fatalError()
        }
        
    }
    
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView {
        case bannerCollectionView:
            return collectionView.frame.size
        case courseCollectionView:
            guard let layout = collectionViewLayout as? UICollectionViewFlowLayout else {
                return CGSize.zero
            }
            
            let width = (collectionView.bounds.width - (layout.sectionInset.left + layout.sectionInset.right + layout.minimumInteritemSpacing)) / 2
            
            return CGSize(width: width, height: width * 1.5)
        default:
            return CGSize.zero
        }
    }
}






























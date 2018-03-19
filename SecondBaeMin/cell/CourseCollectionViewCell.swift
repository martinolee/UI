//
//  CourseCollectionViewCell.swift
//  SecondBaeMin
//
//  Created by 이수한 on 2018. 3. 19..
//  Copyright © 2018년 이수한. All rights reserved.
//

import UIKit

class CourseCollectionViewCell: UICollectionViewCell {
    static let identifier = "CourseCollectionViewCell"
    
    @IBOutlet weak var courseImageView: UIImageView!
    @IBOutlet weak var courseNameLabel: UILabel!
    @IBOutlet weak var periodLabel: UILabel!
    @IBOutlet weak var tagLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
}

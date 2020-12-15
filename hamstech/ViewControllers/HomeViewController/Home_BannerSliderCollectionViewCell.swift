//
//  Home_BannerSliderCollectionViewCell.swift
//  hamstech
//
//  Created by Priyanka on 29/05/20.
//

import UIKit

class Home_BannerSliderCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var bannerImage: UIImageView!
    
}

class CourseCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var courceImg: UIImageView!
    
    @IBOutlet weak var courceLbl: UILabel!
//    @IBOutlet weak var courseImageView: UIImageView!
//
//    @IBOutlet weak var courseLabel: UILabel!
    
}

class MentorCollectionViewCell: UICollectionViewCell {
    

    @IBOutlet weak var mentorImages: UIImageView!
    @IBOutlet weak var mentorLabel: UILabel!
    
}

class WhyHamstechCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var hamstechCellView: UIView!
    @IBOutlet weak var leading: NSLayoutConstraint!
    @IBOutlet weak var trailing: NSLayoutConstraint!
    @IBOutlet weak var whyHamstechImg: UIImageView!
}

class PlacementsCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var placementImg: UIImageView!
    
}


class Home_AffliationCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var affliationImg: UIImageView!
    
}

class TestimonialsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var TestimonialsShadowView: UIView!
    @IBOutlet weak var testimonialImage: UIImageView!
    
    @IBOutlet weak var testimonialTitle: UILabel!
    
    @IBOutlet weak var testimonialPosition: UILabel!
    
    @IBOutlet weak var testimonialDescription: UILabel!
}

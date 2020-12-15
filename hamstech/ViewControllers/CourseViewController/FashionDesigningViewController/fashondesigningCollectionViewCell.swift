//
//  fashondesigningCollectionViewCell.swift
//  hamstech
//
//  Created by Priyanka on 08/05/20.
//

import UIKit

class fashondesigningCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var fashonLbl: UILabel!
    
}

class CoursesCell1: UITableViewCell {
    
    @IBOutlet weak var coucesLbl: UILabel!
}

class CoursesCell2: UICollectionViewCell {
    
}

class PlacementCell: UICollectionViewCell {
    
    @IBOutlet weak var placementImg: UIImageView!
}

class AfflicationsCell: UICollectionViewCell {
    
}

class TestimonialsCell: UICollectionViewCell {
    @IBOutlet weak var TestimonialsShadowView: UIView!
    @IBOutlet weak var courseTestimonialImage: UIImageView!
    @IBOutlet weak var courseTestimonialDescription: UILabel!
    @IBOutlet weak var courseTestimonialTitle: UILabel!
    @IBOutlet weak var courseTestimonialPosition: UILabel!
}


class WhyHamstech: UICollectionViewCell {
    
    @IBOutlet weak var hamstechCellView: UIView!
  //  @IBOutlet weak var hamstechCellImg: UIImageView!
    
    @IBOutlet weak var leading: NSLayoutConstraint!
    
    @IBOutlet weak var trailing: NSLayoutConstraint!
    @IBOutlet weak var img: UIImageView!
    
    
}

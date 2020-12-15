//
//  RegistercoursesCell.swift
//  hamstech
//
//  Created by Priyanka on 25/05/20.
//

import UIKit

class RegistercoursesCell: UITableViewCell {

    @IBOutlet weak var courses_Lbl: UILabel!
    @IBOutlet weak var selsect_But: UIButton!
    @IBOutlet weak var arrrow_Img: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}


class RegisterSubcoursesCell: UITableViewCell {
    @IBOutlet weak var subcourse_Lbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

//
//  sidemenuTableViewCell.swift
//  hamstech
//
//  Created by Priyanka on 11/05/20.
//

import UIKit

class sidemenuTableViewCell: UITableViewCell {

    @IBOutlet weak var section_Lbl: UILabel!
    @IBOutlet weak var sidemenu_Img: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}


class sidemenuTableViewCell1: UITableViewCell {

    @IBOutlet weak var expand_Lbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

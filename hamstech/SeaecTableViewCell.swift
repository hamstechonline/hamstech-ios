//
//  SeaecTableViewCell.swift
//  hamstech
//
//  Created by Priyanka on 20/06/20.
//

import UIKit

class SeaecTableViewCell: UITableViewCell {
    
    @IBOutlet weak var back_View: UIView!
    @IBOutlet weak var search_Lbl: UILabel!
    @IBOutlet weak var search_Img: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

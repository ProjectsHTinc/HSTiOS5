//
//  ConstituentCell.swift
//  Constituent
//
//  Created by Happy Sanz Tech on 18/06/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import UIKit

class ConstituentCell: UITableViewCell {

    @IBOutlet var constituentImage: UIImageView!
    @IBOutlet var name: UILabel!
    @IBOutlet var serialnumber: UILabel!
    @IBOutlet var dob: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

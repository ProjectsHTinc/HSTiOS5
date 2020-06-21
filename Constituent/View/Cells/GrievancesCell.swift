//
//  GrievancesCell.swift
//  Constituent
//
//  Created by Happy Sanz Tech on 21/06/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import UIKit

class GrievancesCell: UITableViewCell {

    @IBOutlet var pettionNumber: UILabel!
    @IBOutlet var grievanceName: SideRoundedCornerLabel!
    @IBOutlet var refernceNote: UILabel!
    @IBOutlet var refernceDescripition: UILabel!
    @IBOutlet var greivanceStatus: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

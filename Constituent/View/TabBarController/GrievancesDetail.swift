//
//  GrievancesDetail.swift
//  Constituent
//
//  Created by Happy Sanz Tech on 21/06/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import UIKit

class GrievancesDetail: UIViewController {
    
    var seeker_Type = String()
    var pettion_Number = String()
    var grievance_Name = String()
    var subCat_Name = String()
    var descripition_Text = String()
    var _refernce = String()
    var _titlePE = String()


    @IBOutlet var constituencyName: UILabel!
    @IBOutlet var seekerType: UILabel!
    @IBOutlet var pettionNumber: UILabel!
    @IBOutlet var grievanceName: UILabel!
    @IBOutlet var subCatName: UILabel!
    @IBOutlet var descripitionText: UILabel!
    @IBOutlet var refernce: UILabel!
    @IBOutlet var status: SideRoundedCornerLabel!
    @IBOutlet var titlePE: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.addCustomizedBackBtn(title:"  List of Grievance")
        self.titlePE.text = _titlePE
        self.constituencyName.text = GlobalVariables.shared.selectedConstituencyName
        self.seekerType.text = seeker_Type
        self.pettionNumber.text = pettion_Number
        self.grievanceName.text = grievance_Name
        self.subCatName.text = subCat_Name
        self.descripitionText.text = descripition_Text
        self.refernce.text = _refernce
        
        if self.status.text == "PROCESSING"
        {
            self.seekerType.textColor = UIColor(red: 242.0/255, green: 37.0/255, blue: 93.0/255, alpha: 1.0)
            self.status.backgroundColor =  UIColor(red: 253.0/255, green: 166.0/255, blue: 68.0/255, alpha: 1.0)
        }
        else if self.status.text == "COMPLETED"
        {
            self.seekerType.textColor = UIColor(red: 242.0/255, green: 37.0/255, blue: 93.0/255, alpha: 1.0)
            self.status.backgroundColor =  UIColor(red: 54.0/255, green: 214.0/255, blue: 107.0/255, alpha: 1.0)
        }
        else
        {
            self.seekerType.textColor = UIColor(red: 242.0/255, green: 37.0/255, blue: 93.0/255, alpha: 1.0)
            self.status.backgroundColor =  UIColor(red: 253.0/255, green: 166.0/255, blue: 68.0/255, alpha: 1.0)
        }

    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

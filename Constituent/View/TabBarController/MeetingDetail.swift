//
//  MeetingDetail.swift
//  Constituent
//
//  Created by Happy Sanz Tech on 22/06/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import UIKit

class MeetingDetail: UIViewController {

    var meeting_Title = String()
    var meeting_Discrption = String()
    var meeting_Date = String()
    var meetingCreateDate = String()
    var from = String()

    @IBOutlet weak var statusView: UIView!
    @IBOutlet var meetingTitle: UILabel!
    @IBOutlet var meetingDiscrption: UITextView!
    @IBOutlet var meetingDate: UILabel!
    @IBOutlet weak var statusLbl: UILabel!
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var meetCreteDate: UILabel!
    @IBOutlet weak var shadowNavView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        /*Set Values*/
//        self.addCustomizedBackBtn(title:"  Details of Meeting")
        self.title = "Details of Meeting"
        self.meetingTitle.text = meeting_Title.capitalized
        self.meetingDiscrption.text = meeting_Discrption.capitalized
        self.meetCreteDate.text = meetingCreateDate
        shadowNavView.layer.cornerRadius = 6
        shadowNavView.layer.shadowColor = UIColor.darkGray.cgColor
        shadowNavView.layer.shadowOpacity = 1.0
        shadowNavView.layer.shadowOffset = CGSize.zero
        shadowNavView.layer.shadowRadius = 3
        self.navigationController?.navigationBar.layer.masksToBounds = false
        self.navigationController?.navigationBar.layer.shadowColor = UIColor.lightGray.cgColor
        self.navigationController?.navigationBar.layer.shadowOpacity = 0.5
        self.navigationController?.navigationBar.layer.shadowOffset = CGSize(width: 0, height: 3.0)
        self.navigationController?.navigationBar.layer.shadowRadius = 3
        self.view.isHidden = false
        UINavigationBar.appearance().shadowImage = UIImage()
        
        if from == "schedule" {
            statusView.backgroundColor = UIColor(red: 255.0/255, green: 116.0/255, blue: 0.0/255, alpha: 1.0)
            statusLbl.text = "Schedule"
            self.meetingDate.text =  String(format: "%@ %@", "Meeting Date :",meeting_Date)
        }
        else if from == "completed" {
            statusView.backgroundColor = UIColor(red: 67.0/255, green: 191.0/255, blue: 87.0/255, alpha: 1.0)
            statusLbl.text = "Completed"
            self.meetingDate.text =  String(format: "%@ %@", "Meeting Date :",meeting_Date)
        }
        else if from == "requested" {
            statusView.backgroundColor = UIColor(red: 248.0/255, green: 194.0/255, blue: 45.0/255, alpha: 1.0)
            statusLbl.text = "Requested"
        }
        
        backView.layer.cornerRadius = 6
        backView.layer.shadowColor = UIColor.darkGray.cgColor
        backView.layer.shadowOpacity = 0.5
        backView.layer.shadowOffset = CGSize.zero
        backView.layer.shadowRadius = 3
    }
}

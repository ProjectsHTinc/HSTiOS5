//
//  NotificationDetail.swift
//  Constituent
//
//  Created by Happy Sanz Tech on 22/06/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import UIKit

class NotificationDetail: UIViewController {
    
    var notification_Date = String()
    var notification_Time = String()
    var notification_Text = String()

    @IBOutlet var notificationDate: UILabel!
    @IBOutlet var notificationTime: UILabel!
    @IBOutlet var notificationText: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.notificationDate.text = notification_Date
        self.notificationTime.text = notification_Time
        self.notificationText.text = notification_Text

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

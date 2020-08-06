//
//  Notification.swift
//  Constituent
//
//  Created by Happy Sanz Tech on 22/06/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import UIKit

class Notification: UIViewController {

    let notificationPresener = NotificationPresenter(notificationService: NotificationService())
    var notificationData = [NotifiationData]()
    
    var notification_Date = String()
    var notification_Time = String()
    var notification_Text = String()
    
    @IBOutlet var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        guard checkInterConnection () else {
            return
        }
        self.view.isHidden = false
        self.view.backgroundColor = UIColor.white
        //self.navigationItem.title = "Notification"
        self.addCustomizedBackBtn(title:"  Notification")
        /*set delegates*/
        self.tableView?.delegate = self
        self.tableView?.dataSource = self
        self.tableView?.backgroundColor = .white
        /*Call API*/
        self.callAPI()
    }
    
    func checkInterConnection () -> Bool
    {
        guard Reachability.isConnectedToNetwork() == true else{
              self.view.isHidden = true
              AlertController.shared.offlineAlert(targetVc: self, complition: {
                //Custom action code
             })
              return false
        }
              return true
    }
    
    func callAPI ()
    {
         notificationPresener.attachView(view: self)
         notificationPresener.getNotifiation(user_id: GlobalVariables.shared.user_id)
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if (segue.identifier == "to_NotificationDetails")
        {
            let vc = segue.destination as! NotificationDetail
            vc.notification_Date = notification_Date
            vc.notification_Time = notification_Time
            vc.notification_Text = notification_Text
        }
    }
    

}

extension Notification: UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notificationData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
         let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! NotificationCell
         let data = notificationData[indexPath.row]
         cell.notificationTime.text = data.created_time
         cell.notificationText.text = data.notification_text.capitalized
         return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
         return 102
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
         let data = notificationData[indexPath.row]
         self.notification_Date = data.created_at
         self.notification_Time = data.created_time
         self.notification_Text = data.notification_text
         self.performSegue(withIdentifier: "to_NotificationDetails", sender: self)
    }
    
}

extension Notification: NotificationView
{
    func startLoading() {
         
        self.view.activityStartAnimating()
    }
    
    func finishLoading() {
        
        self.view.activityStopAnimating()
    }
    
    func setNotification(notification: [NotifiationData]) {
         
         notificationData = notification
         self.tableView?.isHidden = false
         self.tableView?.reloadData()
    }
    
    func setEmpty(errorMessage: String) {
          AlertController.shared.showAlert(targetVc: self, title: Globals.alertTitle, message: errorMessage, complition: {
          })
         self.tableView.isHidden = true
    }
    
}

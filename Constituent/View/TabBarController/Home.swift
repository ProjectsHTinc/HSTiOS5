//
//  Home.swift
//  Constituent
//
//  Created by Happy Sanz Tech on 19/06/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import UIKit

class Home: UIViewController {

    var presenterProfile = ProfilePresenter(profileService: ProfileService())
    var profiledata = [ProfileData]()
    
    @IBOutlet var baseView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let navigationBar = navigationController!.navigationBar
        navigationBar.tintColor = UIColor.black
        // Do any additional setup after loading the view.
        /*Check Internet Connection*/
        let dynamic_db = UserDefaults.standard.object(forKey:"dynamicDBKey") ?? ""
        
        if dynamic_db as! String == ""
        {
 
        }
        else {
            GlobalVariables.shared.dynamic_Db = UserDefaults.standard.object(forKey: "dynamicDBKey") as! String
            print(GlobalVariables.shared.dynamic_Db)
        }
        
        guard checkInterConnection () else {
            return
        }
//        self.baseView.isHidden = false
        self.navigationItem.title = String(format: "%@ - %@", "GMS",GlobalVariables.shared.user_name)
        /*Add right navigation button*/
        self.addrightButton(bg_ImageName:"bell")
        addCustomizedBackBtn(title: "Home")
        self.nameLabel.text = GlobalVariables.shared.user_name
        self.callAPI()
        let tabBar = self.tabBarController!.tabBar
        tabBar.selectionIndicatorImage = UIImage().createSelectionIndicator(color: UIColor.black, size: CGSize(width: tabBar.frame.width/CGFloat(tabBar.items!.count), height:  tabBar.frame.height), lineThickness: 5.0, side: .top)
    }
        
    func checkInterConnection () -> Bool
    {
        guard Reachability.isConnectedToNetwork() == true else{
              self.baseView.isHidden = true
              AlertController.shared.offlineAlert(targetVc: self, complition: {
                //Custom action code
             })
              return false
        }
              return true
    }
    
    func callAPI ()
    {
         presenterProfile.attachView(view: self)
         presenterProfile.getProfile(user_id: GlobalVariables.shared.user_id,dynamic_db:GlobalVariables.shared.dynamic_Db)
    }
    
    @objc public override func rightButtonClick()
    {
        self.performSegue(withIdentifier: "to_Notification", sender: self)
    }
    
    @IBAction func grievanceAction(_ sender: Any) {
        self.performSegue(withIdentifier: "to_Meeting", sender: self)
    }
    
    @IBAction func meetingAction(_ sender: Any) {
      
        self.performSegue(withIdentifier: "to_GrievnacesList", sender: self)
    }
    
//    @IBAction func plantDonationAction(_ sender: Any) {
//        self.performSegue(withIdentifier: "to_PlantDonation", sender: self)
//    }
//
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if (segue.identifier == "to_GrievnacesList"){
            let _ = segue.destination as! Grievances
        }
    }
}

extension Home :ProfileView
{
    func startLoading() {
         self.view.activityStartAnimating()
    }
    
    func finishLoading() {
    }
    
    func setProfile(profile: [ProfileData]) {
         profiledata = profile
         self.view.activityStopAnimating()
    }
    
    func setEmpty(errorMessage: String) {
         AlertController.shared.showAlert(targetVc: self, title: Globals.alertTitle, message: errorMessage, complition: {
         })
    }
}

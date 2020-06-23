//
//  Profile.swift
//  Constituent
//
//  Created by Happy Sanz Tech on 19/06/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import UIKit
import SDWebImage

class Profile: UIViewController {
    
    var presenterProfile = ProfilePresenter(profileService: ProfileService())
    var profiledata = [ProfileData]()
    
    @IBOutlet var userImageView: UIImageView!
    @IBOutlet var userName: UILabel!
    @IBOutlet var userNumber: UILabel!
    @IBOutlet var segmentControl: UISegmentedControl!
    @IBOutlet var containerViewOne: UIView!
    @IBOutlet var containerViewTwo: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        guard checkInterConnection () else {
            return
        }
        self.view.isHidden = false
        self.navigationItem.title = "Profile"
        self.setUpControl ()
        self.callAPI()
//        self.containerViewOne.isHidden = true

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
         presenterProfile.attachView(view: self)
         presenterProfile.getProfile(user_id: GlobalVariables.shared.user_id)
    }
    
    func setUpControl ()
    {
         segmentControl.selectedSegmentIndex = 0
         segmentControl.backgroundColor = .white
         segmentControl.tintColor = .white
         segmentControl.setTitleTextAttributes([
             NSAttributedString.Key.font : UIFont(name: "Roboto-Regular", size: 13) as Any,
             NSAttributedString.Key.foregroundColor: UIColor.black
             ], for: .normal)

         segmentControl.setTitleTextAttributes([
             NSAttributedString.Key.font : UIFont(name: "Roboto-Regular", size: 13) as Any,
             NSAttributedString.Key.foregroundColor: UIColor.white
         ], for: .selected)
    }
    
    @IBAction func segmentAction(_ sender: Any) {
        if (segmentControl.selectedSegmentIndex == 0)
        {
            self.containerViewOne.isHidden = false
            self.containerViewTwo.isHidden = true
        }
        else
        {
            self.containerViewOne.isHidden = true
            self.containerViewTwo.isHidden = false
        }
    }
    
    
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        if (segue.identifier == "Embed")
        {
            let _ = segue.destination as! ProfileDetails
        }
    }
    

}

extension Profile :ProfileView
{
    func startLoading() {
         self.view.activityStartAnimating()
    }
    
    func finishLoading() {
         self.view.activityStopAnimating()
    }
    
    func setProfile(profile: [ProfileData]) {
         profiledata = profile
         self.userImageView.sd_setImage(with: URL(string: profiledata[0].profile_picture), placeholderImage: UIImage(named: "placeholderNewsfeed.png"))
         self.userName.text = profiledata[0].full_name
         self.userNumber.text = profiledata[0].serial_no
         self.containerViewTwo.isHidden = true
         self.containerViewOne.isHidden = false
    }
    
    func setEmpty(errorMessage: String) {
         AlertController.shared.showAlert(targetVc: self, title: Globals.alertTitle, message: errorMessage, complition: {
         })
        self.userName.text = "-"
        self.userNumber.text = "-"
        
    }
    
    
}

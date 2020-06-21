//
//  Home.swift
//  Constituent
//
//  Created by Happy Sanz Tech on 19/06/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import UIKit

class Home: UIViewController {

    @IBOutlet var baseView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        /*Check Internet Connection*/
        guard checkInterConnection () else {
            return
        }
        self.baseView.isHidden = false
        self.navigationItem.title = String(format: "%@ - %@", "GMS",GlobalVariables.shared.user_name)
        /*Add right navigation button*/
        self.addrightButton(bg_ImageName:"bell")

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
    
    @objc public override func rightButtonClick()
    {
        
    }
    
    @IBAction func grievanceAction(_ sender: Any) {
        self.performSegue(withIdentifier: "to_GrievnacesList", sender: self)
    }
    
    @IBAction func meetingAction(_ sender: Any) {
    }
    
    @IBAction func plantDonationAction(_ sender: Any) {
    }
    

    
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

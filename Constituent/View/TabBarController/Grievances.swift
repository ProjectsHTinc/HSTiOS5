//
//  Grievances.swift
//  Constituent
//
//  Created by Happy Sanz Tech on 20/06/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import UIKit

class Grievances: UIViewController {
    
    let grievancePresener = GrievancesPresenter(grivencesService: GrivencesService())
    var grievanceData = [GrievanceData]()
    
    var seeker_Type = String()
    var pettion_Number = String()
    var grievance_Name = String()
    var subCat_Name = String()
    var descripition_Text = String()
    var _refernce = String()

    @IBOutlet var segmentcontrol: UISegmentedControl!
    @IBOutlet var constitunecyName: UILabel!
    @IBOutlet var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        /*Check Internet Connection*/
        guard checkInterConnection () else {
            return
        }
        self.view.isHidden = false
        self.navigationItem.title = "List Of Grievance"
        self.constitunecyName.text = GlobalVariables.shared.selectedConstituencyName
        /*set delegates*/
        self.tableView?.delegate = self
        self.tableView?.dataSource = self
        /*Setup SegmentControl*/
        self.setUpSegmentControl ()
        /*Call API*/
        self.callPettitionService (type:"P")
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
    
    func setUpSegmentControl ()
    {

        segmentcontrol.selectedSegmentIndex = 0
        segmentcontrol.backgroundColor = .white
        segmentcontrol.tintColor = .white
        segmentcontrol.setTitleTextAttributes([
            NSAttributedString.Key.font : UIFont(name: "Roboto-Regular", size: 13) as Any,
            NSAttributedString.Key.foregroundColor: UIColor.black
            ], for: .normal)

        segmentcontrol.setTitleTextAttributes([
            NSAttributedString.Key.font : UIFont(name: "Roboto-Regular", size: 13) as Any,
            NSAttributedString.Key.foregroundColor: UIColor.white
        ], for: .selected)
    }

    @IBAction func segmentaction(_ sender: Any)
    {
        if segmentcontrol.selectedSegmentIndex == 0
        {
            self.callPettitionService(type: "P")
        }
        else
        {
            self.callPettitionService(type: "E")
        }
    }
    
    func callPettitionService (type:String)
    {
        grievancePresener.attachView(view: self)
        grievancePresener.getGrievances(user_id: GlobalVariables.shared.user_id, type: type)
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if (segue.identifier == "to_GrievanceDetail")
        {
            let vc = segue.destination as! GrievancesDetail
            vc.seeker_Type = seeker_Type
            vc.pettion_Number = pettion_Number
            vc.grievance_Name = grievance_Name
            vc.subCat_Name = subCat_Name
            vc.descripition_Text = descripition_Text
            vc._refernce = _refernce

        }
    }
    

    
}
extension Grievances: UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return grievanceData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! GrievancesCell
        let data = grievanceData[indexPath.row]
        cell.pettionNumber.text = data.petition_enquiry_no
        cell.grievanceName.text = data.grievance_name
        cell.refernceNote.text = data.reference_note
        cell.refernceDescripition.text = data.description
        cell.greivanceStatus.text = data.status
        
        if cell.grievanceName.text == "IDENTITY CORRECTIONS" && cell.greivanceStatus.text == "PROCESSING"
        {
            cell.grievanceName.backgroundColor = UIColor(red: 242.0/255, green: 37.0/255, blue: 93.0/255, alpha: 1.0)
            cell.greivanceStatus.backgroundColor =  UIColor(red: 253.0/255, green: 166.0/255, blue: 68.0/255, alpha: 1.0)
        }
        else if cell.grievanceName.text == "PUBLIC GRIEVANCE " && cell.greivanceStatus.text == "COMPLETED"
        {
            cell.grievanceName.backgroundColor = UIColor(red: 242.0/255, green: 37.0/255, blue: 93.0/255, alpha: 1.0)
            cell.greivanceStatus.backgroundColor =  UIColor(red: 54.0/255, green: 214.0/255, blue: 107.0/255, alpha: 1.0)
        }
        else
        {
            cell.grievanceName.backgroundColor = UIColor(red: 32.0/255, green: 128.0/255, blue: 152.0/255, alpha: 1.0)
            cell.greivanceStatus.backgroundColor =  UIColor(red: 253.0/255, green: 166.0/255, blue: 68.0/255, alpha: 1.0)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 184
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = grievanceData[indexPath.row]
        self.seeker_Type = data.seeker_info
        self.pettion_Number = data.petition_enquiry_no
        self.grievance_Name = data.grievance_name
        self.subCat_Name = data.sub_category_name
        self.descripition_Text = data.description
        self._refernce = data.reference_note
        self.performSegue(withIdentifier: "to_GrievanceDetail", sender: self)
    }
    
}

extension Grievances: GrievanceView
{
    func startLoadingGrievance() {
    }
    
    func finishLoadingGrievance() {
    }
    
    func setBannerGrievance(grievance_Data: [GrievanceData]) {
         grievanceData = grievance_Data
         self.tableView?.reloadData()
    }
    
    func setEmptyGrievance(errorMessage: String) {
          AlertController.shared.showAlert(targetVc: self, title: Globals.alertTitle, message: errorMessage, complition: {
          })
         self.tableView.isHidden = true
    }
    
    
}

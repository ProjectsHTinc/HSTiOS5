//
//  Grievances.swift
//  Constituent
//
//  Created by Happy Sanz Tech on 20/06/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import UIKit
import HMSegmentedControl

class Grievances: UIViewController {
    
    let grievancePresener = GrievancesPresenter(grivencesService: GrivencesService())
    var grievanceData = [GrievanceData]()
    var seeker_Type = String()
    var titleArr = [String]()
    var pettion_Number = String()
    var grievance_Name = String()
    var subCat_Name = String()
    var descripition_Text = String()
    var _refernce = String()
    var _Status = String()
    var _grevType = String()
    var segmentedControl = HMSegmentedControl()
    
    
//    @IBOutlet var segmentcontrol: UISegmentedControl!
    @IBOutlet var constitunecyName: UILabel!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var segmentView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        /*Check Internet Connection*/
        guard checkInterConnection () else {
            return
        }
        segmentView.addShadow(offset: CGSize.init(width: 0, height: 2), color: UIColor.gray, radius: 2.0, opacity: 0.35)
        titleArr = ["PETITION","ENQUIRY"]
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.view.isHidden = false
//        self.addCustomizedBackBtn(title:"  Grievance")
        self.constitunecyName.text = GlobalVariables.shared.constituency_name
        /*set delegates*/
        self.tableView?.delegate = self
        self.tableView?.dataSource = self
        /*Setup SegmentControl*/
        self.setUpSegementControl ()
        /*Call API*/
        self.callPettitionService (type:"P")
        let navigationBar = navigationController!.navigationBar
        navigationBar.tintColor = UIColor.black
    }
        
    func checkInterConnection () -> Bool
    {
        guard Reachability.isConnectedToNetwork() == true else {
              self.view.isHidden = true
              AlertController.shared.offlineAlert(targetVc: self, complition: {
                //Custom action code
             })
              return false
        }
        return true
    }
    
    
    func setUpSegementControl ()
    {
        segmentedControl = HMSegmentedControl(sectionTitles: self.titleArr)
        segmentedControl.autoresizingMask = [.flexibleRightMargin, .flexibleWidth]
        segmentedControl.frame = CGRect(x: 0, y: 0, width: self.segmentView.frame.width, height: 50)
        segmentedControl.addTarget(self, action: #selector(segmentedControlChangedValue(segmentedControl:)), for: .valueChanged)
        segmentView.addSubview(segmentedControl)
        segmentedControl.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.lightGray]
        segmentedControl.selectedTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        segmentedControl.selectionStyle = HMSegmentedControlSelectionStyle.fullWidthStripe
        segmentedControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocation.bottom
        segmentedControl.segmentWidthStyle = HMSegmentedControlSegmentWidthStyle.fixed
        segmentedControl.selectionIndicatorHeight = 3.5
        segmentedControl.selectionIndicatorColor = UIColor.black
        segmentedControl.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Roboto-Bold", size: 13.0)!]
    }
    
    @objc func segmentedControlChangedValue(segmentedControl: HMSegmentedControl) {
        
        if segmentedControl.selectedSegmentIndex == 0
        {
            self.callPettitionService(type: "p")
        }
        else
        {
            self.callPettitionService(type: "E")
        }
        
    }
//    func setUpSegmentControl ()
//    {
////        segmentcontrol.selectedSegmentIndex = 0
////        segmentcontrol.backgroundColor = .white
////        segmentcontrol.tintColor = .white
////        segmentcontrol.setTitleTextAttributes([
////            NSAttributedString.Key.font : UIFont(name: "Roboto-Regular", size: 13) as Any,
////            NSAttributedString.Key.foregroundColor: UIColor.black
////            ], for: .normal)
//
//        let titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
//        let titleTextAttributes1 = [NSAttributedString.Key.foregroundColor: UIColor.lightGray]
//        segmentcontrol.setTitleTextAttributes(titleTextAttributes1, for: .normal)
//        segmentcontrol.setTitleTextAttributes(titleTextAttributes, for: .selected)
//
////        segmentcontrol.setTitleTextAttributes([
////            NSAttributedString.Key.font : UIFont(name: "Roboto-Regular", size: 13) as Any,
//////            NSAttributedString.Key.foregroundColor: UIColor.white
////        ], for: .selected)
//    }

//    @IBAction func segmentaction(_ sender: Any)
//    {
//
//    }
    
    func callPettitionService (type:String)
    {
        grievancePresener.attachView(view: self)
        grievancePresener.getGrievances(user_id: GlobalVariables.shared.user_id, type: type,dynamic_db:GlobalVariables.shared.dynamic_Db)
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
                vc._Status = _Status
                vc._titlePE = "Pettition Number"
                vc._grevType = self._grevType
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
        if segmentedControl.selectedSegmentIndex == 0
        {
            let data = grievanceData[indexPath.row]
            //let grievance_type = data.grievance_type
            cell.pettionNumber.text = String(format: "%@ %@", "Pettion Number - ",data.petition_enquiry_no)
            cell.grievanceName.text = data.grievance_name.capitalized
            cell.subCategoery.text = data.sub_category_name.capitalized
            cell.status.text = data.status.capitalized
            cell.date.text = data.grievance_date
            cell.petionImage.image = UIImage(named:"petition")
            if cell.status.text == "Processing" || cell.status.text == "Requested"
            {
                cell.status.backgroundColor =  UIColor(red: 253.0/255, green: 166.0/255, blue: 68.0/255, alpha: 1.0)
            }
            else if data.status == "PENDING" {
                cell.status.backgroundColor =  UIColor(red: 255.0/255, green: 166.0/255, blue: 0.0/255, alpha: 1.0)
            }
            else
            {
                  cell.status.backgroundColor =  UIColor(red: 54.0/255, green: 214.0/255, blue: 107.0/255, alpha: 1.0)
            }
        }
        else
        {
            let data = grievanceData[indexPath.row]
            //let grievance_type = data.grievance_type
            cell.pettionNumber.text = String(format: "%@ %@", "Enquiry Number - ",data.petition_enquiry_no)
            cell.grievanceName.text = data.grievance_name.capitalized
            cell.subCategoery.text = data.sub_category_name.capitalized
            cell.status.text = data.status.capitalized
            cell.date.text = data.grievance_date
            cell.petionImage.image = UIImage(named:"enquiry")
            if cell.status.text == "Processing" || cell.status.text == "Requested"
            {
                cell.status.backgroundColor =  UIColor(red: 253.0/255, green: 166.0/255, blue: 68.0/255, alpha: 1.0)
            }
            else if data.status == "PENDING" {
                cell.status.backgroundColor =  UIColor(red: 255.0/255, green: 166.0/255, blue: 0.0/255, alpha: 1.0)
            }
            else
            {
                  cell.status.backgroundColor =  UIColor(red: 54.0/255, green: 214.0/255, blue: 107.0/255, alpha: 1.0)
            }
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
        self.descripition_Text = data.description.capitalizingFirstLetter()
        self._refernce = data.reference_note
        self._Status = data.status
        self._grevType = data.grievance_type
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
         self.tableView.isHidden = false
         self.tableView?.reloadData()
    }
    
    func setEmptyGrievance(errorMessage: String) {
          AlertController.shared.showAlert(targetVc: self, title: Globals.alertTitle, message: errorMessage, complition: {
          })
         self.tableView.isHidden = true
    }
}

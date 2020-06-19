//
//  ConstituentList.swift
//  Constituent
//
//  Created by Happy Sanz Tech on 16/06/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import UIKit
import MBProgressHUD

class ConstituencyList: UIViewController, ClientUrlView {
    
    var client = [clientUrlData]()
    var selectedIndex: Int = 0
    var selectedParty_id = String()
    var buttoncheck = String()

    @IBOutlet var tableView: UITableView!
    @IBOutlet var cancelOutlet: UIButton!
    @IBOutlet var okOutlet: UIButton!
    @IBOutlet var activityView: UIActivityIndicatorView!
    @IBOutlet var mainView: RoundedView!
    
    /*Get Constituency List*/
    let presenter = ConstituencyPresenter(constituencyService: ConstituencyService())
    var constituencyNameList = [constituencyData]()
    
    let presenterClientUrl = ClientUrlPresenter(clientUrlService: ClientUrlService())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView?.delegate = self
        tableView?.dataSource = self
        activityView?.hidesWhenStopped = true
        // Do any additional setup after loading the view.
        self.getConstituencyList ()
        self.tableView.backgroundColor = UIColor.white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.presentingViewController?.view.alpha = 0.3
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.presentingViewController?.view.alpha = 1
    }
    
    func getConstituencyList ()
    {
        presenter.attachView(view: self)
        presenter.getconstituencyList(partyID: "1")
        startLoading()
    }
    
    @IBAction func cancelAction(_ sender: Any){
              self.buttoncheck = "cancel"
              self.performSegue(withIdentifier: "to_login", sender: self)
    }
    
    @IBAction func okAction(_ sender: Any) {
        
        guard Reachability.isConnectedToNetwork() == true else{
              AlertController.shared.offlineAlert(targetVc: self, complition: {
                //Custom action code
             })
               return
        }
        
        if GlobalVariables.shared.selectedConstituencyName == ""
        {
            AlertController.shared.showAlert(targetVc: self, title: Globals.alertTitle, message: Globals.ConstituencyAlertMessage, complition: {
                
              })
        }
        else
        {
            self.getCliecntUrl(id:self.selectedParty_id)
        }
                
    }
    
    func getCliecntUrl (id:String)
    {
        presenterClientUrl.attachViewClientUrl(view: self)
        presenterClientUrl.getclientUrl(select_ID: id)
    }
    
    func setclientUrl(clientUrl: [clientUrlData]) {
         client = clientUrl
         let client_api_url = client[0]
         GlobalVariables.shared.CLIENTURL = client_api_url.client_api_url
         self.buttoncheck = "selected"
         self.performSegue(withIdentifier: "to_login", sender: self)
    }
    
    func setEmptyClientUrl(errorMessage: String) {
        AlertController.shared.showAlert(targetVc: self, title: Globals.alertTitle, message: errorMessage, complition: {
            self.dismiss(animated: false, completion: nil)
        })
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        if (segue.identifier == "to_login")
        {
            let vc = segue.destination as! Login
            vc.From =  self.buttoncheck
        }
    }

}

extension ConstituencyList: UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return constituencyNameList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ConstituencyCell
        let constituency = constituencyNameList[indexPath.row]
        cell.name.text = constituency.constituency_name
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 49
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        selectedIndex = indexPath.row;
        let constituency = constituencyNameList[selectedIndex]
        self.selectedParty_id = String (constituency.constituency_id)
        GlobalVariables.shared.selectedConstituencyName = constituency.constituency_name
        print(GlobalVariables.shared.selectedConstituencyName,self.selectedParty_id)
    }

    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .none
    }
}

extension ConstituencyList : ConstituentView {

    func startLoading() {
        // Show your loader
        activityView?.startAnimating()
    }
    
    func finishLoading() {
        // Dismiss your loader
        activityView?.stopAnimating()
    }
    
    func setConstituency(constituencyname: [constituencyData]) {
        constituencyNameList = constituencyname
        tableView?.isHidden = false
        mainView.isHidden = false
        tableView?.reloadData()
    }
    
    func setEmptyConstituency(errorMessage:String) {
        AlertController.shared.showAlert(targetVc: self, title: Globals.alertTitle, message: errorMessage, complition: {
            self.dismiss(animated: false, completion: nil)
        })
        tableView?.isHidden = true
        mainView.isHidden = true
    }
    
}





//
//  News.swift
//  Constituent
//
//  Created by Happy Sanz Tech on 19/06/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import UIKit
import SDWebImage

class News: UIViewController {

    var timer: Timer?
    var bannerImageindex = 0
    var inForwardDirection = true
    var news_Image = String()
    var news_title = String()
    var news_Date = String()
    var news_Details = String()

    @IBOutlet var bannerCollectionView: UICollectionView!
    @IBOutlet var tableView: UITableView!
    
    let presenterNewsFeedPage = NewsFeedPresnter(newsFeedService: NewsFeedService())
    let presenterBannerImage = BannerPresenter(bannerImageService: BannerImageService())
    var newsFeed = [NewsFeeddata]()
    var bannerImage = [BannerImagedata]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // Do any additional setup after loading the view.
        self.title = "News"
        /*Add right navigation button*/
        self.addrightButton(bg_ImageName:"bell")
        /*Set Delegate For TableView*/
        tableView?.delegate = self
        tableView?.dataSource = self
        /*Set Delegate For CollectionView*/
        bannerCollectionView?.delegate = self
        bannerCollectionView?.dataSource = self
        /*Set background Color*/
        self.view.backgroundColor = UIColor.white
        self.tableView?.backgroundColor = UIColor.white
        self.bannerCollectionView.backgroundColor = UIColor.white
        self.bannerCollectionView?.isPagingEnabled = true
        
        self.navigationController?.navigationBar.layer.masksToBounds = false
        self.navigationController?.navigationBar.layer.shadowColor = UIColor.lightGray.cgColor
        self.navigationController?.navigationBar.layer.shadowOpacity = 0.5
        self.navigationController?.navigationBar.layer.shadowOffset = CGSize(width: 0, height: 3.0)
        self.navigationController?.navigationBar.layer.shadowRadius = 3
        self.view.isHidden = false
        UINavigationBar.appearance().shadowImage = UIImage()
//        self.addShadowToBar()
//        let tabBar = self.tabBarController!.tabBar
//        tabBar.selectionIndicatorImage = UIImage().createSelectionIndicator(color: UIColor.blue, size: CGSize(width: tabBar.frame.width/CGFloat(tabBar.items!.count), height: tabBar.frame.height), lineWidth: 2.0)
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
             /*Call API*/
             self.callAPI()
             /*set tableview poistion */
             tableView.setContentOffset(.zero, animated: true)
    }
    
    @objc public override func rightButtonClick()
    {
        self.performSegue(withIdentifier: "to_Notification", sender: self)
    }
    
    func startTimer() {
        if timer == nil {
            timer = Timer.scheduledTimer(timeInterval: 6.0, target: self, selector: #selector(scrollToNextCell), userInfo: nil, repeats: true);
        }
    }
    
    @objc func scrollToNextCell()
    {
        //scroll to next cell
        let items = bannerCollectionView.numberOfItems(inSection: 0)
        if (items - 1) == bannerImageindex {
            bannerCollectionView.scrollToItem(at: IndexPath(row: bannerImageindex, section: 0), at: UICollectionView.ScrollPosition.right, animated: true)
        } else if bannerImageindex == 0 {
            bannerCollectionView.scrollToItem(at: IndexPath(row: bannerImageindex, section: 0), at: UICollectionView.ScrollPosition.left, animated: true)
        } else {
            bannerCollectionView.scrollToItem(at: IndexPath(row: bannerImageindex, section: 0), at: UICollectionView.ScrollPosition.centeredHorizontally, animated: true)
        }
        if inForwardDirection {
            if bannerImageindex == (items - 1) {
                bannerImageindex -= 1
                inForwardDirection = false
            } else {
                bannerImageindex += 1
            }
        } else {
            if bannerImageindex == 0 {
                bannerImageindex += 1
                inForwardDirection = true
            } else {
                bannerImageindex -= 1
            }
        }
    }
    
    func callAPI ()
    {
        guard Reachability.isConnectedToNetwork() == true else{
              AlertController.shared.offlineAlert(targetVc: self, complition: {
                //Custom action code
             })
               return
        }
        presenterNewsFeedPage.attachView(view: self)
        presenterBannerImage.attachView(view: self)
        presenterNewsFeedPage.getNewsFeed(user_id: GlobalVariables.shared.user_id,dynamic_db:GlobalVariables.shared.dynamic_Db)
        presenterBannerImage.getBannerImage(user_id:  GlobalVariables.shared.user_id,dynamic_db:GlobalVariables.shared.dynamic_Db)
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        if (segue.identifier == "to_newsfeedDetail")
        {
            let vc = segue.destination as! NewsDetail
            vc.newsImage = self.news_Image
            vc.newsDate = self.news_Date
            vc.newstitle = self.news_title
            vc.newsDetails = self.news_Details
        }
    }
}

extension News: NewsFeedView,BannerImageView
{
    func startLoadingNewsFeed() {
        self.view.activityStartAnimating()
    }
    
    func finishLoadingNewsFeed() {
         self.view.activityStopAnimating()
    }
    
    func setNewsFeed(news_feed: [NewsFeeddata]) {
         newsFeed = news_feed
         self.tableView.isHidden = false
         self.tableView.reloadData()
    }
        
    func setEmptyNewsFeed(errorMessage: String) {
         AlertController.shared.showAlert(targetVc: self, title: Globals.alertTitle, message: errorMessage, complition: {
         })
        self.tableView.isHidden = true

    }
    
    func startLoadingBannerImage() {
        self.view.activityStartAnimating()
    }
    
    func finishLoadingBannerImage() {
         self.view.activityStopAnimating()
    }
    
    func setBannerImage(banner_image: [BannerImagedata]) {
         bannerImage = banner_image
         self.bannerCollectionView.isHidden = false
         self.startTimer()
         self.bannerCollectionView.reloadData()
    }
        
    func setEmptyBannerImage(errorMessage: String) {
         AlertController.shared.showAlert(targetVc: self, title: Globals.alertTitle, message: errorMessage, complition: {
         })
        self.tableView.isHidden = true
        self.bannerCollectionView.isHidden = true

    }
}

extension News: UITableViewDataSource,UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsFeed.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! NewsFeedCell
        let news_feed = newsFeed[indexPath.row]
        cell.newsTitle.text = news_feed.title.capitalized
        cell.hours.attributedText = stringFromHtml(string: news_feed.details)
        cell.newFeedImage.sd_setImage(with: URL(string: news_feed.image_file_name), placeholderImage: UIImage(named: "placeholderNewsfeed.png"))
        cell.dateLbl.text = convertDateFormat(inputDate: news_feed.news_date)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 259
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         
        let news_feed = newsFeed[indexPath.row]
        self.news_Image = news_feed.image_file_name
        self.news_title = news_feed.title
        self.news_Date = news_feed.news_date
        self.news_Details = news_feed.details
        print(news_feed.title,news_feed.news_date,news_feed.details)
        self.performSegue(withIdentifier: "to_newsfeedDetail", sender: self)
    }
}

extension News: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {

   func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
   {
        return bannerImage.count
   }

   func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
   {
        let cell = bannerCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! NewsBannerImageCell
        let banner_image = bannerImage[indexPath.row]
        cell.bannerImage.sd_setImage(with: URL(string: banner_image.banner_image), placeholderImage: UIImage(named: "placeholder.png"))
        return cell
   }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

         return CGSize(width:self.bannerCollectionView.bounds.width, height: self.bannerCollectionView.bounds.height)
    }
//
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets
    {
        return UIEdgeInsets(top: 0,left: 0,bottom: 0,right: 0)
    }
    
    func collectionView(_collectionView: UICollectionView,layout collectionViewLayout: UICollectionViewLayout,minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
            return 0.0
    }
    
    func stringFromHtml(string: String) -> NSAttributedString? {
       do {
           let data = string.data(using: String.Encoding.utf8, allowLossyConversion: true)
           if let d = data {
               let str = try NSAttributedString(data: d,
                                                options: [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html],
                                                documentAttributes: nil)
               return str
           }
       } catch {
       }
       return nil
   }
    
    func convertDateFormat(inputDate: String) -> String {

         let olDateFormatter = DateFormatter()
         olDateFormatter.dateFormat = "dd-MM-yyyy"

         let oldDate = olDateFormatter.date(from: inputDate)

         let convertDateFormatter = DateFormatter()
         convertDateFormatter.dateFormat = "dd MMM"

         return convertDateFormatter.string(from: oldDate!)
    }
    
    func addShadowToBar() {
        let shadowView = UIView(frame: self.navigationController!.navigationBar.frame)
        shadowView.backgroundColor = UIColor.white
        shadowView.layer.masksToBounds = false
        shadowView.layer.shadowOpacity = 0.4 // your opacity
        shadowView.layer.shadowOffset = CGSize(width: 0, height: 2) // your offset
        shadowView.layer.shadowRadius =  4 //your radius
        self.view.addSubview(shadowView)
    }

}

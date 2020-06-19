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

    @IBOutlet var bannerCollectionView: UICollectionView!
    @IBOutlet var tableView: UITableView!
    
    let presenterNewsFeedPage = NewsFeedPresnter(newsFeedService: NewsFeedService())
    let presenterBannerImage = BannerPresenter(bannerImageService: BannerImageService())
    var newsFeed = [NewsFeeddata]()
    var bannerImage = [BannerImagedata]()
    
    var arr = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        /*set navigation title*/
        self.setLeftAlignedNavigationItemTitle(text: String(format:"News"), color: .white, margin: 20)
        /*Set Delegate For TableView*/
        tableView?.delegate = self
        tableView?.dataSource = self
        /*Set Delegate For CollectionView*/
        bannerCollectionView?.delegate = self
        bannerCollectionView?.dataSource = self
        /*Call API*/
        self.callAPI()
        /*Set background Color*/
        self.view.backgroundColor = UIColor.white
        self.tableView?.backgroundColor = UIColor.white
        self.bannerCollectionView.backgroundColor = UIColor.white
        
        arr = ["asdasdasd","asdasdasd","asdasdd"]

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
        presenterNewsFeedPage.attachView(view: self)
        presenterBannerImage.attachView(view: self)
        presenterNewsFeedPage.getNewsFeed(user_id: GlobalVariables.shared.user_id)
        presenterBannerImage.getBannerImage(user_id:  GlobalVariables.shared.user_id)
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
        cell.newsTitle.text = news_feed.title
        cell.hours.text = news_feed.news_date
        cell.newFeedImage.sd_setImage(with: URL(string: news_feed.image_file_name), placeholderImage: UIImage(named: "placeholderNewsfeed.png"))
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 214
    }
    
}

extension News: UICollectionViewDelegate,UICollectionViewDataSource {

   func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
   {
        return bannerImage.count
   }

   func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
   {
        let cell = bannerCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! NewsBannerImageCell
        let banner_image = bannerImage[indexPath.row]
        cell.bannerImage.sd_setImage(with: URL(string: banner_image.gallery_image), placeholderImage: UIImage(named: "placeholder.png"))
        return cell
   }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
         return CGSize(width:self.bannerCollectionView.bounds.width, height: self.bannerCollectionView.bounds.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets
    {
        return UIEdgeInsets(top: 0,left: 0,bottom: 0,right: 0)
    }
}

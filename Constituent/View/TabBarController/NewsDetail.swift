//
//  NewsDetail.swift
//  Constituent
//
//  Created by Happy Sanz Tech on 19/06/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import UIKit
import SDWebImage

class NewsDetail: UIViewController {
    
    var newsImage = String()
    var newstitle = String()
    var newsDate = String()
    var newsDetails = String()

    @IBOutlet var bannerImage: UIImageView!
    @IBOutlet var date: UILabel!
    @IBOutlet var titleNews: UILabel!
    @IBOutlet var detailsNews: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.bannerImage.sd_setImage(with: URL(string: newsImage), placeholderImage: UIImage(named: "placeholderNewsfeed.png"))
        self.titleNews.text = newstitle 
        self.date.text = newsDate
        self.detailsNews.text = newsDetails
        
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

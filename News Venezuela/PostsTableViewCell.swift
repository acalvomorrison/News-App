//
//  PostsTableViewCell.swift
//  News Venezuela
//
//  Created by Andres Calvo on 11/14/17.
//  Copyright © 2017 Andres Calvo. All rights reserved.
//

import UIKit

class PostsTableViewCell: UITableViewCell {
    @IBOutlet weak var descriptionForPost: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var author: UILabel!
    @IBOutlet weak var title: UILabel!
    //@IBOutlet weak var expandNews: customButton!
    @IBOutlet weak var twitterButton: UIButton!
    @IBOutlet weak var facebookButton: UIButton!
    var urlFacebok: String = ""
    var urlTwitter: String = "https://twitter.com/share?status=eltiempo.com.ve/venezuela/feed/"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func facebookButtonClicked(_ sender: Any) {
        UIApplication.shared.openURL(NSURL(string: urlFacebok)! as URL)
    }
    @IBAction func twitterButtonClicked(_ sender: Any) {
        UIApplication.shared.openURL(NSURL(string: urlTwitter)! as URL)
    }
}

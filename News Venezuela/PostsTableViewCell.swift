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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

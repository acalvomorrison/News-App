//
//  HeaderTableViewCell.swift
//  News Venezuela
//
//  Created by Andres Calvo on 11/15/17.
//  Copyright © 2017 Andres Calvo. All rights reserved.
//

import UIKit

class HeaderTableViewCell: UITableViewCell {
    @IBOutlet weak var headerdate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

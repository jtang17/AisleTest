//
//  ListsCell.swift
//  AisleTest
//
//  Created by jonathan tang on 3/16/16.
//  Copyright © 2016 Jonathan Tang. All rights reserved.
//

import UIKit

class ListsCell: UITableViewCell {

    @IBOutlet weak var number: UILabel?
    @IBOutlet weak var names: UILabel?
    
    override func awakeFromNib() {
        

        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

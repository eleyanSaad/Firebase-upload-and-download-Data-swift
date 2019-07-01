//
//  TableViewCell.swift
//  FirebaseExample
//
//  Created by Eleyan Saad on 6/30/19.
//  Copyright © 2019 Eleyan Saad. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var image_adds: UIImageView!
    @IBOutlet weak var lbl_title: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

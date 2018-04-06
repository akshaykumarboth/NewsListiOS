//
//  MyCustomCell.swift
//  newsListApp
//
//  Created by cbzuser on 05/04/18.
//  Copyright © 2018 cbzuser. All rights reserved.
//

import UIKit

class MyCustomCell: UITableViewCell {
    @IBOutlet weak var myView: UIView!
    @IBOutlet weak var myCellLabel: UILabel!
    @IBOutlet weak var myImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}

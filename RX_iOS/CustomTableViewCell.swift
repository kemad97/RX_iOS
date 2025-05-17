//
//  CustomTableViewCell.swift
//  RX_iOS
//
//  Created by Kerolos on 17/05/2025.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var langLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

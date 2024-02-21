//
//  AirLineDropDownTableViewCell.swift
//  FlyGuy
//
//  Created by Mac on 20/03/23.
//

import UIKit

class AirLineDropDownTableViewCell: UITableViewCell {

    @IBOutlet weak var baseView: UIView!
    @IBOutlet weak var airLineNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

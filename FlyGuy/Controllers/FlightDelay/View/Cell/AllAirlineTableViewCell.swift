//
//  AllAirlineTableViewCell.swift
//  FlyGuy
//
//  Created by Mac on 30/03/23.
//

import UIKit

class AllAirlineTableViewCell: UITableViewCell {

    
    @IBOutlet weak var airLineWithCodeNameLabel: UILabel!
    @IBOutlet weak var baseView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

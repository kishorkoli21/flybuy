//
//  CityListCell.swift
//  FlyGuy
//
//  Created by Springup Labs on 23/05/23.
//

import UIKit

class CityListCell: UITableViewCell {

   
    @IBOutlet weak var lblCity: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

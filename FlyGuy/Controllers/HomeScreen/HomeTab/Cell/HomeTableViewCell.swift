//
//  HomeTableViewCell.swift
//  FlyGuy
//
//  Created by Mac on 16/03/23.
//

import UIKit

class HomeTableViewCell: UITableViewCell {

    @IBOutlet weak var baseView: UIView!
    @IBOutlet weak var reportImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor.systemYellow
        selectedBackgroundView = backgroundView
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

//
//  IssueListingiPadTableViewCell.swift
//  FlyGuy
//
//  Created by Mac on 28/03/23.
//

import UIKit

class IssueListingiPadTableViewCell: UITableViewCell {

    @IBOutlet weak var baseView: UIView!
    @IBOutlet weak var issueImageView: UIImageView!
    @IBOutlet weak var issueNameLabel: UILabel!
    @IBOutlet weak var issueDescLabel: UILabel!
    
    @IBOutlet weak var reportedOnView: UIView!
    @IBOutlet weak var flightNumberView: UIView!
    @IBOutlet weak var latenessView: UIView!
    
    @IBOutlet weak var reportedOnDateLabel: UILabel!
    @IBOutlet weak var flightNumberLabel: UILabel!
    @IBOutlet weak var latnessLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        baseView.addShadowForiPadCell()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

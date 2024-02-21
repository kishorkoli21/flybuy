//
//  FlightBookingPassangerInfoCell.swift
//  FlyGuy
//
//  Created by Springup Labs on 06/06/23.
//

import UIKit

class FlightBookingPassangerInfoIpadCell: UITableViewCell {

    
    @IBOutlet weak var lblPassengerName: UILabel!
    @IBOutlet weak var lblType: UILabel!
    @IBOutlet weak var lblTicketNumber: UILabel!
    @IBOutlet weak var viewSeperator: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

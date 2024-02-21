//
//  UpcomingFlightCell.swift
//  FlyGuy
//
//  Created by Springup Labs on 18/05/23.
//

import UIKit

class CancelledFlightIpadCell: UITableViewCell {
    
    @IBOutlet weak var lblOrigin: UILabel!
    @IBOutlet weak var lblDestination: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblFlightStops: UILabel!
    @IBOutlet weak var btnViewDetails: UIButton!
    @IBOutlet weak var imgFlightReturn: UIImageView!
    @IBOutlet weak var lblFlightStatus: UILabel!
    @IBOutlet weak var lblStatusDetails: UILabel!
    
    var shareClosure : (() -> ())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func onSelectViewDetailsClicked(closure: @escaping ()->()) {
        shareClosure = closure
        
    }
    
    
    @IBAction func btnViewDetailsClicked(_ sender: Any) {
        if shareClosure != nil {
            shareClosure!()
        }
    }
}

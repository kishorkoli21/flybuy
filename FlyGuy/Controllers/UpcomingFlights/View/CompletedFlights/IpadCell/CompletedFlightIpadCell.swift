//
//  UpcomingFlightCell.swift
//  FlyGuy
//
//  Created by Springup Labs on 18/05/23.
//

import UIKit

class CompletedFlightIpadCell: UITableViewCell {

    
    @IBOutlet weak var lblOrigin: UILabel!
    @IBOutlet weak var lblDestination: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblFlightStops: UILabel!
    @IBOutlet weak var btnViewDetails: UIButton!
    @IBOutlet weak var imgFlightReturn: UIImageView!
    
    var shareClosure : (() -> ())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

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

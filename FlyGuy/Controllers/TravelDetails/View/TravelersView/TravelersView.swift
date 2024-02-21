//
//  TravelersView.swift
//  FlyGuy
//
//  Created by Springup Labs on 29/05/23.
//

import UIKit

class TravelersView: UIView {
    
    
    @IBOutlet weak var lblAdultsNumber: UILabel!
    @IBOutlet weak var lblChildrenNumber: UILabel!
    @IBOutlet weak var lblInfantsNumber: UILabel!
    
    var shareClosure : ((String, String, String) -> ())?
    
    override func awakeFromNib() {
        self.alpha = 0
        UIView.animate(withDuration: 0.4) {
            self.alpha = 1
        }
        if VIEWMANAGER.isTravellerAdded == true{
            lblAdultsNumber.text  = VIEWMANAGER.travellerNumber.0
            lblChildrenNumber.text  = VIEWMANAGER.travellerNumber.1
            lblInfantsNumber.text  = VIEWMANAGER.travellerNumber.2
        }else{
            lblAdultsNumber.text  = "0"
            lblChildrenNumber.text  = "0"
            lblInfantsNumber.text  = "0"
        }
    }
    
    func removePopup(){
        UIView.animate(withDuration: 0.4,animations: {
            self.alpha = 0
        }){ (_) in
            self.removeFromSuperview()
        }
    }
    
    func onSelectTravelersClicked(closure: @escaping (String,String,String)->()) {
        shareClosure = closure
        
    }
    
    
    @IBAction func btnAdultsMinus(_ sender: Any) {
        if lblAdultsNumber.text != "0"{
            lblAdultsNumber.text = "\(Int(lblAdultsNumber.text!)! - 1)"
        }
    }
    
    
    @IBAction func btnAdultsAdd(_ sender: Any) {
        lblAdultsNumber.text = "\(Int(lblAdultsNumber.text!)! + 1)"
    }
    
    
    @IBAction func btnChildrenMinus(_ sender: Any) {
        if lblChildrenNumber.text != "0"{
            lblChildrenNumber.text = "\(Int(lblChildrenNumber.text!)! - 1)"
        }
    }
    
    @IBAction func btnChildrenAdd(_ sender: Any) {
        lblChildrenNumber.text = "\(Int(lblChildrenNumber.text!)! + 1)"
    }
    
    
    @IBAction func btnInfantsMinus(_ sender: Any) {
        if lblInfantsNumber.text != "0"{
            lblInfantsNumber.text = "\(Int(lblInfantsNumber.text!)! - 1)"
        }
    }
    
    
    @IBAction func btnInfantsAdd(_ sender: Any) {
        lblInfantsNumber.text = "\(Int(lblInfantsNumber.text!)! + 1)"
    }
    
    
    @IBAction func btnCloseClicked(_ sender: Any) {
        if shareClosure != nil {
            shareClosure!(lblAdultsNumber.text!,lblChildrenNumber.text!,lblInfantsNumber.text!)
        }
        removePopup()
    }
}

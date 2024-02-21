//
//  BookingTextfieldCell.swift
//  FlyGuy
//
//  Created by Springup Labs on 24/04/23.
//

import UIKit


protocol SendBookingDataDelegate : AnyObject {
    
    func sendBookingData(str: String,from: String)
}

class BookingTextfieldCell: UITableViewCell{

    @IBOutlet weak var baseView: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var txtFField: UITextField!
    @IBOutlet weak var btnEdit: UIButton!
    @IBOutlet weak var btnTxtF: UIButton!
    
    var passClosure : (() -> ())?
    var selectTxtFClosure : (() -> ())?
    weak var delegate : SendBookingDataDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        addShadowCell()
    }

    func addShadowCell(){
        txtFField.delegate = self
        baseView.layer.shadowColor = UIColor().hexStringToUIColor(hex: "#00000029").cgColor
        baseView.layer.shadowOffset = CGSize(width: 0, height: 1.0)
        baseView.layer.shadowRadius = 3
        baseView.layer.shadowOpacity = 0.2
        baseView.layer.masksToBounds = false
    }
 
    
    func onSelectOrEditClicked(closure: @escaping ()->()) {
        passClosure = closure
        
    }
    
    func onAddDateOrTimeClicked(closure: @escaping ()->()) {
        selectTxtFClosure = closure
        
    }
    
    @IBAction func btnEditClicked(_ sender: Any) {
        if passClosure != nil{
            passClosure!()
        }
    }
    
    @IBAction func btnTxtFClicked(_ sender: Any) {
        if selectTxtFClosure != nil {
            selectTxtFClosure!()
        }
    }
    
    
}

extension BookingTextfieldCell: UITextFieldDelegate{
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        delegate?.sendBookingData(str: "\(txtFField.text ?? "")", from: "destination" )
    }
}

//
//  TravelDetailsCell.swift
//  FlyGuy
//
//  Created by Springup Labs on 10/05/23.
//

import UIKit
protocol TextfieldDelegate{
    func didEndEditing(tag: Int,txtValue: String,from: String)
    func didMaleSelected(tag: Int, isMale: Bool)
}

class TravelDetailsCell: UITableViewCell, UITextFieldDelegate {
    
    @IBOutlet weak var BGView: UIView!
    @IBOutlet weak var lblPassanger: UILabel!
    @IBOutlet weak var txtFFirstname: UITextField!
    @IBOutlet weak var txtFLastName: UITextField!
    @IBOutlet weak var txtFDOB: UITextField!
    @IBOutlet weak var btnMale: UIButton!
    @IBOutlet weak var btnFemale: UIButton!
    @IBOutlet weak var btnDelete: UIButton!
    @IBOutlet weak var lblPassangerNumber: UILabel!
    @IBOutlet weak var viewPassportNumber: UIView!
    @IBOutlet weak var txtFPassportNumber: UITextField!
    @IBOutlet weak var viewPassportIssueCountry: UIView!
    @IBOutlet weak var txtFPassportIssueCountry: UITextField!
    @IBOutlet weak var viewPassportExpiryDate: UIView!
    @IBOutlet weak var txtFPassportExpiryDate: UITextField!
    
    var isSelectedBtn : Bool = false
    var deleteClosure : ((IndexPath)->())?
    var dateClosure : ((IndexPath)->())?
    var indexpath = IndexPath()
    var delegate : TextfieldDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        txtFFirstname.delegate = self
        txtFLastName.delegate = self
        txtFDOB.delegate = self
        txtFPassportNumber.delegate = self
        txtFPassportIssueCountry.delegate = self
        txtFPassportExpiryDate.delegate = self
        BGView.addShadowForCell()
        if VIEWMANAGER.isPassportMandatory == true{
            viewPassportNumber.isHidden = false
            viewPassportIssueCountry.isHidden = false
            viewPassportExpiryDate.isHidden = false
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    func onDeleteClicked(back : @escaping (IndexPath) -> Void)
    {
        deleteClosure = back
    }
    
    func onDateClicked(back : @escaping (IndexPath) -> Void)
    {
        dateClosure = back
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == txtFFirstname{
            delegate?.didEndEditing(tag: txtFFirstname.tag, txtValue: txtFFirstname.text ?? "", from: "FirstName")
        }
        else if textField == txtFLastName{
            delegate?.didEndEditing(tag: txtFLastName.tag, txtValue: txtFLastName.text ?? "", from: "LastName")
        }
        else if textField == txtFPassportNumber{
            delegate?.didEndEditing(tag: txtFLastName.tag, txtValue: txtFPassportNumber.text ?? "", from: "PassportNumber")
        }
        else if textField == txtFPassportIssueCountry{
            delegate?.didEndEditing(tag: txtFLastName.tag, txtValue: txtFPassportIssueCountry.text ?? "", from: "PassportIssueCountry")
        }
        else if textField == txtFPassportExpiryDate{
            delegate?.didEndEditing(tag: txtFLastName.tag, txtValue: txtFPassportExpiryDate.text ?? "", from: "PassportExpiryDate")
        }
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder() // Dismiss the keyboard
        return true
    }
    
    
    @IBAction func btnMaleClicked(_ sender: Any) {
        delegate?.didMaleSelected(tag: btnMale.tag, isMale: btnMale.isSelected == true ? false : true)
    }
    
    
    @IBAction func btnFemaleClicked(_ sender: Any) {
        delegate?.didMaleSelected(tag: btnFemale.tag, isMale: btnMale.isSelected == true ? true : false)
    }
    
    
    @IBAction func btnDelateClicked(_ sender: Any) {
        if deleteClosure != nil {
            deleteClosure!(indexpath)
        }
    }
    
    
    @IBAction func btnDOBClicked(_ sender: Any) {
        txtFFirstname.resignFirstResponder()
        txtFLastName.resignFirstResponder()
        txtFDOB.resignFirstResponder()
        txtFPassportNumber.resignFirstResponder()
        txtFPassportIssueCountry.resignFirstResponder()
        txtFPassportExpiryDate.resignFirstResponder()
        if dateClosure != nil {
            dateClosure!(indexpath)
        }
    }
    
}

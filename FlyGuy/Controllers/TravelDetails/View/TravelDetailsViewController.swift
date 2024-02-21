//
//  TravelDetailsViewController.swift
//  FlyGuy
//
//  Created by Springup Labs on 10/05/23.
//

import UIKit

protocol TravelDetailProtocol {
    var controller: TravelDetailsViewController { get }
}

struct Traveller {
    var firstName, lastName, dob, passNumber, passExpiry, passCountry: String?
    var title : Bool? =  true
}

class TravelDetailsViewController: BaseViewController, TextfieldDelegate {
    
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblPhoneNumber: UILabel!
    
    var tableViewData:[Traveller]? = []{
        didSet{
            DispatchQueue.main.async {
                self.tblView.reloadData()
            }
        }
    }
    let viewModel = TravelDetailsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if Constants.deviceType == DeviceType.iPad.rawValue{
            tblView.register(UINib(nibName: "TravelDetailsIpadCell", bundle: nil), forCellReuseIdentifier: "TravelDetailsIpadCell")
        }else{
            tblView.register(UINib(nibName: "TravelDetailsCell", bundle: nil), forCellReuseIdentifier: "TravelDetailsCell")
        }
        
        setUpData()
        
        self.tableViewData?.append(contentsOf:[Traveller(firstName: ViewManager.shared.loginDetails.firstname, lastName: ViewManager.shared.loginDetails.lastname, dob: ViewManager.shared.loginDetails.birthdate, title: true)])
    }
    
    // MARK: Initial setup UI methods
    
    func setUpData(){
        lblEmail.text = ViewManager.shared.loginDetails.email
        lblPhoneNumber.text = ViewManager.shared.loginDetails.phonenumber
    }
    
    func navigateToConfirmDetails(){
        let storyID = UIStoryboard(name: Storyboards.ConfirmDetailsStoryboard, bundle:nil)
        let vc = storyID.instantiateViewController(withIdentifier: ViewControllers.ConfirmDetailsViewController) as! ConfirmDetailsViewController
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: true)
    }
    
    // MARK: Data setup methods for configuring api
    
    func getAgeFromDOF(date: String) -> (Int,Int,Int) {

        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "yyyy-MM-dd"
        let dateOfBirth = dateFormater.date(from: date)

        let calender = Calendar.current

        let dateComponent = calender.dateComponents([.year, .month, .day], from:
        dateOfBirth!, to: Date())

        return (dateComponent.year!, dateComponent.month!, dateComponent.day!)
    }
    
    
    func setPaxData(){
    var arrInfantTitle: [String] = []
    var arrInfantName: [String] = []
    var arrInfantLastName: [String] = []
    var arrInfantDOB: [String] = []
        var arrInfantPassNo: [String] = []
        var arrInfantPassExp: [String] = []
        var arrInfantPassCou: [String] = []
    var arrChildTitle: [String] = []
    var arrChildName: [String] = []
    var arrChildLastName: [String] = []
    var arrChildDOB: [String] = []
        var arrChildPassNo: [String] = []
        var arrChildPassExp: [String] = []
        var arrChildPassCou: [String] = []
    var arrAdultTitle: [String] = []
    var arrAdultName: [String] = []
    var arrAdultLastName: [String] = []
    var arrAdultDOB: [String] = []
        var arrAdultPassNo: [String] = []
        var arrAdultPassExp: [String] = []
        var arrAdultPassCou: [String] = []
    
        if let unwrappedData = tableViewData {
            for value in unwrappedData {
                  let age  = getAgeFromDOF(date: value.dob ?? "")
                  if age.0 <= 2   {
                      arrInfantTitle.append(value.title == true ? "Master" : "Miss")
                      arrInfantName.append(value.firstName ?? "")
                      arrInfantLastName.append(value.lastName ?? "")
                      arrInfantDOB.append(value.dob ?? "")
                      arrInfantPassNo.append(value.passNumber ?? "")
                      arrInfantPassCou.append(value.passCountry ?? "")
                      arrInfantPassExp.append(value.passExpiry ?? "")
                  }
                  else if age.0 > 2 && age.0 <= 12{
                      arrChildTitle.append(value.title == true ? "Master" : "Miss")
                      arrChildName.append(value.firstName ?? "")
                      arrChildLastName.append(value.lastName ?? "")
                      arrChildDOB.append(value.dob ?? "")
                      arrChildPassNo.append(value.passNumber ?? "")
                      arrChildPassCou.append(value.passCountry ?? "")
                      arrChildPassExp.append(value.passExpiry ?? "")
                  }else{
                      arrAdultTitle.append(value.title == true ? "Mr" : "Miss")
                      arrAdultName.append(value.firstName ?? "")
                      arrAdultLastName.append(value.lastName ?? "")
                      arrAdultDOB.append(value.dob ?? "")
                      arrAdultPassNo.append(value.passNumber ?? "")
                      arrAdultPassCou.append(value.passCountry ?? "")
                      arrAdultPassExp.append(value.passExpiry ?? "")
                  }
            }
        }
        var nationality : [String] = []
        var passportNo : [String] = []
      
        for _ in arrInfantTitle{
            nationality.append("IN")
            passportNo.append("")
        }
        
        let model = Adult(title: arrInfantTitle,firstName: arrInfantName,lastName : arrInfantLastName, dob: arrInfantDOB,nationality: nationality, passportNo : arrInfantPassNo, passportIssueCountry : arrInfantPassCou, passportExpiryDate: arrInfantPassExp,extraServiceOutbound: [passportNo], extraServiceInbound:[passportNo])
       
        var nationality1 : [String] = []
        var passportNo1 : [String] = []
    
        for _ in arrChildTitle{
            nationality1.append("IN")
            passportNo1.append("")
        }
        
        let modelChild = Adult(title: arrChildTitle,firstName: arrChildName,lastName : arrChildLastName, dob: arrChildDOB,nationality: nationality1, passportNo : arrChildPassNo, passportIssueCountry : arrChildPassCou, passportExpiryDate: arrChildPassExp,extraServiceOutbound: [passportNo1], extraServiceInbound:[passportNo1])
        
        var nationality2 : [String] = []
        var passportNo2 : [String] = []
      
        for _ in arrAdultTitle{
            nationality2.append("IN")
            passportNo2.append("")
        }
        let modelAdult = Adult(title: arrAdultTitle,firstName: arrAdultName,lastName : arrAdultLastName, dob: arrAdultDOB,nationality: nationality2, passportNo : arrAdultPassNo, passportIssueCountry : arrAdultPassCou, passportExpiryDate: arrAdultPassExp,extraServiceOutbound: [passportNo2], extraServiceInbound:[passportNo2])
    
        let paxModel = PaxDetail(adult: modelAdult,child: modelChild,infant: model)
        ViewManager.shared.paxDetail = paxModel
        print(paxModel)
    }
    
    // MARK: Button Action Methods
    
    @IBAction func btnHomeClicked(_ sender: Any) {
        if Constants.deviceType == DeviceType.iPhone.rawValue{
            if ViewManager.shared.isNavigatedFromLoginScreen == true{
                let viewControllers: [UIViewController] = self.navigationController!.viewControllers as [UIViewController]
                    self.navigationController!.popToViewController(viewControllers[viewControllers.count - 4], animated: true)
                ViewManager.shared.isNavigatedFromLoginScreen = false
            }else{
                navigationController?.popViewController(animated: true)
            }
        }else{
            removeIpad(asChildViewController: TravelDetailsVCiPad)
            addIpad(asChildViewController: FlightDetailsVCiPad)
        }
    }
    
    
    @IBAction func btnProceedClicked(_ sender: Any) {
        var isAllFilled : Bool = true
        
        for row in 0..<tblView.numberOfRows(inSection: 0) {
            let indexPath = IndexPath(row: row, section: 0)
            if Constants.deviceType == DeviceType.iPad.rawValue{
                guard let cell = tblView.cellForRow(at: indexPath) as? TravelDetailsIpadCell else {
                    continue
                }
                
                if VIEWMANAGER.isPassportMandatory == true{
                    if cell.txtFPassportNumber?.text?.isEmpty == true || cell.txtFPassportExpiryDate?.text?.isEmpty == true || cell.txtFPassportIssueCountry?.text?.isEmpty == true || cell.txtFFirstname?.text?.isEmpty == true || cell.txtFLastName?.text?.isEmpty == true || cell.txtFDOB?.text?.isEmpty == true{
                        self.showAlert(msg: Messages.emptyData)
                        isAllFilled = false
                        break
                    }
                }else{
                    if cell.txtFFirstname?.text?.isEmpty == true || cell.txtFLastName?.text?.isEmpty == true || cell.txtFDOB?.text?.isEmpty == true{
                        self.showAlert(msg: Messages.emptyData)
                        isAllFilled = false
                        break
                    }
                }
                
            }else{
                guard let cell = tblView.cellForRow(at: indexPath) as? TravelDetailsCell else {
                    continue
                }
                
                if VIEWMANAGER.isPassportMandatory == true{
                    if cell.txtFPassportNumber?.text?.isEmpty == true || cell.txtFPassportExpiryDate?.text?.isEmpty == true || cell.txtFPassportIssueCountry?.text?.isEmpty == true || cell.txtFFirstname?.text?.isEmpty == true || cell.txtFLastName?.text?.isEmpty == true || cell.txtFDOB?.text?.isEmpty == true{
                        self.showAlert(msg: Messages.emptyData)
                        isAllFilled = false
                        break
                    }
                }else{
                    if cell.txtFFirstname?.text?.isEmpty == true || cell.txtFLastName?.text?.isEmpty == true || cell.txtFDOB?.text?.isEmpty == true{
                        self.showAlert(msg: Messages.emptyData)
                        isAllFilled = false
                        break
                    }
                }
            }
            ViewManager.shared.paxCount = tableViewData?.count ?? 1
            
             let totalPax = (Int(VIEWMANAGER.travellerNumber.0) ?? 0) + (Int(VIEWMANAGER.travellerNumber.1) ?? 0) + (Int(VIEWMANAGER.travellerNumber.2) ?? 0)
                if totalPax != ViewManager.shared.paxCount{
                    self.showAlert(msg: "Ensure that the count of passengers remains consistent with the count on the Booking Details screen, and if you need to modify the passenger count, return to the Booking Details screen.")
                    return
                }
            
        }
        
        if isAllFilled{
            self.setPaxData()
            if Constants.deviceType == DeviceType.iPhone.rawValue{
                navigateToConfirmDetails()
            }else{
                removeIpad(asChildViewController: TravelDetailsVCiPad)
                addIpad(asChildViewController: ConfirmDetailsVCiPad)
            }
        }
    }
   
   
    
}

extension TravelDetailsViewController : UITableViewDelegate, UITableViewDataSource{
    
    // MARK: TableView Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewData?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if Constants.deviceType == DeviceType.iPad.rawValue{
            let cell = tableView.dequeueReusableCell(withIdentifier: "TravelDetailsIpadCell") as! TravelDetailsIpadCell
            cell.indexpath = indexPath
            cell.txtFDOB.tag = indexPath.row
            cell.txtFFirstname.tag = indexPath.row
            cell.txtFLastName.tag = indexPath.row
            cell.btnMale.tag = indexPath.row
            cell.btnFemale.tag = indexPath.row
            cell.txtFPassportNumber.tag = indexPath.row
            cell.txtFPassportExpiryDate.tag = indexPath.row
            cell.txtFPassportIssueCountry.tag = indexPath.row
            let model = tableViewData?[indexPath.row]
            cell.txtFFirstname.text = "\(model?.firstName ?? "")"
            cell.txtFLastName.text = "\(model?.lastName ?? "")"
            cell.txtFDOB.text = "\(model?.dob ?? "")"
            cell.txtFPassportNumber.text = "\(model?.passNumber ?? "")"
            cell.txtFPassportExpiryDate.text = "\(model?.passExpiry ?? "")"
            cell.txtFPassportIssueCountry.text = "\(model?.passCountry ?? "")"

            cell.lblPassengerNumber.text = "Passenger \(indexPath.row + 1)"
            if model?.title == true{
                cell.btnMale.setImage(UIImage(named: "selected_Icon"), for: .normal)
                cell.btnFemale.setImage(UIImage(named: "unselected_Icon"), for: .normal)
            }else{
                cell.btnMale.setImage(UIImage(named: "unselected_Icon"), for: .normal)
                cell.btnFemale.setImage(UIImage(named: "selected_Icon"), for: .normal)
            }
           
            cell.onDeleteClicked { indexpath in
                if indexpath.row == 0{
                    VIEWMANAGER.showToast(message: Messages.validPassanger)
                }else{
                    self.tableViewData?.remove(at: indexpath.row)
                }
            }
            cell.onDateClicked { indexpath in
                if indexpath.row != 0{
                    ViewManager.shared.isDOB = true
                    let datePicker = DatePickerView(frame: UIScreen.main.bounds)
                    self.view.addSubview(datePicker)
                    datePicker.onDoneClicked { (date) in
                        cell.txtFDOB.text = date
                        let formatter = DateFormatter()
                        formatter.dateFormat = "MM-dd-yyyy"
                        let jorneyDate = formatter.date(from: date)
                        formatter.dateFormat = "yyyy-MM-dd"
                        let todayDate = formatter.string(from: Date())
                        let JorneyStrDate = formatter.string(from: jorneyDate ?? Date())
                        self.tableViewData?[indexpath.row].dob = JorneyStrDate == todayDate ? "" : JorneyStrDate
                    }
                    ViewManager.shared.isDOB = false
                }
            }
            cell.delegate = self
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "TravelDetailsCell") as! TravelDetailsCell
            cell.indexpath = indexPath
            cell.txtFDOB.tag = indexPath.row
            cell.txtFFirstname.tag = indexPath.row
            cell.txtFLastName.tag = indexPath.row
            cell.btnMale.tag = indexPath.row
            cell.btnFemale.tag = indexPath.row
            cell.txtFPassportNumber.tag = indexPath.row
            cell.txtFPassportExpiryDate.tag = indexPath.row
            cell.txtFPassportIssueCountry.tag = indexPath.row
            let model = tableViewData?[indexPath.row]
            cell.txtFFirstname.text = "\(model?.firstName ?? "")"
            cell.txtFLastName.text = "\(model?.lastName ?? "")"
            cell.txtFDOB.text = "\(model?.dob ?? "")"
            cell.txtFPassportNumber.text = "\(model?.passNumber ?? "")"
            cell.txtFPassportExpiryDate.text = "\(model?.passExpiry ?? "")"
            cell.txtFPassportIssueCountry.text = "\(model?.passCountry ?? "")"
            cell.lblPassangerNumber.text = "Passenger \(indexPath.row + 1)"

            if model?.title == true{
                cell.btnMale.setImage(UIImage(named: "selected_Icon"), for: .normal)
                cell.btnFemale.setImage(UIImage(named: "unselected_Icon"), for: .normal)
            }else{
                cell.btnMale.setImage(UIImage(named: "unselected_Icon"), for: .normal)
                cell.btnFemale.setImage(UIImage(named: "selected_Icon"), for: .normal)
            }
            cell.onDeleteClicked { indexpath in
                if indexpath.row == 0{
                    VIEWMANAGER.showToast(message: Messages.validPassanger)
                }else{
                    self.tableViewData?.remove(at: indexpath.row)
                }
            }
            cell.onDateClicked { indexpath in
                if indexpath.row != 0{
                    ViewManager.shared.isDOB = true
                    let datePicker = DatePickerView(frame: UIScreen.main.bounds)
                    self.view.addSubview(datePicker)
                    datePicker.onDoneClicked { (date) in
                        cell.txtFDOB.text = date
                        let formatter = DateFormatter()
                        formatter.dateFormat = "MM-dd-yyyy"
                        let jorneyDate = formatter.date(from: date)
                        formatter.dateFormat = "yyyy-MM-dd"
                        let todayDate = formatter.string(from: Date())
                        let JorneyStrDate = formatter.string(from: jorneyDate ?? Date())
                        self.tableViewData?[indexpath.row].dob = JorneyStrDate == todayDate ? "" : JorneyStrDate
                    }
                    ViewManager.shared.isDOB = false
                }
            }
            cell.delegate = self
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if Constants.deviceType == DeviceType.iPad.rawValue{
            let customView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width - 40, height: 80))
            customView.backgroundColor = UIColor.white
            customView.layer.cornerRadius = 5
            customView.layer.borderColor = UIColor.lightGray.cgColor
            customView.layer.borderWidth = 1
            let img =  UIImage(named: "add_Icon")
            let imgView = UIImageView(image: img)
            imgView.frame = CGRect(x:customView.frame.midX - 90,y: customView.frame.midY - 17 ,width:34,height:34)
            customView.addSubview(imgView)
            let titleLabel = UILabel(frame: CGRect(x:customView.frame.midX - 40,y: customView.frame.midY - 15 ,width:200,height:30))
            titleLabel.backgroundColor = UIColor.clear
            titleLabel.textColor = .black
            titleLabel.font = UIFont.boldSystemFont(ofSize: 27)
            titleLabel.text  = "Add Passenger"
            customView.addSubview(titleLabel)
            let button = UIButton(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 80))
            button.backgroundColor = .clear
            button.addTarget(self, action: #selector(addBtnAction), for: .touchUpInside)
            button.setTitle("", for: .normal)
            customView.addSubview(button)
            return customView
        }else{
            let customView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width - 40, height: 50))
            customView.backgroundColor = UIColor.white
            customView.layer.cornerRadius = 5
            customView.layer.borderColor = UIColor.lightGray.cgColor
            customView.layer.borderWidth = 1
            let img =  UIImage(named: "add_Icon")
            let imgView = UIImageView(image: img)
            imgView.frame = CGRect(x:customView.frame.midX - 70,y: customView.frame.midY - 12 ,width:24,height:24)
            customView.addSubview(imgView)
            let titleLabel = UILabel(frame: CGRect(x:customView.frame.midX - 40,y: customView.frame.midY - 15 ,width:150,height:30))
            titleLabel.backgroundColor = UIColor.clear
            titleLabel.textColor = .black
            titleLabel.font = UIFont.boldSystemFont(ofSize: 17)
            titleLabel.text  = "Add Passenger"
            customView.addSubview(titleLabel)
            let button = UIButton(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 50))
            button.backgroundColor = .clear
            button.addTarget(self, action: #selector(addBtnAction), for: .touchUpInside)
            button.setTitle("", for: .normal)
            customView.addSubview(button)
            return customView
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return Constants.deviceType == DeviceType.iPad.rawValue ? 80 : 50
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat.leastNonzeroMagnitude
    }
    
    func didEndEditing(tag: Int, txtValue: String, from: String) {
        if from == "FirstName" {
            if txtValue != ""{
                tableViewData?[tag].firstName = txtValue
            }
        }
        else if from == "LastName" {
            if txtValue != ""{
                tableViewData?[tag].lastName = txtValue
            }
        }
        else if from == "PassportNumber" {
            if txtValue != ""{
                tableViewData?[tag].passNumber = txtValue
            }
        }
        else if from == "PassportIssueCountry" {
            if txtValue != ""{
                tableViewData?[tag].passCountry = txtValue
            }
        }
        else if from == "PassportExpiryDate" {
            if txtValue != ""{
                tableViewData?[tag].passExpiry = txtValue
            }
        }
    }
    
    func didMaleSelected(tag: Int ,isMale: Bool) {
        tableViewData?[tag].title = isMale
    }
    
    @objc func addBtnAction() {
        tableViewData?.append(contentsOf: [Traveller(firstName: "", lastName: "", dob: "",passNumber: "", passExpiry: "",passCountry: "",title: true)])
    }
    
}

extension TravelDetailsViewController: TravelDetailProtocol {
    var controller: TravelDetailsViewController {
        self
    }
}






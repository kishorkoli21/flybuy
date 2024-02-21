//
//  BookingDetailsViewController.swift
//  FlyGuy
//
//  Created by Springup Labs on 26/04/23.
//

import UIKit

protocol BookingDetailProtocol {
    var controller: BookingDetailsViewController { get }
}

class BookingDetailsViewController: BaseViewController {
  
    @IBOutlet weak var txtFDestination: UITextField!
    @IBOutlet weak var txtFTrip: UITextField!
    @IBOutlet weak var txtFOriginCity: UITextField!
    @IBOutlet weak var txtFDepartureDate: UITextField!
    @IBOutlet weak var txtFDepartureTime: UITextField!
    @IBOutlet weak var txtFClass: UITextField!
    @IBOutlet weak var txtFReturnDate: UITextField!
    @IBOutlet weak var txtFReturnTime: UITextField!
    @IBOutlet weak var viewReturnDate: UIView!
    @IBOutlet weak var viewReturnTime: UIView!
    @IBOutlet weak var txtFTravelers: UITextField!
    @IBOutlet weak var tblViewDestination: UITableView!
    @IBOutlet weak var tblViewDeparture: UITableView!
    @IBOutlet weak var tblViewDestinationHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var tblViewDepartureHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var lblDestinationWarning: UILabel!
    @IBOutlet weak var lblOriginWarning: UILabel!
    @IBOutlet weak var lblClassWarning: UILabel!
    @IBOutlet weak var lblTripWarning: UILabel!
    
    
    var bookData : BookingDataStruct = BookingDataStruct(departure: "", destination: "", date: "", time: "", trip: "", returnDate: "", returnTime: "", preferredClass: "", isFromSiri: false)
    var dropDownData  : [String]!
    var viewModel = BookingDetailViewModel()
    var cityListParameters = CityListParameterKeyStruct()
    var bookingDetails = BookingDetailsInputDTO()
    var timer : Timer!
    var searchKeyword = ""
    var timer1 : Timer!
    var departureCode : String = ""
    var destinationCode : String = ""
    var travellerNumber : (String, String, String) = ("", "", "")
    var isCityApiCall : Bool = true


    override func viewDidLoad() {
        super.viewDidLoad()
        let tapGesture = UITapGestureRecognizer(target: self,action: #selector(hideKeyboard))
        tapGesture.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tapGesture)
        txtFDestination.delegate = self
        txtFOriginCity.delegate = self
        tblViewDeparture.register(UINib(nibName: "CityListCell", bundle: nil), forCellReuseIdentifier: "CityListCell")
        tblViewDestination.register(UINib(nibName: "CityListCell", bundle: nil), forCellReuseIdentifier: "CityListCell")
        
        if bookData.isFromSiri{
            setDataFromSiri()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if VIEWMANAGER.isRevalidateErr == true{
            let alertController = UIAlertController(title: "", message: "Searched flight not available.", preferredStyle: .alert)
            let OKAction = UIAlertAction(title: "OK", style: .default) {
                (action: UIAlertAction!) in
                print("Ok button tapped");
            }
            alertController.addAction(OKAction)
            self.present(alertController, animated: true, completion: nil)
        }
        
        if VIEWMANAGER.isShowBookingDetailsForIpad {
            if Constants.deviceType == DeviceType.iPad.rawValue{
                txtFDestination.text = VIEWMANAGER.bookDataForIpad.destinationCity
                txtFOriginCity.text = VIEWMANAGER.bookDataForIpad.departureCity
                txtFTrip.text = VIEWMANAGER.bookDataForIpad.trip
                txtFClass.text = VIEWMANAGER.bookDataForIpad.classtype
                txtFDepartureDate.text = VIEWMANAGER.bookDataForIpad.departureDate
                txtFDepartureTime.text = VIEWMANAGER.bookDataForIpad.departureTime
                txtFReturnDate.text = VIEWMANAGER.bookDataForIpad.returnDate
                txtFReturnTime.text = VIEWMANAGER.bookDataForIpad.returnTime
                txtFTravelers.text = "\(VIEWMANAGER.bookDataForIpad.adults ?? "") Adults, \(VIEWMANAGER.bookDataForIpad.childs ?? "") Children, \(VIEWMANAGER.bookDataForIpad.infants ?? "") Infants"
                
                self.bookingDetails.classtype = VIEWMANAGER.bookDataForIpad.classtype
                self.bookingDetails.trip = VIEWMANAGER.bookDataForIpad.trip
                self.bookingDetails.departure = VIEWMANAGER.bookDataForIpad.departure
                self.bookingDetails.destination = VIEWMANAGER.bookDataForIpad.destination
                self.bookingDetails.departureDate = VIEWMANAGER.bookDataForIpad.departureDate
                self.bookingDetails.departureTime =  VIEWMANAGER.bookDataForIpad.departureTime
                self.bookingDetails.returnDate = VIEWMANAGER.bookDataForIpad.returnDate
                self.bookingDetails.returnTime = VIEWMANAGER.bookDataForIpad.returnTime
                self.txtFOriginCity.text = VIEWMANAGER.bookDataForIpad.departureCity
                self.txtFDestination.text = VIEWMANAGER.bookDataForIpad.destinationCity
                if bookingDetails.trip == "Return Trip"{
                    viewReturnDate.isHidden = false
                    viewReturnTime.isHidden = false
                }else{
                    viewReturnDate.isHidden = true
                    viewReturnTime.isHidden = true
                }
            }
        }
        
    }
    
  
    
    // MARK: Validation and Alert popup Methods
    
      @objc
      private func hideKeyboard() {
          self.view.endEditing(true)
      }
    
    func validate() -> Bool {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM-dd-yyyy"
        let today = Date()
        let todaysStrDate = formatter.string(from: today)
        let todaysDate = formatter.date(from: todaysStrDate)!
        var tomorrowsDate : String = ""
        if let tomorrowDate = Calendar.current.date(byAdding: .day, value: 1, to: today){
            tomorrowsDate = formatter.string(from: tomorrowDate)
        }
        
        let date = formatter.date(from: txtFDepartureDate.text!) ?? Date()
        let strDate = formatter.string(from: date)
        
        
        if txtFTrip.text!.trimString().count == 0  || self.lblTripWarning.isHidden == false{
            self.showAlert(msg: Messages.trip)
            return false
        }
        if txtFOriginCity.text!.trimString().count == 0 {
            self.showAlert(msg: Messages.departure)
            return false
        }
        if txtFDestination.text!.trimString().count == 0 {
            self.showAlert(msg: Messages.destination)
            return false
        }
        if txtFDepartureDate.text!.trimString().count == 0 {
            self.showAlert(msg: Messages.departureDate)
            return false
        }
        if txtFDepartureTime.text!.trimString().count == 0 {
            self.showAlert(msg: Messages.departureTime)
            return false
        }
        if txtFClass.text!.trimString().count == 0 || self.lblClassWarning.isHidden == false{
            self.showAlert(msg: Messages.className)
            return false
        }
        
        if self.travellerNumber.0 == "0" || txtFTravelers.text!.trimString().count == 0{
            self.showAlert(msg: Messages.OnePersonValidation)
            return false
        }
        
        if txtFTrip.text == "Return Trip"{
            if txtFReturnDate.text!.trimString().count == 0 {
                self.showAlert(msg: Messages.returnDate)
                return false
            }
            if txtFReturnTime.text!.trimString().count == 0 {
                self.showAlert(msg: Messages.returnTime)
                return false
            }
            if let returnDate = formatter.date(from: txtFReturnDate.text ?? ""){
                if date > returnDate{
                    self.showAlert(msg: Messages.returnDateGreater)
                    return false
                }
            }
        }
       
        if txtFDepartureDate.text == todaysStrDate || txtFDepartureDate.text == tomorrowsDate || date < todaysDate {
            if strDate == todaysStrDate || strDate == tomorrowsDate  {
                let modifiedDate = Calendar.current.date(byAdding: .day, value: 2, to: today)!
                let modifiedStrDate = formatter.string(from: modifiedDate)
                self.showAlert(error: Messages.validateDepartureDate, dateStr: modifiedStrDate, isDeparture: true)
            }else if date < todaysDate{
                let modifiedDate = Calendar.current.date(byAdding: .year, value: 1, to: today)!
                let modifiedStrDate = formatter.string(from: modifiedDate)
                self.showAlert(error: Messages.pastDate, dateStr: modifiedStrDate, isDeparture: true)
            }
            return false
        }
        return true
    }
    
    func showAlert(error: String, dateStr : String, isDeparture : Bool){
        let alert = UIAlertController(title: "", message: error, preferredStyle: .alert)
             let ok = UIAlertAction(title: "OK", style: .default, handler: { action in
                 if isDeparture{
                     self.txtFDepartureDate.text = dateStr
                 }else{
                     self.txtFReturnDate.text = dateStr
                 }
             })
             alert.addAction(ok)
             DispatchQueue.main.async(execute: {
                self.present(alert, animated: true)
        })
    }
    
    // MARK: Api Configure Methods
    
    func configure(city: String = "", isDestination: Bool = false, isFromSiri: Bool = false){
        if self.isCityApiCall == true {
            viewModel.view = self
            cityListParameters.city = city
            
            viewModel.getCityListApi(cityListParameters: cityListParameters,isDestination: isDestination) { isSuccess in
                if isSuccess{
                    if isDestination{
                        self.tblViewDestination.reloadData()
                        if self.viewModel.destinationList?.count ?? 0 > 0{
                            self.tblViewDestination.isHidden = false
                            if isFromSiri{
                                let model = self.viewModel.destinationList?[0]
                                self.txtFDestination.text = "\(model?.city ?? "") (\(model?.airportName ?? ""))"
                                self.destinationCode = model?.airportCode ?? ""
                                self.lblDestinationWarning.isHidden = true
                                if self.viewModel.destinationList?.count ?? 0 > 1{
                                    self.lblDestinationWarning.isHidden = false
                                    self.lblDestinationWarning.text = "More airport are available for this city"
                                    self.tblViewDestination.isHidden = true
                                }else{
                                    self.lblDestinationWarning.isHidden = true
                                    self.lblDestinationWarning.text = "Please select Valid Destination"
                                    self.tblViewDestination.isHidden = true
                                }
                            }
                        }else{
                            self.tblViewDestination.isHidden = true
                            if isFromSiri{
                                self.lblDestinationWarning.isHidden = false
                            }
                        }
                        if Constants.deviceType == DeviceType.iPhone.rawValue{
                            self.tblViewDestinationHeightConstraint.constant = 200
                        }else{
                            self.tblViewDestinationHeightConstraint.constant = 400
                        }
                        
                    }else{
                        self.tblViewDeparture.reloadData()
                        if self.viewModel.departureList?.count ?? 0 > 0{
                            self.tblViewDeparture.isHidden = false
                            if isFromSiri{
                                let model = self.viewModel.departureList?[0]
                                self.txtFOriginCity.text = "\(model?.city ?? "") (\(model?.airportName ?? ""))"
                                self.departureCode = model?.airportCode ?? ""
                                self.lblOriginWarning.isHidden = true
                                if self.viewModel.departureList?.count ?? 0 > 1{
                                    self.lblOriginWarning.isHidden = false
                                    self.lblOriginWarning.text = "More airports available for this search criteria."
                                    self.tblViewDeparture.isHidden = true
                                }else{
                                    self.lblOriginWarning.isHidden = true
                                    self.lblOriginWarning.text = "Please select Valid Origin"
                                    self.tblViewDeparture.isHidden = true
                                }
                            }
                        }else{
                            self.tblViewDeparture.isHidden = true
                            if isFromSiri{
                                self.lblOriginWarning.isHidden = false
                            }
                        }
                        if Constants.deviceType == DeviceType.iPhone.rawValue{
                            self.tblViewDepartureHeightConstraint.constant = 200
                        }else{
                            self.tblViewDepartureHeightConstraint.constant = 400
                        }
                    }
                }else{
                    if isDestination{
                        self.tblViewDestination.isHidden = true
                        self.txtFDestination.text = self.bookData.destination
                        if isFromSiri{
                            self.lblDestinationWarning.isHidden = false
                        }
                    }else{
                        self.tblViewDeparture.isHidden = true
                        self.txtFOriginCity.text = self.bookData.departure
                        if isFromSiri{
                            self.lblOriginWarning.isHidden = false
                        }
                    }
                }
            }
        }
    }
    
    func configureBookingDetailsApi(){
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MM-dd-yyyy"
        let date = formatter.date(from: txtFDepartureDate.text ?? "")
        let date1 = formatter.date(from: txtFReturnDate.text ?? "")
        formatter.dateFormat = "yyyy-MM-dd"
        let departureDate = formatter.string(from: date ?? Date())
        let destinationDate = formatter.string(from: date1 ?? Date())
        let todaysDate = formatter.string(from: Date())
        bookingDetails.classtype = txtFClass.text
        bookingDetails.trip = txtFTrip.text
        bookingDetails.departure = departureCode
        bookingDetails.destination = destinationCode
        bookingDetails.departureDate = departureDate == todaysDate ? "" : departureDate
        bookingDetails.departureTime = txtFDepartureTime.text
        bookingDetails.returnDate = destinationDate == todaysDate ? "" : destinationDate
        bookingDetails.returnTime = txtFReturnTime.text
        bookingDetails.adults = travellerNumber.0
        bookingDetails.childs = travellerNumber.1
        bookingDetails.infants = travellerNumber.2
        
        viewModel.view = self
        viewModel.getBookingDetailsApi(parameters: bookingDetails) { isSuccess in
            if isSuccess{
                VIEWMANAGER.isShowBookingDetailsForIpad = true
                ViewManager.shared.isReturn = self.txtFTrip.text == "Return Trip" ? true : false
                ViewManager.shared.journeyDate.0 = departureDate
                ViewManager.shared.journeyDate.1 = destinationDate
                ViewManager.shared.journeyDate.2 = self.txtFDepartureTime.text ?? ""
                ViewManager.shared.journeyDate.3 = self.txtFReturnTime.text ?? ""
                 if Constants.deviceType == DeviceType.iPhone.rawValue{
                     self.navigateToFlightList()
                 }else{
                     self.removeIpad(asChildViewController: self.BookVCiPad)
                     self.addIpad(asChildViewController: self.FlightListVCiPad)
                 }
                
                if Constants.deviceType == DeviceType.iPad.rawValue{
                    VIEWMANAGER.bookDataForIpad.classtype = self.bookingDetails.classtype
                    VIEWMANAGER.bookDataForIpad.trip = self.bookingDetails.trip
                    VIEWMANAGER.bookDataForIpad.departure = self.bookingDetails.departure
                    VIEWMANAGER.bookDataForIpad.destination = self.bookingDetails.destination
                    VIEWMANAGER.bookDataForIpad.departureDate = self.bookingDetails.departureDate
                    VIEWMANAGER.bookDataForIpad.departureTime = self.bookingDetails.departureTime
                    VIEWMANAGER.bookDataForIpad.returnDate = self.bookingDetails.returnDate
                    VIEWMANAGER.bookDataForIpad.returnTime = self.bookingDetails.returnTime
                    VIEWMANAGER.bookDataForIpad.departureCity = self.txtFOriginCity.text
                    VIEWMANAGER.bookDataForIpad.destinationCity = self.txtFDestination.text
                }
            }
        }
    }
    
    // MARK: Setting Data From Siri Methods
    

  
    
    func setDataFromSiri(){
        txtFDestination.text = bookData.destination
        txtFOriginCity.text = bookData.departure

        if bookData.trip.range(of: "oneway", options: .caseInsensitive) != nil {
            txtFTrip.text = "One Way Trip"
            self.lblTripWarning.isHidden = true
        }else if bookData.trip.range(of: "Return", options: .caseInsensitive) != nil {
            txtFTrip.text = "Return Trip"
            self.lblTripWarning.isHidden = true
        }else{
            self.lblTripWarning.isHidden = false
            txtFTrip.text = bookData.trip
        }

        if bookData.preferredClass.range(of: "Economy", options: .caseInsensitive) != nil {
            txtFClass.text = "Economy Class"
            self.lblClassWarning.isHidden = true
        }else if bookData.preferredClass.range(of: "Business", options: .caseInsensitive) != nil {
            txtFClass.text = "Business Class"
            self.lblClassWarning.isHidden = true
        }else{
            self.lblClassWarning.isHidden = false
            txtFClass.text = bookData.preferredClass
        }
        
        configure(city: bookData.destination,isDestination: true,isFromSiri: true)
        configure(city: bookData.departure,isDestination: false,isFromSiri: true)

        let formatter = DateFormatter()
                
        let dt = formattedDateFromString(dateString: bookData.date, withFormat: "MM-dd-yyyy")
        formatter.dateFormat = "MM-dd-yyyy"
        let date = formatter.date(from: dt ?? "") ?? Date()
        let strDate = formatter.string(from: date)
        let today = Date()
        let todaysStrDate = formatter.string(from: today)
        let todaysDate = formatter.date(from: todaysStrDate)!
        
        // If departureDate is todays date increasing it by 2 days while if departure date is past date than increasing by 1 year
        if strDate == todaysStrDate{
            let modifiedDate = Calendar.current.date(byAdding: .day, value: 2, to: today)!
            let modifiedStrDate = formatter.string(from: modifiedDate)
            txtFDepartureDate.text = modifiedStrDate
        }else if date < todaysDate{
            let modifiedDate = Calendar.current.date(byAdding: .year, value: 1, to: today)!
            let modifiedStrDate = formatter.string(from: modifiedDate)
            txtFDepartureDate.text = modifiedStrDate
        }else{
            txtFDepartureDate.text = strDate
        }
        
        // If return Date is todays date setting the value nil while if return date is past date than increasing by 1 year
        if bookData.returnDate != ""{
            let rdt = formattedDateFromString(dateString: bookData.returnDate, withFormat: "MM-dd-yyyy")
            formatter.dateFormat = "MM-dd-yyyy"
            let returnDate = formatter.date(from: rdt ?? "") ?? Date()
            let strReturnDate = formatter.string(from: returnDate)
            
            if strReturnDate == todaysStrDate{ }
            else if returnDate < date{ } else{
                txtFReturnDate.text = strReturnDate
            }
            
            /*if strReturnDate == todaysStrDate{ }
            else if returnDate < todaysDate{
                let modifiedDate = Calendar.current.date(byAdding: .year, value: 1, to: today)!
                let modifiedStrDate = formatter.string(from: modifiedDate)
                txtFReturnDate.text = modifiedStrDate
            } else{
                txtFReturnDate.text = strDate
            }*/
        }
        
        let tm = formattedDateFromString(dateString: bookData.time, withFormat: "hh:mm a")
        formatter.dateFormat = "hh:mm a"
        let time = formatter.date(from: tm ?? "") ?? Date()
        let strTime = formatter.string(from: time)
        txtFDepartureTime.text = strTime
        if bookData.returnTime != ""{
            let time = formatter.date(from: bookData.time) ?? Date()
            let strTime = formatter.string(from: time)
            txtFReturnTime.text = strTime
        }
        if bookData.trip == "Return Trip"{
            viewReturnDate.isHidden = false
            viewReturnTime.isHidden = false
        }else{
            viewReturnDate.isHidden = true
            viewReturnTime.isHidden = true
        }
    }
    
    // MARK: DATE FORMATTER
    
    func formattedDateFromString(dateString: String, withFormat format: String) -> String? {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        // inputFormatter= the type of format you getting date from api other place
        //you can change the format according to your getting date
        if let date = inputFormatter.date(from: dateString) {
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = format
            //return outputFormatter.string(from: date)
            return outputFormatter.string(from: date)
        }
        return nil
    }
  
    // MARK: Navigation Methods
    
    func pushToTravelersView() {
        let selectTravelersView = Bundle.main.loadNibNamed("TravelersView", owner: self, options: [:])?.first as! TravelersView
        self.view.addSubview(selectTravelersView)
        selectTravelersView.enableAutoLayout()
        selectTravelersView.leadingMargin(pixels: 0)
        selectTravelersView.trailingMargin(pixels: 0)
        selectTravelersView.topMargin(pixels: 0)
        selectTravelersView.bottomMargin(pixels: 0)
        selectTravelersView.onSelectTravelersClicked { adult, children, infants in
            self.travellerNumber.0 = adult
            self.travellerNumber.1 = children
            self.travellerNumber.2 = infants
            VIEWMANAGER.isTravellerAdded = true
            VIEWMANAGER.travellerNumber.0 = adult
            VIEWMANAGER.travellerNumber.1 = children
            VIEWMANAGER.travellerNumber.2 = infants
            self.txtFTravelers.text = "\(adult) Adults, \(children) Children, \(infants) Infants"
        }
    }
    
    func navigateToFlightList(){
        let storyID = UIStoryboard(name: Storyboards.FlightListStoryboard, bundle:nil)
        let vc = storyID.instantiateViewController(withIdentifier: ViewControllers.FlightListViewController) as! FlightListViewController
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: true)
    }
    
    // MARK: Button Action Methods
    
    @IBAction func btnHomeClicked(_ sender: Any) {
        if Constants.deviceType == DeviceType.iPhone.rawValue{
            navigationController?.popViewController(animated: true)
        }else{
            removeIpad(asChildViewController: BookVCiPad)
            addIpad(asChildViewController: HomeVCiPad)
        }
    }
    
    @IBAction func btnEditDestinationClicked(_ sender: Any) {
        txtFDestination.text = ""
    }
    
    
    @IBAction func btnEditTripClicked(_ sender: Any) {
        txtFTrip.text = ""
    }
    
    
    @IBAction func btnOriginCityClicked(_ sender: Any) {
        txtFOriginCity.text = ""
    }
    
    
    @IBAction func btnEditDepartDateClicked(_ sender: Any) {
        txtFDepartureDate.text = ""
    }
    
    
    @IBAction func btnDepartTimeClicked(_ sender: Any) {
        txtFDepartureTime.text = ""

    }
    
    
    @IBAction func btnEditClassClicked(_ sender: Any) {
        txtFClass.text = ""

    }
    
    @IBAction func btnReturnDateClicked(_ sender: Any) {
        txtFReturnDate.text = ""
    }
    
    
    @IBAction func btnReturnTimeClicked(_ sender: Any) {
        txtFReturnTime.text = ""

    }
    
    
    @IBAction func btnSelectTripClicked(_ sender: Any) {
        var isIpad = Bool()
        if Constants.deviceType == DeviceType.iPhone.rawValue{
            isIpad = false
        }else{
            isIpad = true
        }
        self.showActionSheet(["One Way Trip","Return Trip"],isIpad: isIpad) { [self] value in
            if value == "Cancel"{
                txtFTrip.text = ""
                self.lblTripWarning.isHidden = false
            }else{
                self.lblTripWarning.isHidden = true
                txtFTrip.text = value
                if value == "Return Trip"{
                    viewReturnDate.isHidden = false
                    viewReturnTime.isHidden = false
                }else{
                    viewReturnDate.isHidden = true
                    viewReturnTime.isHidden = true
                }
            }
        }
    }
    
    
    @IBAction func btnSelectDepartDateClicked(_ sender: Any) {
        let datePicker = DatePickerView(frame: UIScreen.main.bounds)
        self.view.addSubview(datePicker)
        datePicker.onDoneClicked { (date) in
            self.txtFDepartureDate.text = date
        }
    }
    
    
    @IBAction func btnSelectDepartTimeClicked(_ sender: Any) {
        let timePicker = TimePickerView(frame: UIScreen.main.bounds)
        self.view.addSubview(timePicker)
        timePicker.onDoneClicked { (time) in
            self.txtFDepartureTime.text = time
        }
    }
    
    @IBAction func btnSelectClassClicked(_ sender: Any) {
        var isIpad = Bool()
        if Constants.deviceType == DeviceType.iPhone.rawValue{
            isIpad = false
        }else{
            isIpad = true

        }
        self.showActionSheet(["Economy Class","Business Class"],isIpad: isIpad) { value in
            if value == "Cancel"{
                self.lblClassWarning.isHidden = false
                self.txtFClass.text = ""
            }else{
                self.lblClassWarning.isHidden = true
                self.txtFClass.text = value
            }
        }
    }
    
    
    @IBAction func btnSelectReturnDateClicked(_ sender: Any) {
        let datePicker = DatePickerView(frame: UIScreen.main.bounds )
        self.view.addSubview(datePicker)
        datePicker.onDoneClicked { (date) in
            self.txtFReturnDate.text = date
        }
    }
    
    
    @IBAction func btnSelectReturnTimeClicked(_ sender: Any) {
        let timePicker = TimePickerView(frame: UIScreen.main.bounds)
        self.view.addSubview(timePicker)
        timePicker.onDoneClicked { (time) in
            self.txtFReturnTime.text = time
        }
    }
    
    @IBAction func btnBookClicked(_ sender: Any) {
        if validate(){
            configureBookingDetailsApi()
        }
    }
    
    
    @IBAction func btnDestinationCityClicked(_ sender: Any) {
   
    }
    
    
    @IBAction func btnDepartureCityClicked(_ sender: Any) {
    }
    
    
    @IBAction func btnTravellersClicked(_ sender: Any) {
        pushToTravelersView()
    }
    
  
}

extension BookingDetailsViewController : UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate{
    
    // MARK: TableView Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == tblViewDestination{
            return viewModel.destinationList?.count ?? 0
        }else{
            return viewModel.departureList?.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == tblViewDestination{
            let cell = tableView.dequeueReusableCell(withIdentifier: "CityListCell") as! CityListCell
            let model = viewModel.destinationList?[indexPath.row]
            cell.lblCity.text = "\(model?.city ?? "") \(model?.airportCode ?? "") \("-") \(model?.airportName ?? "")"
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "CityListCell") as! CityListCell
            let model = viewModel.departureList?[indexPath.row]
            cell.lblCity.text = "\(model?.city ?? "") \(model?.airportCode ?? "") \("-") \(model?.airportName ?? "")"
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
     //   self.isHideTblView = true
        if tableView == tblViewDestination{
            let model = viewModel.destinationList?[indexPath.row]
            VIEWMANAGER.bookDataForIpad.destinationCity = model?.city
            self.txtFDestination.text = "\(model?.city ?? "") \(model?.airportCode ?? "") \("-") \(model?.airportName ?? "")"
            self.destinationCode = model?.airportCode ?? ""
            ViewManager.shared.journeyRoute.1 = model?.city ?? ""
            DispatchQueue.main.async {
                self.tblViewDestination.isHidden = true
            }
            self.isCityApiCall = false
        }else{
            let model = viewModel.departureList?[indexPath.row]
            self.txtFOriginCity.text = "\(model?.city ?? "") \(model?.airportCode ?? "") \("-") \(model?.airportName ?? "")"
            VIEWMANAGER.bookDataForIpad.departureCity = model?.city
            self.departureCode = model?.airportCode ?? ""
            ViewManager.shared.journeyRoute.0 = model?.city ?? ""
            DispatchQueue.main.async {
                self.tblViewDeparture.isHidden = true
            }
            self.isCityApiCall = false
        }
    }
    
    // MARK: TextField Methods
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        resignFirstResponder()
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
 
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
       
        searchKeyword = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) ?? ""

        if textField == txtFDestination{
            self.lblDestinationWarning.isHidden = true
            if timer != nil {
                timer.invalidate()
                timer = nil
            }
            if searchKeyword.count > 0 {
                self.isCityApiCall = true
                timer = Timer.scheduledTimer(timeInterval: 0.3, target: self, selector: #selector(searchForKeyword), userInfo: nil, repeats: false)
            }
            self.tblViewDestination.isHidden = searchKeyword == ""
        }
        
        if textField == txtFOriginCity{
            self.lblOriginWarning.isHidden = true
            if timer1 != nil {
                timer1.invalidate()
                timer1 = nil
            }
            if searchKeyword.count > 0 {
                self.isCityApiCall = true
                timer1 = Timer.scheduledTimer(timeInterval: 0.3, target: self, selector: #selector(searchForKeywordforOriginCity), userInfo: nil, repeats: false)
            }
            self.tblViewDeparture.isHidden = searchKeyword == ""
        }
        return true
    }
    
    @objc func searchForKeywordforOriginCity() {
        if searchKeyword.trimString().count >= 1{
            if searchKeyword.count >= 2{
                configure(city: searchKeyword,isDestination: false)
            }
        }
    }
    
    @objc func searchForKeyword() {
        if searchKeyword.trimString().count >= 1{
            if searchKeyword.count >= 2{
                configure(city: searchKeyword,isDestination: true)
            }
        }
    }
    
}

extension BookingDetailsViewController: BookingDetailProtocol {
    var controller: BookingDetailsViewController {
        self
    }
}


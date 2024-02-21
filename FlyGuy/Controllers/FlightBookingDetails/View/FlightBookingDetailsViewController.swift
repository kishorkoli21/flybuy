//
//  FlightBookingDetailsViewController.swift
//  FlyGuy
//
//  Created by Springup Labs on 15/05/23.
//

import UIKit
import SystemConfiguration

protocol FlightbookingDetailDetailProtocol {
    var controller: FlightBookingDetailsViewController { get }
}

class FlightBookingDetailsViewController: BaseViewController, UIDocumentPickerDelegate {

    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var tblViewPassangerDetails: UITableView!
    @IBOutlet weak var tblViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var tblViewPassangerHeightConstraints: NSLayoutConstraint!
    @IBOutlet weak var ViewBG: UIView!
    @IBOutlet weak var ViewBGPassenger: UIView!
    @IBOutlet weak var lblAirlinesName: UILabel!
    @IBOutlet weak var lblConfirmationNumber: UILabel!
    @IBOutlet weak var lblClassType: UILabel!
    @IBOutlet weak var lblFairRules: UILabel!
    @IBOutlet weak var viewBGDownload: UIView!
    @IBOutlet weak var viewBGShare: UIView!
    @IBOutlet weak var viewBGCancel: UIView!
    @IBOutlet weak var lblCancellation: UILabel!
    @IBOutlet weak var lblRefund: UILabel!
    @IBOutlet weak var viewcancel: UIView!
    @IBOutlet weak var lblFairRulesHeading: UILabel!
    @IBOutlet weak var lblRefundTitle: UILabel!
    @IBOutlet weak var lblRefundStatus: UILabel!
    @IBOutlet weak var hideView: UIView!
    @IBOutlet weak var viewBottomFairRules: UIView!
    
    var viewModel = FlightBookingDetailsViewModel()
    var arrFlightList : [ReservationItemElement]?
    var arrPassengerList : [CustomerInfoElement]?
    var travelCities : (String, String) = ("", "")
    var arrCityList : [String]? = []
    var airLineCityList : [ResultCityList]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ViewBG.addShadow()
        viewBGDownload.addShadow()
        viewBGShare.addShadow()
        viewBGCancel.addShadow()
        ViewBGPassenger.addShadow()

        if Constants.deviceType == DeviceType.iPhone.rawValue{
            tblView.register(UINib(nibName: "FlightBookingFlightInfoCell", bundle: nil), forCellReuseIdentifier: "FlightBookingFlightInfoCell")
            tblViewPassangerDetails.register(UINib(nibName: "FlightBookingPassangerInfoCell", bundle: nil), forCellReuseIdentifier: "FlightBookingPassangerInfoCell")
        }else{
            tblView.register(UINib(nibName: "FlightBookingFlightInfoIpadCell", bundle: nil), forCellReuseIdentifier: "FlightBookingFlightInfoIpadCell")
            tblViewPassangerDetails.register(UINib(nibName: "FlightBookingPassangerInfoIpadCell", bundle: nil), forCellReuseIdentifier: "FlightBookingPassangerInfoIpadCell")
        }
    }
 
    override func viewDidDisappear(_ animated: Bool) {
        self.tblView.removeObserver(self, forKeyPath: "contentSize", context: nil)
        self.tblViewPassangerDetails.removeObserver(self, forKeyPath: "contentSize1", context: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //  downloadTicketApiConfigure()
        self.hideView.isHidden = false
        self.tblView.addObserver(self, forKeyPath: "contentSize", options: [], context: nil)
        self.tblViewPassangerDetails.addObserver(self, forKeyPath: "contentSize1", options: [], context: nil)
        
        if ViewManager.shared.fromScreen == "Completed"{
            self.viewBGCancel.isHidden = true
        }
        if ViewManager.shared.fromScreen == "Upcoming"{
            self.viewBGCancel.isHidden = false
        }
        if ViewManager.shared.fromScreen == "Cancelled" || ViewManager.shared.isFromCancel == true {
            self.viewBGCancel.isHidden = true
            self.viewcancel.isHidden = false
            if ViewManager.shared.refundAmount == "InProcess"{
                self.lblCancellation.text = "In-Progress, Please check after 20 minutes."
                self.lblRefund.isHidden = true
                self.lblRefundTitle.isHidden = true
                self.lblRefundStatus.text = "Under Process"
            }else{
                self.lblCancellation.text = "Completed"
                self.lblRefund.text = " $\(ViewManager.shared.refundAmount)"
                self.lblRefundTitle.isHidden = false
                self.lblRefundStatus.text = ViewManager.shared.refundStatus
            }
        }
        if let ipAddress = UIDevice.current.getIP() {
            configure(ipAddress: ipAddress)
            // if ViewManager.shared.fromScreen == ""{
            configureFairRulesApi()
            // }
            print("IP Address: \(ipAddress)")
        } else {
            //configure(ipAddress: "49.248.120.66")
            print("Unable to retrieve IP address.")
        }
    }
    
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        self.tblViewHeightConstraint.constant = tblView.contentSize.height
        self.tblViewPassangerHeightConstraints.constant = tblViewPassangerDetails.contentSize.height
    }
    
    // MARK: Api Integration methods

    func configure(ipAddress: String){
        viewModel.view = self
//        let model1 = ConfirmBookingDetailInputDTO(userID : Constants.dataScalp_UserID, userPassword: Constants.dataScalp_Password, access: "Production", ipAddress: "54.211.251.205", uniqueID: ViewManager.shared.pnrID)
          let model1 = ConfirmBookingDetailInputDTO(pnrID: ViewManager.shared.pnrID)
        
        viewModel.getFlightBookingDetailApi(Parameters: model1) { isSuccess in
            if isSuccess{
                self.arrFlightList = self.viewModel.arrFlightList
                self.arrPassengerList = self.viewModel.arrPassengerList
                self.lblConfirmationNumber.text = self.arrFlightList?[0].reservationItem?.airlinePNR //self.viewModel.travelDetailModel.tripDetailsResponse?.tripDetailsResult?.travelItinerary?.itineraryInfo?.reservationItems.airlinePNR
                self.lblClassType.text = self.arrFlightList?[0].reservationItem?.cabinClassText
                self.lblAirlinesName.text = self.arrFlightList?[0].reservationItem?.operatingAirlineCode
                self.tblView.reloadData()
                self.tblViewPassangerDetails.reloadData()
                self.configure(airPortCode: self.arrFlightList?[0].reservationItem?.operatingAirlineCode ?? "")
                if let flightList = self.arrFlightList {
                    for value in flightList {
                        if let departureCode = value.reservationItem?.departureAirportLocationCode {
                            self.arrCityList?.append(departureCode)
                        }
                    }
                    for value in flightList {
                        if let arrivalCode = value.reservationItem?.arrivalAirportLocationCode {
                            self.arrCityList?.append(arrivalCode)
                        }
                    }
                    self.configure(AirlineCityList: self.arrCityList!)
                }
                self.hideView.isHidden = true
            }else{
                DispatchQueue.main.async {
                    self.ViewBG.isHidden = true
                    self.ViewBGPassenger.isHidden = true
                    self.hideView.isHidden = false
                }
            }
        }
    }
    
    func configureFairRulesApi(){
        let arrStaticFareRules = ["Passengers should report at least two hours before the departure time.",
                                  "Boarding gates will close 20 minutes before departure. Passengers will be required to wear the protective gear (Face mask).",
                                  "Passengers who have flights departing in the next 4 hours will be allowed to enter the terminal building All Passengers must carry a Valid Photo Identity Proof at the time of entering into airport."]
        viewModel.view = self
        let modelFairRules = FareRulesInputDTO(sessionID: ViewManager.shared.flightList.sessionID ?? "",fareSourceCode: ViewManager.shared.fareSourceCode)
        viewModel.getFareRulesApi(Parameters: modelFairRules) { isSuccess in
            if isSuccess{
                guard let fareRules = self.viewModel.arrFareRules else {
                    return
                }
                
                let attributedString = NSMutableAttributedString()
                
                for fareRule in fareRules {
                    if let rules = fareRule.fareRule?.rules {
                        let linkURL = URL(string: rules)
                        
                        let attributedLink = NSAttributedString(string: rules + "\n", attributes: [.link: linkURL ?? URL(fileURLWithPath: "")])
                        attributedString.append(attributedLink)
                    }
                }
                
                let linkAttributes: [NSAttributedString.Key: Any] = [
                    .foregroundColor: UIColor.blue,
                    .underlineStyle: NSUnderlineStyle.single.rawValue,
                    .font: UIFont.systemFont(ofSize: 18)
                ]
                attributedString.addAttributes(linkAttributes, range: NSRange(location: 0, length: attributedString.length))
                
                let mutableAttributedString = NSMutableAttributedString(attributedString: attributedString)
                if mutableAttributedString.length > 1{
                    mutableAttributedString.deleteCharacters(in: NSRange(location: mutableAttributedString.length - 2, length: 2))
                }
                self.lblFairRules.attributedText = mutableAttributedString
               
              //  self.lblFairRules.attributedText = attributedString
                self.lblFairRules.isUserInteractionEnabled = true
                
                let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.labelTapped(_:)))
                self.lblFairRules.addGestureRecognizer(tapGesture)
                
                if self.lblFairRules.text == "" || self.lblFairRules.text == nil || ((self.lblFairRules.text?.hasPrefix("\n\n")) != nil) {
                    let formattedString = arrStaticFareRules.joined(separator: "\n")
                    self.lblFairRules.text = formattedString
                }
            }
            else{
                self.lblFairRulesHeading.isHidden = true
                self.viewBottomFairRules.isHidden = true
                self.lblFairRules.isHidden = true
//                let formattedString = arrStaticFareRules.joined(separator: "\n")
//                self.lblFairRules.text = formattedString
            }
            
        }
    }
    
    func configure(airPortCode: String){
        viewModel.view = self
        var model = AirlineNameInpuDTO()
        model.airlineCode = airPortCode
        viewModel.getAirlineNameApi(Parameters: model) { isSuccess in
            if isSuccess{
                self.lblAirlinesName.text = self.viewModel.airportName
            }
        }
    }
    
    func configure(AirlineCityList: [String]){
        var model = AirlineCityNameInpuDTO()
        model.airportCode = AirlineCityList
        
        viewModel.view = self
        viewModel.getAirlineCityListApi(Parameters: model) { isSuccess in
            if isSuccess{
                self.tblView.reloadData()
            }
        }
    }
    
    // MARK: Action methods for fairrules label touch
    
    
    @objc func labelTapped(_ gesture: UITapGestureRecognizer) {
        guard let attributedText = self.lblFairRules.attributedText else {
            return
        }
        let layoutManager = NSLayoutManager()
        let textContainer = NSTextContainer(size: self.lblFairRules.bounds.size)
        let textStorage = NSTextStorage(attributedString: attributedText)

        layoutManager.addTextContainer(textContainer)
        textStorage.addLayoutManager(layoutManager)

        let tapLocation = gesture.location(in: self.lblFairRules)
        let characterIndex = layoutManager.characterIndex(for: tapLocation, in: textContainer, fractionOfDistanceBetweenInsertionPoints: nil)

        attributedText.enumerateAttribute(.link, in: NSRange(location: 0, length: attributedText.length), options: []) { (attribute, range, _) in
            if let link = attribute as? URL, NSLocationInRange(characterIndex, range) {
                // Handle the tapped link, for example:
                UIApplication.shared.open(link)
            }
        }
    }
    
    // MARK: Download methods for download ticket button clicked

  
    func startDownload(downloadURLString : String) {
        guard let downloadURL = URL(string: downloadURLString) else {
            self.showAlert(msg: "Invalid download URL")
            return
        }
        
        let session = URLSession(configuration: .default, delegate: self, delegateQueue: nil)
        let downloadTask = session.downloadTask(with: downloadURL)
        downloadTask.resume()
    }
    
    // URLSessionDownloadDelegate method to handle the downloaded file
    override func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            print("Unable to access document directory")
            return
        }
        
        let destinationURL = documentDirectory.appendingPathComponent("FlyGuy_Ticket_\(ViewManager.shared.pnrID).pdf")
        
        do {
            try FileManager.default.moveItem(at: location, to: destinationURL)
            DispatchQueue.main.async {
                // Show document picker to save the file in the Files app
                let documentPicker = UIDocumentPickerViewController(url: destinationURL, in: .exportToService)
                documentPicker.delegate = self
                self.present(documentPicker, animated: true, completion: nil)
            }
        } catch {
            self.showAlert(msg: "Failed to move downloaded file")
        }
    }
    
    // UIDocumentPickerDelegate method to handle the document picker's completion
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        print("File picked: \(urls)")
        // Handle the completion of saving the file in the Files app
    }
    
    // Handle any errors during the download
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        if let error = error {
            self.showAlert(msg: "Download error: \(error.localizedDescription)")
        }
    }

    // MARK: Navigation methods
    
    func moveToTabBar(){
        let storyBoard : UIStoryboard = UIStoryboard(name: Storyboards.HomeStoryboard, bundle:nil)
        let tabBarViewController = storyBoard.instantiateViewController(withIdentifier: Constants.tabBarIdentifier) as! UITabBarController
        self.navigationController?.pushViewController(tabBarViewController, animated: true)
    }
    
    func moveToHomeVCiPad(){
        let storyBoard : UIStoryboard = UIStoryboard(name: Storyboards.HomeiPadStoryboard, bundle:nil)
        let homeVC = storyBoard.instantiateViewController(withIdentifier: ViewControllers.HomeViewController) as! HomeViewController
        homeVC.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(homeVC, animated: true)
    }
    
    func navigateToCancelFlightScreen(){
        let storyID = UIStoryboard(name: Storyboards.UpcomingFlightsStoryboard, bundle:nil)
        let vc = storyID.instantiateViewController(withIdentifier: ViewControllers.CancelViewController) as! CancelViewController
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: true)
    }
    
    // MARK: Button Action methods
    
    
    @IBAction func btnHomeClicked(_ sender: Any) {
        if ViewManager.shared.fromScreen == "Completed"{
            if Constants.deviceType == DeviceType.iPad.rawValue{
                removeIpad(asChildViewController: FlightBookingDetailVCiPad)
                addIpad(asChildViewController: CompletedFlightsiPad)
            }else{
                self.navigationController?.popViewController(animated: true)
            }
        }else if ViewManager.shared.fromScreen == "Cancelled"{
            if Constants.deviceType == DeviceType.iPad.rawValue{
                removeIpad(asChildViewController: FlightBookingDetailVCiPad)
                addIpad(asChildViewController: CancelledFlightsiPad)
            }else{
                self.navigationController?.popViewController(animated: true)
            }
        }else if ViewManager.shared.fromScreen == "Upcoming"{
            if Constants.deviceType == DeviceType.iPad.rawValue{
                removeIpad(asChildViewController: FlightBookingDetailVCiPad)
                addIpad(asChildViewController: UpcomingFlightsiPad)
            }else{
                if ViewManager.shared.isFromCancel == true{
                    moveToTabBar()
                }else {
                    self.navigationController?.popViewController(animated: true)
                }
            }
        }else{
            if Constants.deviceType == DeviceType.iPad.rawValue{
                removeIpad(asChildViewController: FlightBookingDetailVCiPad)
                addIpad(asChildViewController: HomeVCiPad)
            }else{
                moveToTabBar()
            }
        }
       
    }
    
    @IBAction func btnCancelClicked(_ sender: Any) {
        if Constants.deviceType == DeviceType.iPhone.rawValue{
            navigateToCancelFlightScreen()
        }else{
            removeIpad(asChildViewController: FlightBookingDetailVCiPad)
            addIpad(asChildViewController: CancelFlightiPad)
        }
    }
    
    
    @IBAction func btnShareClicked(_ sender: Any) {
        let url = API.downloadTicketApi.rawValue.self
        let pnrid = url + ViewManager.shared.pnrID
        let BaseURL = Bundle.main.infoDictionary?[Constants.baseURL]
        let finalURL = BaseURL as! String + pnrid

        if let sharingUrl = URL(string: finalURL), !sharingUrl.absoluteString.isEmpty {
          let objectsToShare = [sharingUrl]
          let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)

          // Set the source view for the popover presentation
          if let popoverPresentationController = activityVC.popoverPresentationController {
            popoverPresentationController.sourceView = self.view // Replace `self.view` with the appropriate view for your use case
          }

          self.present(activityVC, animated: true, completion: nil)
        } else {
          // Show alert for not available
        }
    }
    
    
    @IBAction func btnDownloadClicked(_ sender: Any) {
        let url = API.downloadTicketApi.rawValue.self
        let pnrid = url + ViewManager.shared.pnrID
        let BaseURL = Bundle.main.infoDictionary?[Constants.baseURL]
        let finalURL = BaseURL as! String + pnrid

        startDownload(downloadURLString: finalURL)
    }

    
}


extension FlightBookingDetailsViewController : UITableViewDataSource, UITableViewDelegate{
  
    // MARK: TableView methods

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == tblView{
            return arrFlightList?.count ?? 0
        }else{
            return arrPassengerList?.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == tblView{
            if Constants.deviceType == DeviceType.iPhone.rawValue{
                let cell = tableView.dequeueReusableCell(withIdentifier: "FlightBookingFlightInfoCell") as! FlightBookingFlightInfoCell
                let model = arrFlightList?[indexPath.row]
                if let mod = model {
                    cell.setUpData(model: mod)
                    if viewModel.airLineCityListOutput?.count != 0{
                        if let airLineCityList = viewModel.airLineCityListOutput {
                            let filteredAirports = airLineCityList.filter { airport in
                                if let airportCode = airport.airportCode {
                                    if airportCode == mod.reservationItem?.departureAirportLocationCode{
                                        cell.lblOriginCode.text = airport.city
                                    }
                                    if airportCode == mod.reservationItem?.arrivalAirportLocationCode{
                                        cell.lblDestinationCode.text = airport.city
                                    }
                                }
                                return false
                            }
                            
                        }
                    }
                }
                cell.travelCities = self.travelCities
             //   cell.airLineCityList = viewModel.airLineCityListOutput
                return cell
            }else{
                let cell = tableView.dequeueReusableCell(withIdentifier: "FlightBookingFlightInfoIpadCell") as! FlightBookingFlightInfoIpadCell
                let model = arrFlightList?[indexPath.row]
                if let mod = model {
                    cell.setUpData(model: mod)
                    if viewModel.airLineCityListOutput?.count != 0{
                        if let airLineCityList = viewModel.airLineCityListOutput {
                            let filteredAirports = airLineCityList.filter { airport in
                                if let airportCode = airport.airportCode {
                                    if airportCode == mod.reservationItem?.departureAirportLocationCode{
                                        cell.lblOriginCode.text = airport.city
                                    }
                                    if airportCode == mod.reservationItem?.arrivalAirportLocationCode{
                                        cell.lblDestinationCode.text = airport.city
                                    }
                                }
                                return false
                            }
                        }
                    }
                }
                cell.travelCities = self.travelCities
                cell.airLineCityList = viewModel.airLineCityListOutput
                return cell
            }
        }else{
            if Constants.deviceType == DeviceType.iPhone.rawValue{
                let cell = tableView.dequeueReusableCell(withIdentifier: "FlightBookingPassangerInfoCell") as! FlightBookingPassangerInfoCell
                let model = arrPassengerList?[indexPath.row]
                let internalModel = model?.customerInfo
                cell.lblPassengerName.text = "\(internalModel?.passengerFirstName ?? "") \(internalModel?.passengerLastName ?? "")"
                cell.lblTicketNumber.text = internalModel?.eTicketNumber
                if internalModel?.passengerType == "ADT"{
                    cell.lblType.text = "Adult"
                }else if internalModel?.passengerType  == "CHD"{
                    cell.lblType.text = "Child"
                }else{
                    cell.lblType.text =  "Infant"
                }
            
                return cell
            }else{
                let cell = tableView.dequeueReusableCell(withIdentifier: "FlightBookingPassangerInfoIpadCell") as! FlightBookingPassangerInfoIpadCell
                let model = arrPassengerList?[indexPath.row]
                let internalModel = model?.customerInfo
                cell.lblPassengerName.text = "\(internalModel?.passengerFirstName ?? "") \(internalModel?.passengerLastName ?? "")"
                cell.lblTicketNumber.text = internalModel?.eTicketNumber
                if internalModel?.passengerType == "ADT"{
                    cell.lblType.text = "Adult"
                }else if internalModel?.passengerType  == "CHD"{
                    cell.lblType.text = "Child"
                }else{
                    cell.lblType.text =  "Infant"
                }

                return cell
            }
        }
    }
    
}

extension FlightBookingDetailsViewController: FlightbookingDetailDetailProtocol {
    var controller: FlightBookingDetailsViewController {
        self
    }
}



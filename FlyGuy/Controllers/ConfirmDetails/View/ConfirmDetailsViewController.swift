//
//  ConfirmDetailsViewController.swift
//  FlyGuy
//
//  Created by Springup Labs on 10/05/23.
//

import UIKit

protocol ConfirmDetailProtocol {
    var controller: ConfirmDetailsViewController { get }
}

class ConfirmDetailsViewController: BaseViewController {

    @IBOutlet weak var BGView: UIView!
    @IBOutlet weak var lblBaseFare: UILabel!
    @IBOutlet weak var lblFeeSurcharge: UILabel!
    @IBOutlet weak var lblTravelInsurance: UILabel!
    @IBOutlet weak var lblConvinienceFee: UILabel!
    @IBOutlet weak var lblTotalFare: UILabel!
    @IBOutlet weak var lblFairRules: UILabel!
    @IBOutlet weak var lblFairRuleTitle: UILabel!
    @IBOutlet weak var viewBottomFairRules: UIView!
    
    
    var viewModel = ConfirmDetailViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if Constants.deviceType == DeviceType.iPhone.rawValue{
            BGView.addShadowForCell()
        }else{
            BGView.addShadowForiPadCell()
        }
        setFares()
        configureFairRulesApi()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setFares()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        stopSpinner()
    }
    
    // MARK: Initial View Setup methods
    
    func setFares(){
        var serviceChargeWithPaymentCharge : Float = 0.0
        let model = ViewManager.shared.selectedFlightDetails
        let currencyModel = model.fareItinerary?.airItineraryFareInfo?.itinTotalFares
        if currencyModel?.totalFare?.currencyCode == "USD"{
            lblBaseFare.text =  "$\(currencyModel?.baseFare?.amount ?? "-")"
            lblFeeSurcharge.text =  "$\(currencyModel?.serviceTax?.amount ?? "-")"
            lblTravelInsurance.text =  "$\(currencyModel?.totalTax?.amount ?? "-")"
            let totalFare = currencyModel?.totalFare?.amount
            let percentChargePaymentGateway = (Float(Constants.paymentGatewayPercentageCharge) / 100) * (totalFare?.floatValue ?? 0.0)
            
            if let doubleValue = Double(Constants.serviceCharge) {
                let intValue = Int(doubleValue)
                let totalServiceCharge = VIEWMANAGER.paxCount * intValue
                serviceChargeWithPaymentCharge = Float(totalServiceCharge) + percentChargePaymentGateway
                let formattedServiceCharge = String(format: "%.2f", serviceChargeWithPaymentCharge)
                lblConvinienceFee.text =  "$\(formattedServiceCharge)"
            }
                       
            let totAmount = (totalFare?.floatValue ?? 0.0) + serviceChargeWithPaymentCharge
            let formattedValue = String(format: "%.2f", totAmount)
            lblTotalFare.text = "$\(formattedValue)"
            ViewManager.shared.TotalTicketPrice = "\(formattedValue)"
        }

    }
    
    // MARK: Api Integration methods
    
    func configureFairRulesApi(){
        let arrStaticFareRules = ["Passengers should report at least two hours before the departure time.",
                                  "Boarding gates will close 20 minutes before departure. Passengers will be required to wear the protective gear (Face mask).",
                                  "Passengers who have flights departing in the next 4 hours will be allowed to enter the terminal building All Passengers must carry a Valid Photo Identity Proof at the time of entering into airport."]
        let attributedString = NSMutableAttributedString()
        viewModel.view = self
        let modelFairRules = FareRulesInputDTO(sessionID: ViewManager.shared.flightList.sessionID ?? "",fareSourceCode: ViewManager.shared.fareSourceCode)
        viewModel.getFareRulesApi(Parameters: modelFairRules) { isSuccess in
            if isSuccess{
                guard let fareRules = self.viewModel.arrFareRules else {
                    return
                }
                
                for fareRule in fareRules {
                    if let rules = fareRule.fareRule?.rules {
                        let linkURL = URL(string: rules)
                        
                        let attributedLink = NSAttributedString(string: rules + "\n", attributes: [.link: linkURL ?? URL(fileURLWithPath: "")])
                        attributedString.append(attributedLink)
                    }
                }
                if self.lblFairRules.text != "" || self.lblFairRules.text != nil || self.lblFairRules.text != "\n\n\n" {
                    
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
                }
                
                if self.lblFairRules.text == "" || self.lblFairRules.text == nil || ((self.lblFairRules.text?.hasPrefix("\n\n")) != nil) {
                    let formattedString = arrStaticFareRules.joined(separator: "\n")
                    self.lblFairRules.text = formattedString
                }
            }
            else{
                self.lblFairRuleTitle.isHidden = true
                self.viewBottomFairRules.isHidden = true
                self.lblFairRules.isHidden = true
            }
        }
    }
    
    func configureFlightBooking(){
        viewModel.view = self
        let model = ViewManager.shared.selectedFlightDetails
        let allDetailsModel = ViewManager.shared.flightList
        let loginDetails = ViewManager.shared.loginDetails
        
        let flightBookingInfo = FlightBookingInformation(flightSessionID: allDetailsModel.sessionID ,fareSourceCode: model.fareItinerary?.airItineraryFareInfo?.fareSourceCode,isPassportMandatory: VIEWMANAGER.isPassportMandatory == true ? "true" : "false", fareType: model.fareItinerary?.airItineraryFareInfo?.fareType, areaCode: "080",countryCode: "91")
       
        let paxinfo = PaxInfo(clientRef: loginDetails.userID, postCode: "", customerEmail: loginDetails.email, customerPhone: loginDetails.phonenumber ,bookingNote: "", paxDetails :[ViewManager.shared.paxDetail])
        
        let airlineName = model.fareItinerary?.originDestinationOptions?[0]
        
        let currencyModel = model.fareItinerary?.airItineraryFareInfo?.itinTotalFares
        let totFare = currencyModel?.totalFare?.amount
        let serviceCharge = Constants.serviceCharge
        let totalticketPrice = (totFare?.floatValue ?? 0.0) + serviceCharge.floatValue
        
        let bookingDetail = BookingDetails(trip : ViewManager.shared.isReturn ? "Return" : "oneway", from: ViewManager.shared.journeyRoute.0, to: ViewManager.shared.journeyRoute.1, fromtime: ViewManager.shared.journeyDate.2,totime: ViewManager.shared.journeyDate.3, airlineName: airlineName?.originDestinationOption?[0].flightSegment?.marketingAirlineName, bookingprice: "\(totalticketPrice)", totalStop: "\(airlineName?.totalStops ?? 0)",flightNo: airlineName?.originDestinationOption?[0].flightSegment?.flightNumber, ticketID: "")
        
        let jorneyDateTime = airlineName?.originDestinationOption?[0].flightSegment?.departureDateTime ?? ""
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        let date = formatter.date(from: jorneyDateTime) ?? Date()
        formatter.dateFormat = "yyyy-MM-dd"
        let jorneyDate = formatter.string(from: date)
        formatter.dateFormat = "HH:mm:ss"
        let journeytime = formatter.string(from: date)
        
        let finalModel = FlightBookingInputDTO(flightBookingInfo: flightBookingInfo, paxInfo: paxinfo,bookingDetails: bookingDetail, userID : loginDetails.userID, pnrID : "", cancellationStatus: "", paymentID: "", journeyTime : journeytime, journeyDate : jorneyDate, createdBy: loginDetails.userID)

        viewModel.getFlightBookingApi(Parameters: finalModel) { isSuccess in
            if isSuccess{
                if Constants.deviceType == DeviceType.iPhone.rawValue{
                    self.navigateToFlightBookingDetails()
                }else{
                    self.removeIpad(asChildViewController: self.ConfirmDetailsVCiPad)
                    self.addIpad(asChildViewController: self.FlightBookingDetailVCiPad)
                }
            }else{
                self.viewBottomFairRules.isHidden = true
                self.lblFairRuleTitle.isHidden = true
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
    
    // MARK: Navigation methods

    func navigateToFlightBookingDetails(){
        let storyID = UIStoryboard(name: Storyboards.FlightBookingDetailsStoryboard, bundle:nil)
        let vc = storyID.instantiateViewController(withIdentifier: ViewControllers.FlightBookingDetailsViewController) as! FlightBookingDetailsViewController
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func navigateToPayementIntegrationScreen(){
        let storyID = UIStoryboard(name: Storyboards.PaymentGatewayStoryboard, bundle:nil)
        let vc = storyID.instantiateViewController(withIdentifier: ViewControllers.PaymentGatewayViewController) as! PaymentGatewayViewController
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func navigateToBookingDetails(){
        if Constants.deviceType == DeviceType.iPad.rawValue{
            removeIpad(asChildViewController: self.ConfirmDetailsVCiPad)
            addIpad(asChildViewController: self.BookVCiPad)
        }else{
            let storyID = UIStoryboard(name: Storyboards.BookingDetailStoryboard, bundle:nil)
            let vc = storyID.instantiateViewController(withIdentifier: ViewControllers.BookingDetailViewController) as! BookingDetailsViewController
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
   
    
    // MARK: Button Action methods
    
    @IBAction func btnHomeClicked(_ sender: Any) {
        if Constants.deviceType == DeviceType.iPad.rawValue{
            removeIpad(asChildViewController: self.ConfirmDetailsVCiPad)
            addIpad(asChildViewController: TravelDetailsVCiPad)
            //ViewManager.shared.isReturn ? self.FlightListInboundVCiPad : self.FlightListVCiPad
        }else{
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    
    @IBAction func btnConfirmClicked(_ sender: Any) {
        if Constants.deviceType == DeviceType.iPhone.rawValue{
            self.navigateToCheckoutAuthorize()
        }else{
            self.removeIpad(asChildViewController: self.ConfirmDetailsVCiPad)
            self.addIpad(asChildViewController: self.CheckoutAuthorizeiPad)
        }
    }
    
    func navigateToCheckoutAuthorize(){
        let storyID = UIStoryboard(name: Storyboards.PaymentGatewayStoryboard, bundle:nil)
        let vc = storyID.instantiateViewController(withIdentifier: ViewControllers.ProceedToCheckoutVC) as! ProceedToCheckoutVC
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
}

extension ConfirmDetailsViewController: ConfirmDetailProtocol {
    var controller: ConfirmDetailsViewController {
        self
    }
}


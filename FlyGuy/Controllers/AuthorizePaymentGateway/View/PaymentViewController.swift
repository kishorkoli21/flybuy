//
//  PaymentViewController.swift
//  FlyGuy
//
//  Created by Springup Labs on 01/08/23.
//

import UIKit

protocol PaymentAuthorizeProtocol {
    var controller: PaymentViewController { get }
}

class PaymentViewController: BaseViewController {
    
    @IBOutlet weak var txtFCardNumber: UITextField!
    @IBOutlet weak var txtFExpireDate: UITextField!
    @IBOutlet weak var txtFSecurityCode: UITextField!
    
    let viewModel = PaymentViewModel()
    var successPaymentView: UIView?
    var failurePaymentView: UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txtFCardNumber.delegate = self
        txtFExpireDate.delegate = self
        txtFSecurityCode.delegate = self
        VIEWMANAGER.isShowPaymentAddressForIpad = true
    }
    
    // MARK: Validation Textfields Methods
    
    func validate() -> Bool {
        
        if txtFCardNumber.text!.trimString().count == 0 {
            self.showAlert(msg: Messages.CardNumber)
            return false
        }
        if txtFExpireDate.text!.trimString().count == 0 {
            self.showAlert(msg: Messages.ExpirationDate)
            return false
        }
        if txtFSecurityCode.text!.trimString().count == 0 {
            self.showAlert(msg: Messages.SecurityCode)
            return false
        }
        return true
        
    }
    
    // MARK: Success Failure View Methods
    
    func showPaymentSuccessView() {
        if let successPaymentView = Bundle.main.loadNibNamed("SuccessPaymentView", owner: self, options: nil)?.first as? UIView {
            self.successPaymentView = successPaymentView
            successPaymentView.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height)
            successPaymentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            self.configureFlightBooking()
            view.addSubview(successPaymentView)
        }
    }
    
    func showPaymentFailView() {
        if let failurePaymentView = Bundle.main.loadNibNamed("FailurePaymentView", owner: self, options: nil)?.first as? UIView {
            self.failurePaymentView = failurePaymentView
            failurePaymentView.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height)
            failurePaymentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            
            view.addSubview(failurePaymentView)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) {
                self.failurePaymentView?.removeFromSuperview()
                self.failurePaymentView = nil
                if Constants.deviceType == DeviceType.iPad.rawValue{
                    self.removeIpad(asChildViewController: self.PaymentAuthorizeiPad)
                    self.addIpad(asChildViewController: self.AddAddressAuthorizeiPad)
                }else{
                    self.navigationController?.popViewController(animated: true)
                }
            }
        }
    }
    
    // MARK: Api integration Methods
    
    func configure(){
        viewModel.view1 = self
        let addressModel = VIEWMANAGER.paymentModel
        let billTo = BillTo(firstName: addressModel.firstName,lastName: addressModel.lastName,address: addressModel.address,city: addressModel.city,state: addressModel.state,zip: addressModel.zipcode)
        let payment = Payment(creditCard: CreditCard(cardNumber: txtFCardNumber.text,expirationDate: txtFExpireDate.text,cardCode: txtFSecurityCode.text))
        let createTransRequest = CreateTransactionRequest(
            merchantAuthentication: MerchantAuthentication(name: "", transactionKey: ""),
            refID: "1234567",
            transactionRequest: TransactionRequest(
                transactionType: "authCaptureTransaction",
                amount: ViewManager.shared.TotalTicketPrice,
                payment: payment,
                billTo: billTo
            )
        )
        let model = PaymentAuthorizeInputDTO(createTransactionRequest: createTransRequest)
        viewModel.getPaymentAuthorizeApi(Parameters: model) { isSuccess in
            if isSuccess{
                self.showPaymentSuccessView()
            }else{
                self.showPaymentFailView()
            }
        }
    }
    
    func configureFlightBooking(){
        viewModel.view1 = self
        let model = ViewManager.shared.selectedFlightDetails
        let allDetailsModel = ViewManager.shared.flightList
        let loginDetails = ViewManager.shared.loginDetails
        
        let flightBookingInfo = FlightBookingInformation(flightSessionID: allDetailsModel.sessionID ,fareSourceCode: model.fareItinerary?.airItineraryFareInfo?.fareSourceCode,isPassportMandatory: VIEWMANAGER.isPassportMandatory == true ? "true" : "false", fareType: model.fareItinerary?.airItineraryFareInfo?.fareType, areaCode: "080",countryCode: "91")
        
        let paxinfo = PaxInfo(clientRef: loginDetails.userID, postCode: "", customerEmail: loginDetails.email, customerPhone: loginDetails.phonenumber ,bookingNote: "", paxDetails :[ViewManager.shared.paxDetail])
        
        let airlineName = model.fareItinerary?.originDestinationOption?[0]
        
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
        
        let finalModel = FlightBookingInputDTO(flightBookingInfo: flightBookingInfo, paxInfo: paxinfo,bookingDetails: bookingDetail, userID : loginDetails.userID, pnrID : "", cancellationStatus: "", paymentID: "", journeyTime : journeytime, journeyDate : jorneyDate, createdBy: loginDetails.userID,refId: viewModel.authorizePaymentResponse.result?.refID)
        
        viewModel.getFlightBookingApi(Parameters: finalModel) { isSuccess in
            if isSuccess{
                DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) {
                    self.successPaymentView?.removeFromSuperview()
                    self.successPaymentView = nil
                }
                
                ViewManager.shared.fromScreen = ""
                ViewManager.shared.isFromCancel = false
                
                if Constants.deviceType == DeviceType.iPhone.rawValue{
                    self.navigateToFlightBookingDetails()
                }else{
                    self.removeIpad(asChildViewController: self.PaymentAuthorizeiPad)
                    self.addIpad(asChildViewController: self.FlightBookingDetailVCiPad)
                }
            }
            else{
                self.configureVoidPaymentApi()
            }
        }
    }
    
    func configureVoidPaymentApi(){
        viewModel.view1 = self
        let model = VoidPaymentAuthorizeInputDTO(createTransactionRequest: CreateTransactionRequests(merchantAuthentication: MerchantAuthentications(name: "", transactionKey: ""),refID: "1234567",transactionRequest: TransactionRequests(
            transactionType: "voidTransaction",refTransID: viewModel.authorizePaymentResponse.result?.transactionResponse?.transID)))
        viewModel.getVoidPaymentAuthorizeApi(Parameters: model) { isSuccess in
            if Constants.deviceType == DeviceType.iPad.rawValue{
                self.removeIpad(asChildViewController: self.PaymentAuthorizeiPad)
                self.addIpad(asChildViewController: self.HomeVCiPad)
            }else{
                self.moveToTabBar()
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
    
    func moveToTabBar(){
        let storyBoard : UIStoryboard = UIStoryboard(name: Storyboards.HomeStoryboard, bundle:nil)
        let tabBarViewController = storyBoard.instantiateViewController(withIdentifier: Constants.tabBarIdentifier) as! UITabBarController
        self.navigationController?.pushViewController(tabBarViewController, animated: true)
    }
    
    // MARK: Button Action methods
    
    @IBAction func btnBackClicked(_ sender: Any) {
        if Constants.deviceType == DeviceType.iPad.rawValue{
            self.removeIpad(asChildViewController: self.PaymentAuthorizeiPad)
            self.addIpad(asChildViewController: self.AddAddressAuthorizeiPad)
        }else{
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    @IBAction func btnConfirmClicked(_ sender: Any) {
        if validate(){
            configure()
        }
    }
    
    
}

extension PaymentViewController : UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
       
        if textField == txtFCardNumber{
            let currentText = txtFCardNumber.text ?? ""
            let newText = (currentText as NSString).replacingCharacters(in: range, with: string)
            return newText.count <= 16
        }

        if textField == txtFSecurityCode{
            let currentText = txtFSecurityCode.text ?? ""
            let newText = (currentText as NSString).replacingCharacters(in: range, with: string)
            return newText.count <= 4
        }
        return true
    }
    
}


extension PaymentViewController: PaymentAuthorizeProtocol {
    var controller: PaymentViewController {
        self
    }
}

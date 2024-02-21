//
//  ProceedToCheckoutVC.swift
//  FlyGuy
//
//  Created by Springup Labs on 01/08/23.
//

import UIKit
import PassKit

protocol ProceedToCheckoutProtocol {
    var controller: ProceedToCheckoutVC { get }
}

class ProceedToCheckoutVC: BaseViewController  {
    //PKPaymentAuthorizationViewControllerDelegate
    @IBOutlet weak var lbltotalAmount: UILabel!
    @IBOutlet weak var btnApplePay: UIButton!
    @IBOutlet weak var viewTotalAmount: UIView!
    
    let viewModel = ProceedCheckoutViewModel()
    var successPaymentView: UIView?
    var failurePaymentView: UIView?
    @objc let SupportedPaymentNetworks = [PKPaymentNetwork.visa, PKPaymentNetwork.masterCard, PKPaymentNetwork.amex, PKPaymentNetwork.chinaUnionPay,PKPaymentNetwork.discover,PKPaymentNetwork.maestro,PKPaymentNetwork.idCredit]
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        btnApplePay.layer.cornerRadius = 5
//        btnApplePay.layer.borderColor = UIColor.black.cgColor
//        btnApplePay.layer.borderWidth = 0.5
        lbltotalAmount.text =  "$\(ViewManager.shared.TotalTicketPrice)"
        viewTotalAmount.addShadow()
        VIEWMANAGER.isShowPaymentAddressForIpad = false
    }
 
    // MARK: Navigation methods
    
    func navigateToAddAddressScreen(){
        let storyID = UIStoryboard(name: Storyboards.PaymentGatewayStoryboard, bundle:nil)
        let vc = storyID.instantiateViewController(withIdentifier: ViewControllers.AddAddressViewController) as! AddAddressViewController
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: true)
    }
    
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
            removeIpad(asChildViewController: self.CheckoutAuthorizeiPad)
            addIpad(asChildViewController: self.ConfirmDetailsVCiPad)
        }else{
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    @IBAction func btnCheckoutClicked(_ sender: Any) {
        if Constants.deviceType == DeviceType.iPad.rawValue{
            removeIpad(asChildViewController: self.CheckoutAuthorizeiPad)
            addIpad(asChildViewController: self.AddAddressAuthorizeiPad)
        }else{
            navigateToAddAddressScreen()
        }
    }
    
    
    @IBAction func btnApplePayClicked(_ sender: Any) {
        
    }
    
}

extension ProceedToCheckoutVC: ProceedToCheckoutProtocol {
    var controller: ProceedToCheckoutVC {
        self
    }
}

//
//        let supportedNetworks = [ PKPaymentNetwork.visa, PKPaymentNetwork.masterCard, PKPaymentNetwork.amex, PKPaymentNetwork.chinaUnionPay,PKPaymentNetwork.discover,PKPaymentNetwork.maestro,PKPaymentNetwork.idCredit ]
//
//        let roundedAmount = NSDecimalNumber(value: ViewManager.shared.TotalTicketPrice.floatValue).rounding(accordingToBehavior: NSDecimalNumberHandler(roundingMode: .plain, scale: 2, raiseOnExactness: false, raiseOnOverflow: false, raiseOnUnderflow: false, raiseOnDivideByZero: false))
//
//        if PKPaymentAuthorizationViewController.canMakePayments() == false {
//            let alert = UIAlertController(title: "Apple Pay is not available", message: nil, preferredStyle: .alert)
//            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
//            return self.present(alert, animated: true, completion: nil)
//        }
//
//        if PKPaymentAuthorizationViewController.canMakePayments(usingNetworks: supportedNetworks) == false {
//            let alert = UIAlertController(title: "No Apple Pay payment methods available", message: nil, preferredStyle: .alert)
//            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
//            return self.present(alert, animated: true, completion: nil)
//        }
//
//        let request = PKPaymentRequest()
//        request.currencyCode = "USD"
//        request.countryCode = "US"
//        request.merchantIdentifier = "merchant.flyguy.beta"
//        request.supportedNetworks = SupportedPaymentNetworks
//        // DO NOT INCLUDE PKMerchantCapability.capabilityEMV
//        request.merchantCapabilities = PKMerchantCapability.capability3DS
//
//        request.paymentSummaryItems = [
//            PKPaymentSummaryItem(label: "Total", amount: roundedAmount)
//        ]
//
//        let applePayController = PKPaymentAuthorizationViewController(paymentRequest: request)
//        applePayController?.delegate = self
//
//        self.present(applePayController!, animated: true, completion: nil)
    
    
//    func showPaymentSuccessView() {
//        if let successPaymentView = Bundle.main.loadNibNamed("SuccessPaymentView", owner: self, options: nil)?.first as? UIView {
//            self.successPaymentView = successPaymentView
//            successPaymentView.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height)
//            successPaymentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//
//            view.addSubview(successPaymentView)
//
//            DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) {
//                self.successPaymentView?.removeFromSuperview()
//                self.successPaymentView = nil
//                self.configureFlightBooking()
//            }
//        }
//    }
    
//    func showPaymentFailView() {
//        if let failurePaymentView = Bundle.main.loadNibNamed("FailurePaymentView", owner: self, options: nil)?.first as? UIView {
//            self.failurePaymentView = failurePaymentView
//            failurePaymentView.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height)
//            failurePaymentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//
//            view.addSubview(failurePaymentView)
//
//            DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) {
//                self.failurePaymentView?.removeFromSuperview()
//                self.failurePaymentView = nil
//                if Constants.deviceType == DeviceType.iPad.rawValue{
//                    self.removeIpad(asChildViewController: self.CheckoutAuthorizeiPad)
//                    self.addIpad(asChildViewController: self.ConfirmDetailsVCiPad)
//                }else{
//                    self.navigationController?.popViewController(animated: true)
//                }
//            }
//        }
//    }
    
//    func configure(dataValue: String){
//        viewModel.proceedToCheckoutView = self
//        if let decodedData = dataValue.removingPercentEncoding,
//           let base64Data = decodedData.data(using: .utf8)?.base64EncodedString() {
//            let model = PaymentApplePayInputDTO(createTransactionRequest: CreateTransactionRequestApplePay(merchantAuthentication: MerchantAuthenticationApplePay(name: "5KP3u95bQpv",transactionKey: "346HZ32z3fP4hTG2"),refID: "123456" ,transactionRequest: TransactionRequestApplePay(transactionType: "authCaptureTransaction",amount: ViewManager.shared.TotalTicketPrice,payment: PaymentApplePay(opaqueData: OpaqueData(dataDescriptor: "COMMON.APPLE.INAPP.PAYMENT",dataValue: base64Data)))))
//            viewModel.getApplePayPaymentApi(Parameters: model) { isSuccess in
//                if isSuccess{
//                    self.showPaymentSuccessView()
//                }else{
//                    self.showPaymentFailView()
//                }
//            }
//        }
//    }
    
//    func processApplePayPayment(payment: PKPayment) {
//        if let paymentToken = payment.token as? PKPaymentToken {
//            let paymentData = paymentToken.paymentData
//            let base64Encoded = paymentData.base64EncodedString()
//
//            let body = """
//            {
//
//              "createTransactionRequest" : {
//
//                "merchantAuthentication" : {
//
//                  "name" : "9uF8mF4MnX",
//
//                  "transactionKey" : "3xv4EnWp7254MKXA"
//
//                },
//
//                "refId" : "123456",
//
//                "transactionRequest" : {
//
//                  "transactionType" : "authCaptureTransaction",
//
//                  "amount" : "520.7751",
//
//                  "payment" : {
//
//                    "opaqueData" : {
//
//                      "dataValue" : "\(base64Encoded)",
//
//                      "dataDescriptor" : "COMMON.APPLE.INAPP.PAYMENT"
//
//                    }
//
//                  }
//
//                }
//
//              }
//
//            }
//            """
////"5KP3u95bQpv"  "transactionKey" : "346HZ32z3fP4hTG2"
//            if let requestURL = URL(string: "https://api.datascalp.com/apiv1/flightbooking/authorizeapplepaypaymentgetwaty") {
//                var request = URLRequest(url: requestURL)
//                request.httpMethod = "POST"
//                request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
//                request.httpBody = body.data(using: .utf8)
//
//                let task = URLSession.shared.dataTask(with: request) { data, response, error in
//                    if let data = data, let responseStr = String(data: data, encoding: .utf8) {
//                        print("Data received: \(responseStr)")
//                    }
//                }
//                task.resume()
//            }
//        }
//    }
    
//    func configureFlightBooking(){
//        viewModel.proceedToCheckoutView = self
//        let model = ViewManager.shared.selectedFlightDetails
//        let allDetailsModel = ViewManager.shared.flightList
//        let loginDetails = ViewManager.shared.loginDetails
//
//        let flightBookingInfo = FlightBookingInformation(flightSessionID: allDetailsModel.sessionID ,fareSourceCode: model.fareItinerary?.airItineraryFareInfo?.fareSourceCode,isPassportMandatory: VIEWMANAGER.isPassportMandatory == true ? "true" : "false", fareType: model.fareItinerary?.airItineraryFareInfo?.fareType, areaCode: "080",countryCode: "91")
//
//        let paxinfo = PaxInfo(clientRef: loginDetails.userID, postCode: "", customerEmail: loginDetails.email, customerPhone: loginDetails.phonenumber ,bookingNote: "", paxDetails :[ViewManager.shared.paxDetail])
//
//        let airlineName = model.fareItinerary?.originDestinationOptions?[0]
//
//        let currencyModel = model.fareItinerary?.airItineraryFareInfo?.itinTotalFares
//        let totFare = currencyModel?.totalFare?.amount
//        let serviceCharge = Constants.serviceCharge
//        let totalticketPrice = (totFare?.floatValue ?? 0.0) + serviceCharge.floatValue
//
//        let bookingDetail = BookingDetails(trip : ViewManager.shared.isReturn ? "Return" : "oneway", from: ViewManager.shared.journeyRoute.0, to: ViewManager.shared.journeyRoute.1, fromtime: ViewManager.shared.journeyDate.2,totime: ViewManager.shared.journeyDate.3, airlineName: airlineName?.originDestinationOption?[0].flightSegment?.marketingAirlineName, bookingprice: "\(totalticketPrice)", totalStop: "\(airlineName?.totalStops ?? 0)",flightNo: airlineName?.originDestinationOption?[0].flightSegment?.flightNumber, ticketID: "")
//
//        let jorneyDateTime = airlineName?.originDestinationOption?[0].flightSegment?.departureDateTime ?? ""
//        let formatter = DateFormatter()
//        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
//        let date = formatter.date(from: jorneyDateTime) ?? Date()
//        formatter.dateFormat = "yyyy-MM-dd"
//        let jorneyDate = formatter.string(from: date)
//        formatter.dateFormat = "HH:mm:ss"
//        let journeytime = formatter.string(from: date)
//
//        let finalModel = FlightBookingInputDTO(flightBookingInfo: flightBookingInfo, paxInfo: paxinfo,bookingDetails: bookingDetail, userID : loginDetails.userID, pnrID : "", cancellationStatus: "", paymentID: "", journeyTime : journeytime, journeyDate : jorneyDate, createdBy: loginDetails.userID,refId: "viewModel.authorizePaymentResponse.result?.refID")
//
//        viewModel.getFlightBookingApi(Parameters: finalModel) { isSuccess in
//            if isSuccess{
//                if Constants.deviceType == DeviceType.iPhone.rawValue{
//                    self.navigateToFlightBookingDetails()
//                }else{
//                    self.removeIpad(asChildViewController: self.ProceedToCheckoutVCiPad)
//                    self.addIpad(asChildViewController: self.FlightBookingDetailVCiPad)
//                }
//            }
//            else{
//             //   self.configureVoidPaymentApi()
//            }
//        }
//    }
    
//    func configureVoidPaymentApi(){
//        viewModel.proceedToCheckoutView = self
//        let model = VoidPaymentAuthorizeInputDTO(createTransactionRequest: CreateTransactionRequests(merchantAuthentication: MerchantAuthentications(name: "", transactionKey: ""),refID: "1234567",transactionRequest: TransactionRequests(
//            transactionType: "voidTransaction",refTransID: viewModel.authorizePaymentResponse.result?.transactionResponse?.transID)))
//        viewModel.getVoidPaymentAuthorizeApi(Parameters: model) { isSuccess in
//            if isSuccess{
//                if Constants.deviceType == DeviceType.iPad.rawValue{
//                    self.removeIpad(asChildViewController: self.PaymentAuthorizeiPad)
//                    self.addIpad(asChildViewController: self.HomeVCiPad)
//                }else{
//                    self.moveToTabBar()
//                }
//            }
//        }
//    }
    
//    func paymentAuthorizationViewController(_ controller: PKPaymentAuthorizationViewController, didAuthorizePayment payment: PKPayment, completion: (@escaping (PKPaymentAuthorizationStatus) -> Void)) {
//        print("paymentAuthorizationViewController delegates called")
//
//        if payment.token.paymentData.count > 0 {
//            let base64str = self.base64forData(payment.token.paymentData)
//            let messsage = String(format: "Data Value: %@", base64str)
//            configure(dataValue: base64str)
//            processApplePayPayment(payment: payment)
//            let alert = UIAlertController(title: "Authorization Success", message: nil, preferredStyle: .alert)
//            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
//            return self.performApplePayCompletion(controller, alert: alert)
//        } else {
//            let alert = UIAlertController(title: "Authorization Failed!", message: nil, preferredStyle: .alert)
//            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
//            return self.performApplePayCompletion(controller, alert: alert)
//        }
//    }
//
//    @objc func performApplePayCompletion(_ controller: PKPaymentAuthorizationViewController, alert: UIAlertController) {
//        controller.dismiss(animated: true, completion: {() -> Void in
//            self.present(alert, animated: false, completion: nil)
//        })
//    }
//
//    @objc func paymentAuthorizationViewControllerDidFinish(_ controller: PKPaymentAuthorizationViewController) {
//        controller.dismiss(animated: true, completion: nil)
//        print("paymentAuthorizationViewControllerDidFinish called")
//    }
//
//    @objc func base64forData(_ theData: Data) -> String {
//        let charSet = CharacterSet.urlQueryAllowed
//
//        let paymentString = NSString(data: theData, encoding: String.Encoding.utf8.rawValue)!.addingPercentEncoding(withAllowedCharacters: charSet)
//
//        return paymentString!
//    }


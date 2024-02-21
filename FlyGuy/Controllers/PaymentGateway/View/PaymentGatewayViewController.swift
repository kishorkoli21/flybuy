//
//  PaymentGatewayViewController.swift
//  FlyGuy
//
//  Created by Springup Labs on 26/06/23.
//

import UIKit
import WebKit
import SafariServices

protocol PaymentProtocol {
    var controller: PaymentGatewayViewController { get }
}

class PaymentGatewayViewController: BaseViewController, UIWebViewDelegate,WKNavigationDelegate  {
    
    @IBOutlet weak var webView: WKWebView!
    
    let viewModel = PaymentViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Configure()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        stopSpinner()
    }
    
    // MARK: WebView methods
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("Web page loaded successfully")
        if let finalURL = webView.url {
            webView.evaluateJavaScript("document.getElementById('Status_id').innerHTML") { (result, error) in
                if let value = result as? String {
                    if value == "Successful"{
                        ViewManager.shared.fromScreen = ""
                        ViewManager.shared.isFromCancel = false
                        
                        webView.evaluateJavaScript("document.querySelector('[ssl_invoice]').getAttribute('ssl_invoice')") { (sslInvoiceValue, error) in
                            if let sslInvoiceValue = sslInvoiceValue as? String {
                                VIEWMANAGER.TransactionDetails.0 = sslInvoiceValue
                                print("ssl_invoice: \(sslInvoiceValue)")
                            } else {
                                print("ssl_invoice not found.")
                            }
                        }
                        
                        webView.evaluateJavaScript("document.querySelector('[ssl_txn_id]').getAttribute('ssl_txn_id')") { (sslTxnIDValue, error) in
                            if let sslTxnIDValue = sslTxnIDValue as? String {
                                VIEWMANAGER.TransactionDetails.1 = sslTxnIDValue
                                print("ssl_txn_id: \(sslTxnIDValue)")
                            } else {
                                print("ssl_txn_id not found.")
                            }
                        }
                        //                        webView.evaluateJavaScript("document.getElementById('ssl_invoice').innerHTML") { (result, error) in
                        //                            if let sslInvoiceID = result as? String {
                        //                                print("ssl_txn_id: \(sslInvoiceID)")
                        //                                VIEWMANAGER.TransactionDetails.0 = sslInvoiceID
                        //                            }
                        //                        }
                        //
                        //                        webView.evaluateJavaScript("document.getElementById('ssl_txn_id').innerHTML") { (result, error) in
                        //                            if let sslTxnID = result as? String {
                        //                                print("ssl_txn_id: \(sslTxnID)")
                        //                                VIEWMANAGER.TransactionDetails.0 = sslTxnID
                        //                            }
                        //                        }
                        
                        self.configureFlightBooking()
                    }else if value == "declined"{
                        if Constants.deviceType == DeviceType.iPad.rawValue{
                            self.removeIpad(asChildViewController: self.PaymentiPad)
                            self.addIpad(asChildViewController: self.ConfirmDetailsVCiPad)
                        }else{
                            self.navigationController?.popViewController(animated: true)
                        }
                    }
                }
            }
            print("Final URL: \(finalURL)")
        }
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
       // print("Web page failed to load with error: \(error.localizedDescription)")
        // Retrieve the final URL if available
        if let finalURL = webView.url {
            print("Final URL: \(finalURL)")
        }
    }
    
    // MARK: Api Integration methods
    
    func Configure(){
        viewModel.view = self
        viewModel.getPaymentSessionIdApi() { isSuccess in
            if isSuccess{
                if let url = URL(string: self.viewModel.paymentResponse.result ?? "") {
                    let request = URLRequest(url: url)
                    self.webView.navigationDelegate = self
                    self.webView.load(request)
                }
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
                    self.removeIpad(asChildViewController: self.PaymentiPad)
                    self.addIpad(asChildViewController: self.FlightBookingDetailVCiPad)
                }
            }else{
                self.configureVoidPaymentApi()
            }
        }
    }
    
    func configureVoidPaymentApi(){
        viewModel.view = self
        let model = VoidPaymentInputDTO(sslMerchantID : "0030843" , sslUserID : "apiuser399131", sslPin : "4BTSZ7G75UYS8YVHC4J0CMNLUFXFHL3RXCA68Z63FKUVYQQKIIMC468YQR8GTKZ3", sslTestMode: "false" ,
                                        sslTransactionType : "ccvoid", sslInvoice : VIEWMANAGER.TransactionDetails.0, sslTxnID: VIEWMANAGER.TransactionDetails.1 )
        viewModel.getVoidPaymentApi(Parameters: model) { isSuccess in
            if isSuccess{
                if Constants.deviceType == DeviceType.iPad.rawValue{
                    self.removeIpad(asChildViewController: self.PaymentiPad)
                    self.addIpad(asChildViewController: self.HomeVCiPad)
                }else{
                    self.moveToTabBar()
                }
            }else{
              
            }
        }
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
    
    @IBAction func btnPaymentClicked(_ sender: Any) {
        if Constants.deviceType == DeviceType.iPad.rawValue{
            removeIpad(asChildViewController: self.PaymentiPad)
            addIpad(asChildViewController: self.ConfirmDetailsVCiPad)
        }else{
            self.navigationController?.popViewController(animated: true)
        }
    }
    
}

extension PaymentGatewayViewController: PaymentProtocol {
    var controller: PaymentGatewayViewController {
        self
    }
}

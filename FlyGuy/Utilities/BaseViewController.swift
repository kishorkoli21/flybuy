//
//  BaseViewController.swift
//  FlyGuy
//
//  Created by Mac on 15/03/23.
//

import UIKit

class BaseViewController: UIViewController {

    var onSelect : (()->())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.interactivePopGestureRecognizer?.delegate = nil
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        
        /*
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGestureForNavigation))
        swipeRight.direction = .right
        self.view.addGestureRecognizer(swipeRight)
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGestureForNavigation))
        swipeLeft.direction = .left
        self.view.addGestureRecognizer(swipeLeft)
        */
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let dict = Preferences.getLoginResponse(){
            let email =  dict["email"] as? String
            let token =  dict["token"] as? String
            ViewManager.shared.loginDetails.firstname = dict["firstname"] as? String
            ViewManager.shared.loginDetails.lastname = dict["lastname"] as? String
            ViewManager.shared.loginDetails.phonenumber = dict["number"] as? String
            ViewManager.shared.loginDetails.email = dict["email"] as? String
            ViewManager.shared.loginDetails.token = dict["token"] as? String
            ViewManager.shared.loginDetails.userID = dict["userId"] as? String
            ViewManager.shared.loginDetails.birthdate = dict["birthdate"] as? String
            if email != "" || email != nil && token != "" || token != nil{
                ViewManager.shared.isLogin = true
            }
            else{
                ViewManager.shared.isLogin = false
            }
        }
        if let dict = Preferences.getSignUpResponse(){
            let email =  dict["email"] as? String
            ViewManager.shared.loginDetails.email = email
            ViewManager.shared.loginDetails.firstname = dict["firstname"] as? String
            ViewManager.shared.loginDetails.lastname = dict["lastname"] as? String
            ViewManager.shared.loginDetails.phonenumber = dict["number"] as? String
            ViewManager.shared.loginDetails.birthdate = dict["birthdate"] as? String
        }
        print(ViewManager.shared.loginDetails.userID)
        print(ViewManager.shared.loginDetails.token)
        print(ViewManager.shared.loginDetails.firstname)
    }
        
//    firstname": self.signUpStruct.firstname ?? "",
//                               "lastname": self.signUpStruct.lastname ?? "",
//                               "email": self.signUpStruct.email ?? "",
//                               "password": self.signUpStruct.password ?? "",
//                               "number":
    
    func popBack<T: UIViewController>(toControllerType: T.Type) {
        if var viewControllers: [UIViewController] = self.navigationController?.viewControllers {
            viewControllers = viewControllers.reversed()
            for currentViewController in viewControllers {
                if currentViewController .isKind(of: toControllerType) {
                    self.navigationController?.popToViewController(currentViewController, animated: true)
                    break
                }
            }
        }
    }
    
    func statusBarBackgroundColor(colorHex : String){
        if #available(iOS 13, *) {
//            let statusBar = UIView(frame: (UIApplication.shared.keyWindow?.windowScene?.statusBarManager?.statusBarFrame)!)
//            statusBar.backgroundColor = UIColor().hexStringToUIColor(hex: colorHex)
//            UIApplication.shared.keyWindow?.addSubview(statusBar)
            if let statusBarFrame = UIApplication.shared.windows.first?.windowScene?.statusBarManager?.statusBarFrame {
                let statusBar = UIView(frame: statusBarFrame)
                statusBar.backgroundColor = UIColor().hexStringToUIColor(hex: colorHex)
                
                if let keyWindow = UIApplication.shared.windows.first {
                    keyWindow.addSubview(statusBar)
                }
            }
        }
    }
    
//    {
//        var topViewController: UIViewController?
//        if let scene = UIApplication.shared.connectedScenes.first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene {
//            if let window = scene.windows.first(where: { $0.isKeyWindow }) {
//                topViewController = window.rootViewController
//                while true {
//                    if let presentedViewController = topViewController?.presentedViewController {
//                        topViewController = presentedViewController
//                    } else if let navigationController = topViewController as? UINavigationController {
//                        topViewController = navigationController.topViewController
//                    } else if let tabBarController = topViewController as? UITabBarController {
//                        topViewController = tabBarController.selectedViewController
//                    } else {
//                        break
//                    }
//                }
//            }
//        }
//        return topViewController!
//    }
    
    func getIPAddress() -> String? {
        var address : String?

        // Get list of all interfaces on the local machine:
        var ifaddr : UnsafeMutablePointer<ifaddrs>?
        guard getifaddrs(&ifaddr) == 0 else { return nil }
        guard let firstAddr = ifaddr else { return nil }

        // For each interface ...
        for ifptr in sequence(first: firstAddr, next: { $0.pointee.ifa_next }) {
            let interface = ifptr.pointee

            // Check for IPv4 or IPv6 interface:
            let addrFamily = interface.ifa_addr.pointee.sa_family
            if addrFamily == UInt8(AF_INET) || addrFamily == UInt8(AF_INET6) {

                // Check interface name:
                // wifi = ["en0"]
                // wired = ["en2", "en3", "en4"]
                // cellular = ["pdp_ip0","pdp_ip1","pdp_ip2","pdp_ip3"]
                
                let name = String(cString: interface.ifa_name)
                if  name == "en0" || name == "en2" || name == "en3" || name == "en4" || name == "pdp_ip0" || name == "pdp_ip1" || name == "pdp_ip2" || name == "pdp_ip3" {

                    // Convert interface address to a human readable string:
                    var hostname = [CChar](repeating: 0, count: Int(NI_MAXHOST))
                    getnameinfo(interface.ifa_addr, socklen_t(interface.ifa_addr.pointee.sa_len),
                                &hostname, socklen_t(hostname.count),
                                nil, socklen_t(0), NI_NUMERICHOST)
                    address = String(cString: hostname)
                }
            }
        }
        freeifaddrs(ifaddr)

        return address
    }
    
    func showAlert(msg: String){
        let alert = UIAlertController(title: "", message: msg, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: { action in

        })
        alert.addAction(ok)
        DispatchQueue.main.async(execute: {
            self.present(alert, animated: true)
        })
    }
    
    func showActionSheet(_ actionSheetData:NSArray,isIpad: Bool = false, actionSheetImages:NSArray = [],completion:@escaping (String) -> Void)
    {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        //        alert.view.subviews.first?.subviews.first?.subviews.first?.backgroundColor = UIColor.white
        //        alert.view.tintColor = UIColor.blue
        
        for i in 0..<actionSheetData.count  {
            let title = actionSheetData[i] as? String
            let alertAction = UIAlertAction(title: title , style: .default, handler: { (action) in
                completion(action.title!)
                
                if self.onSelect != nil{
                    self.onSelect!()
                }
            })
            if actionSheetImages.count == actionSheetData.count {
                let image = UIImage(named: actionSheetImages[i] as! String)
                alertAction.setValue(image?.withRenderingMode(.alwaysOriginal), forKey: "image")
            }
            alert.addAction(alertAction)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { action in
            completion(action.title!)
            
            if self.onSelect != nil{
                self.onSelect!()
            }
        }
        alert.addAction(cancelAction)
        if isIpad{
            alert.popoverPresentationController?.sourceView = view
            alert.popoverPresentationController?.sourceRect = CGRect(x: view.bounds.midX, y: view.bounds.midY, width: 0, height: 0)
            alert.popoverPresentationController?.permittedArrowDirections = []
        }
        self.present(alert, animated: true, completion: nil)
        
    }
    
    func onSelectClicked(closure : @escaping () -> Void){
        onSelect = closure
    }
    
    func addIpad(asChildViewController viewController: UIViewController) {
        // Add Child View Controller
        addChild(viewController)
        // Add Child View as Subview
        self.view.addSubview(viewController.view)
        viewController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            viewController.view.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            viewController.view.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            viewController.view.topAnchor.constraint(equalTo: self.view.topAnchor),
            viewController.view.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
        viewController.view.frame = view.bounds
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        viewController.didMove(toParent: self)
    }
    
    func removeIpad(asChildViewController viewController: UIViewController) {
        viewController.willMove(toParent: nil)
        viewController.view.removeFromSuperview()
        viewController.removeFromParent()
    }
    
    lazy var BookVCiPad: BookingDetailsViewController = {
        let storyBoard : UIStoryboard = UIStoryboard(name: Storyboards.BookingDetailIpadStoryboard, bundle:nil)
        var viewController = storyBoard.instantiateViewController(withIdentifier: ViewControllers.BookingDetailViewController) as! BookingDetailsViewController
        addIpad(asChildViewController: viewController)
        return viewController
    }()
    
    lazy var HomeVCiPad: HomeViewController = {
        let storyBoard : UIStoryboard = UIStoryboard(name: Storyboards.HomeiPadStoryboard, bundle:nil)
        var viewController = storyBoard.instantiateViewController(withIdentifier: ViewControllers.HomeViewController) as! HomeViewController
        addIpad(asChildViewController: viewController)
        return viewController
    }()
    
    lazy var FlightListVCiPad: FlightListViewController = {
        let storyBoard : UIStoryboard = UIStoryboard(name: Storyboards.FlightListIpadStoryboard, bundle:nil)
        var viewController = storyBoard.instantiateViewController(withIdentifier: ViewControllers.FlightListViewController) as! FlightListViewController
        addIpad(asChildViewController: viewController)
        return viewController
    }()
    
    lazy var FlightListInboundVCiPad: FlightListInboundViewController = {
        let storyBoard : UIStoryboard = UIStoryboard(name: Storyboards.FlightListIpadStoryboard, bundle:nil)
        var viewController = storyBoard.instantiateViewController(withIdentifier: ViewControllers.FlightListInboundViewController) as! FlightListInboundViewController
        addIpad(asChildViewController: viewController)
        return viewController
    }()
    
    
    lazy var FlightDetailsVCiPad: FlightDetailsViewController = {
        let storyBoard : UIStoryboard = UIStoryboard(name: Storyboards.FlightListIpadStoryboard, bundle:nil)
        var viewController = storyBoard.instantiateViewController(withIdentifier: ViewControllers.FlightDetailsViewController) as! FlightDetailsViewController
        addIpad(asChildViewController: viewController)
        return viewController
    }()
    
    lazy var TravelDetailsVCiPad: TravelDetailsViewController = {
    let storyBoard : UIStoryboard = UIStoryboard(name: Storyboards.TravelIpadStoryboard, bundle:nil)
    var viewController = storyBoard.instantiateViewController(withIdentifier: ViewControllers.TravelDetailsViewController) as! TravelDetailsViewController
    addIpad(asChildViewController: viewController)
    return viewController
    }()
    
    
    
    lazy var ConfirmDetailsVCiPad: ConfirmDetailsViewController = {
    let storyBoard : UIStoryboard = UIStoryboard(name: Storyboards.ConfirmDetailsIpadStoryboard, bundle:nil)
    var viewController = storyBoard.instantiateViewController(withIdentifier: ViewControllers.ConfirmDetailsViewController) as! ConfirmDetailsViewController
    addIpad(asChildViewController: viewController)
    return viewController
    }()
    
    lazy var FlightBookingDetailVCiPad: FlightBookingDetailsViewController = {
    let storyBoard : UIStoryboard = UIStoryboard(name: Storyboards.FlightBookingDetailIpadStoryboard, bundle:nil)
    var viewController = storyBoard.instantiateViewController(withIdentifier: ViewControllers.FlightBookingDetailsViewController) as! FlightBookingDetailsViewController
    addIpad(asChildViewController: viewController)
    return viewController
    }()
    
    lazy var MyTripsiPad: MyTripViewController = {
        let storyBoard : UIStoryboard = UIStoryboard(name: Storyboards.MyTripipadStoryboard, bundle:nil)
        let viewController = storyBoard.instantiateViewController(withIdentifier: ViewControllers.MyTripViewController) as! MyTripViewController
        addIpad(asChildViewController: viewController)
        return viewController
    }()
    
    lazy var ProfileiPad: ProfileViewController = {
      //  ViewManager.shared.isCreateAccountFromTabBar = false
        let storyBoard : UIStoryboard = UIStoryboard(name: Storyboards.CreateAccountIpadStoryboard, bundle:nil)
        let viewController = storyBoard.instantiateViewController(withIdentifier: ViewControllers.ProfileViewController) as! ProfileViewController
        addIpad(asChildViewController: viewController)
        return viewController
    }()
    
    lazy var LoginiPad: LoginViewController = {
        let storyBoard : UIStoryboard = UIStoryboard(name: Storyboards.CreateAccountIpadStoryboard, bundle:nil)
        let viewController = storyBoard.instantiateViewController(withIdentifier: ViewControllers.LoginViewController) as! LoginViewController
        addIpad(asChildViewController: viewController)
        return viewController
    }()
    
    lazy var ForgotPasswordiPad: ForgotPasswordViewController = {
        let storyBoard : UIStoryboard = UIStoryboard(name: Storyboards.CreateAccountIpadStoryboard, bundle:nil)
        let viewController = storyBoard.instantiateViewController(withIdentifier: ViewControllers.ForgotPasswordViewController) as! ForgotPasswordViewController
        addIpad(asChildViewController: viewController)
        return viewController
    }()
    
    lazy var ResetPasswordiPad: ResetPasswordViewController = {
        let storyBoard : UIStoryboard = UIStoryboard(name: Storyboards.CreateAccountIpadStoryboard, bundle:nil)
        let viewController = storyBoard.instantiateViewController(withIdentifier: ViewControllers.ResetPasswordViewController) as! ResetPasswordViewController
        addIpad(asChildViewController: viewController)
        return viewController
    }()
    
    lazy var VerificationiPad: VerificationViewController = {
        let storyBoard : UIStoryboard = UIStoryboard(name: Storyboards.CreateAccountIpadStoryboard, bundle:nil)
        let viewController = storyBoard.instantiateViewController(withIdentifier: ViewControllers.VerificationViewController) as! VerificationViewController
        addIpad(asChildViewController: viewController)
        return viewController
    }()
    
    lazy var SuccessiPad: SuccessViewController = {
        let storyBoard : UIStoryboard = UIStoryboard(name: Storyboards.CreateAccountIpadStoryboard, bundle:nil)
        let viewController = storyBoard.instantiateViewController(withIdentifier: ViewControllers.SuccessViewController) as! SuccessViewController
        addIpad(asChildViewController: viewController)
        return viewController
    }()
   
    lazy var UpcomingFlightsiPad: UpcomingFlightsViewController = {
        let storyBoard : UIStoryboard = UIStoryboard(name: Storyboards.UpcomingFlightsIpadStoryboard, bundle:nil)
        let viewController = storyBoard.instantiateViewController(withIdentifier: ViewControllers.UpcomingFlightsViewController) as! UpcomingFlightsViewController
        addIpad(asChildViewController: viewController)
        return viewController
    }()
    
    lazy var CompletedFlightsiPad: CompletedFlightsViewController = {
        let storyBoard : UIStoryboard = UIStoryboard(name: Storyboards.UpcomingFlightsIpadStoryboard, bundle:nil)
        let viewController = storyBoard.instantiateViewController(withIdentifier: ViewControllers.CompletedFlightsViewController) as! CompletedFlightsViewController
        addIpad(asChildViewController: viewController)
        return viewController
    }()
    
    lazy var CancelledFlightsiPad: CancelledFlightViewController = {
        let storyBoard : UIStoryboard = UIStoryboard(name: Storyboards.UpcomingFlightsIpadStoryboard, bundle:nil)
        let viewController = storyBoard.instantiateViewController(withIdentifier: ViewControllers.CancelledFlightViewController) as! CancelledFlightViewController
        addIpad(asChildViewController: viewController)
        return viewController
    }()
    
    lazy var CancelFlightiPad: CancelViewController = {
        let storyBoard : UIStoryboard = UIStoryboard(name: Storyboards.UpcomingFlightsIpadStoryboard, bundle:nil)
        let viewController = storyBoard.instantiateViewController(withIdentifier: ViewControllers.CancelViewController) as! CancelViewController
        addIpad(asChildViewController: viewController)
        return viewController
    }()
    
    lazy var SingleFlightDetailiPad: SingleFlightDetailViewController = {
        let storyBoard : UIStoryboard = UIStoryboard(name: Storyboards.SingleFlightDetailIpadStoryboard, bundle:nil)
        let viewController = storyBoard.instantiateViewController(withIdentifier: ViewControllers.SingleFlightDetailViewController) as! SingleFlightDetailViewController
        addIpad(asChildViewController: viewController)
        return viewController
    }()
    
    lazy var FlightCanceliPad: FlightCancellationViewController = {
       let storyBoard : UIStoryboard = UIStoryboard(name: Storyboards.FlightCancellationiPadStoryboard, bundle:nil)
       let viewController = storyBoard.instantiateViewController(withIdentifier: ViewControllers.FlightCancellationViewController) as! FlightCancellationViewController
       addIpad(asChildViewController: viewController)
       return viewController
   }()
   
    lazy var FlightDelayiPad: FlightDelayViewController = {
       let storyBoard : UIStoryboard = UIStoryboard(name: Storyboards.FlightDelayiPadStoryboard, bundle:nil)
       let viewController = storyBoard.instantiateViewController(withIdentifier: ViewControllers.FlightDelayViewController) as! FlightDelayViewController
       addIpad(asChildViewController: viewController)
       return viewController
   }()
   
    lazy var LostLuggageiPad: LostBaggageViewController = {
       let storyBoard : UIStoryboard = UIStoryboard(name: Storyboards.LostBaggageiPadStoryboard, bundle:nil)
       let viewController = storyBoard.instantiateViewController(withIdentifier: ViewControllers.LostBaggageViewController) as! LostBaggageViewController
       addIpad(asChildViewController: viewController)
       return viewController
   }()
   
   lazy var ThankyouiPad: ThankYouViewController = {
       let storyBoard : UIStoryboard = UIStoryboard(name: Storyboards.ThankYouiPadStoryboard, bundle:nil)
       let viewController = storyBoard.instantiateViewController(withIdentifier: ViewControllers.ThankYouViewController) as! ThankYouViewController
       viewController.hidesBottomBarWhenPushed = true
       addIpad(asChildViewController: viewController)
       return viewController
   }()
   
   lazy var PaymentiPad: PaymentGatewayViewController = {
   let storyID = UIStoryboard(name: Storyboards.PaymentGatewayStoryboard, bundle:nil)
   let viewController = storyID.instantiateViewController(withIdentifier: ViewControllers.PaymentGatewayViewController) as! PaymentGatewayViewController
       addIpad(asChildViewController: viewController)
       return viewController
   }()
    
    lazy var PersonalInfoiPad: PersonalInfoViewController = {
    let storyID = UIStoryboard(name: Storyboards.CreateAccountIpadStoryboard, bundle:nil)
    let viewController = storyID.instantiateViewController(withIdentifier: ViewControllers.PersonalInfoViewController) as! PersonalInfoViewController
        addIpad(asChildViewController: viewController)
        return viewController
    }()
    
    lazy var ChangePasswordiPad: ChangePasswordViewController = {
    let storyID = UIStoryboard(name: Storyboards.CreateAccountIpadStoryboard, bundle:nil)
    let viewController = storyID.instantiateViewController(withIdentifier: ViewControllers.ChangePasswordViewController) as! ChangePasswordViewController
        addIpad(asChildViewController: viewController)
        return viewController
    }()
    
    lazy var CheckoutAuthorizeiPad: ProceedToCheckoutVC  = {
    let storyID = UIStoryboard(name: Storyboards.PaymentGatewayIpadStoryboard, bundle:nil)
    let viewController = storyID.instantiateViewController(withIdentifier: ViewControllers.ProceedToCheckoutVC) as! ProceedToCheckoutVC
        addIpad(asChildViewController: viewController)
        return viewController
    }()
    
    lazy var AddAddressAuthorizeiPad: AddAddressViewController  = {
    let storyID = UIStoryboard(name: Storyboards.PaymentGatewayIpadStoryboard, bundle:nil)
    let viewController = storyID.instantiateViewController(withIdentifier: ViewControllers.AddAddressViewController) as! AddAddressViewController
        addIpad(asChildViewController: viewController)
        return viewController
    }()
    
    lazy var PaymentAuthorizeiPad: PaymentViewController  = {
    let storyID = UIStoryboard(name: Storyboards.PaymentGatewayIpadStoryboard, bundle:nil)
    let viewController = storyID.instantiateViewController(withIdentifier: ViewControllers.PaymentViewController) as! PaymentViewController
        addIpad(asChildViewController: viewController)
        return viewController
    }()
    
    lazy var ProceedToCheckoutVCiPad: ProceedToCheckoutVC  = {
    let storyID = UIStoryboard(name: Storyboards.PaymentGatewayIpadStoryboard, bundle:nil)
    let viewController = storyID.instantiateViewController(withIdentifier: ViewControllers.ProceedToCheckoutVC) as! ProceedToCheckoutVC
        addIpad(asChildViewController: viewController)
        return viewController
    }()
    
    func moveToMainContaineripadVCBase(){
        let storyBoard : UIStoryboard = UIStoryboard(name: Storyboards.MainiPadContanerStoryboard, bundle:nil)
        let MainContaineriPadVC = storyBoard.instantiateViewController(withIdentifier: ViewControllers.MainiPadContainerViewController) as! MainiPadContainerViewController
        MainContaineriPadVC.isFromipadOnboarding = true
        MainContaineriPadVC.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(MainContaineriPadVC, animated: true)
    }
   
}
    /*
extension BaseViewController {
    @objc func respondToSwipeGestureForNavigation(gesture: UIGestureRecognizer) {
        
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            
            switch swipeGesture.direction {
            case .right:
                selectPreviousTab()
            case .left:
                selectNextTab()
            default:
                break
            }
        }
    }
    //MARK: Ipad Side Menu and Navigation Methods
    
    func selectNextTab() {
        let selectedTabIndex = self.tabBarController?.selectedIndex ?? 0
        if selectedTabIndex != self.tabBarController?.viewControllers?.count {
            self.tabBarController?.selectedIndex = selectedTabIndex + 1
        }
    }
    func selectPreviousTab() {
      
        let selectedTabIndex = self.tabBarController?.selectedIndex ?? 0
        if selectedTabIndex != 0 {
            self.tabBarController?.selectedIndex = selectedTabIndex - 1
        }
    }
}
*/
extension BaseViewController:  URLSessionDownloadDelegate, URLSessionDelegate {
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        print("downloadLocation:", location)
        // create destination URL with the original pdf name
        guard let url = downloadTask.originalRequest?.url else { return }
        let documentsPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let destinationURL = documentsPath.appendingPathComponent(url.lastPathComponent)
        // delete original copy
        try? FileManager.default.removeItem(at: destinationURL)
        // copy from temp to Document
        do {
            try FileManager.default.copyItem(at: location, to: destinationURL)
            do {
                //Show UIActivityViewController to save the downloaded file
                let contents  = try FileManager.default.contentsOfDirectory(at: documentsPath, includingPropertiesForKeys: nil, options: .skipsHiddenFiles)
                for indexx in 0..<contents.count {
                    if contents[indexx].lastPathComponent == destinationURL.lastPathComponent {
                        DispatchQueue.main.async {
                            let activityViewController = UIActivityViewController(activityItems: [contents[indexx]], applicationActivities: nil)
                            self.present(activityViewController, animated: true, completion: nil)
                        }
                    }
                }
            }
            catch (let err) {
                print("error: \(err)")
            }
            // self.pdfURL = destinationURL
        } catch let error {
            print("Copy Error: \(error.localizedDescription)")
        }
    }
}

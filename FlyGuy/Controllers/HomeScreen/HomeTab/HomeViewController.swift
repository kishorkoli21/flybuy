//
//  HomeViewController.swift
//  FlyGuy
//
//  Created by Mac on 15/03/23.
//

import UIKit
import EventKit
import Intents
import IntentsUI

struct CalenderEventStruct {
    var eventTitle, eventDescription: String?
    init(eventTitle: String, eventDescription: String) {
        self.eventTitle   = eventTitle
        self.eventDescription = eventDescription
    }
}

struct SelectedCalenderEventStruct {
    var issueTitle, flightNumber, lateness: String?
    init(issueTitle: String, flightNumber: String, lateness:String) {
        self.issueTitle = issueTitle
        self.flightNumber = flightNumber
        self.lateness = lateness
    }
}

let sharedUserDefaults = UserDefaults(suiteName: SharedUserDefaults.suitName)

class HomeViewController: BaseViewController {
    @IBOutlet weak var logoImgView: UIImageView!
    @IBOutlet weak var elevateYourVoiceLabel: UILabel!
    @IBOutlet weak var homeTableView: UITableView!
    @IBOutlet weak var sideMenuHomeContainerView: UIView!
    @IBOutlet weak var bookInFlightButton: UIButton!
    @IBOutlet weak var bookWithSiriButton: UIButton!
    
    //var reportImageArray = [#imageLiteral(resourceName: "Report-cancel-flight"), #imageLiteral(resourceName: "Report-damaged-bags") , #imageLiteral(resourceName: "Report-flight-delay")]
    var reportImageArray = [#imageLiteral(resourceName: "Report_Flight_Cancellation"), #imageLiteral(resourceName: "Report_Flight_Delay") , #imageLiteral(resourceName: "Report_Luggage_Incident")]
    let eventStore = EKEventStore()
    let dates = Date()
    var allEventArray : [CalenderEventStruct] = []
    var selectedCalenderEventArray : [SelectedCalenderEventStruct] = []
    var flightCancelledKeywordsArray : [String] = ["Flight Cancelled","Cancelled", "Flight Canceled","Canceled"]
    var flightDelayKeywordsArray : [String] = ["Delay","Delayed","Lateness","Flight Delayed","Flight Delay"]
    var lostBaggageKeywordsArray : [String] = ["lost luggage","luggage","baggage","lost baggage"]
    var bookingData : BookingDataStruct = BookingDataStruct(departure: "", destination: "", date: "", time: "", trip: "", returnDate: "", returnTime: "", preferredClass: "", isFromSiri: false)
    var isCreatingShortcut = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(appWillEnterForeground), name: UIApplication.willEnterForegroundNotification, object: nil)
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture))
        swipeRight.direction = .right
        self.view.addGestureRecognizer(swipeRight)
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture))
        swipeLeft.direction = .left
        self.view.addGestureRecognizer(swipeLeft)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if Constants.deviceType == DeviceType.iPhone.rawValue{
            setUpInitialView()
        }else{
            setUpIpadTabelViewCell()
        }
        
        statusBarBackgroundColor(colorHex: AppColor.whiteColor)
        
        let indexPath = IndexPath(row: 0, section: 0)
        homeTableView.scrollToRow(at: indexPath, at: .top, animated: false)
        
        setSiriData()
        
        VIEWMANAGER.isTravellerAdded = false
        VIEWMANAGER.travellerNumber.0 = ""
        VIEWMANAGER.travellerNumber.1 = ""
        VIEWMANAGER.travellerNumber.2 = ""
        
    }
    
    // MARK: Siri Data Setup Methods
    
    func setSiriData(){
        //   Check and navigate to boing details vc
        guard let from = sharedUserDefaults?.string(forKey: SharedUserDefaults.Keys.from) else {return}
        if from == "siri" {
            sharedUserDefaults?.set("", forKey: SharedUserDefaults.Keys.from)
            guard let startJourney = sharedUserDefaults?.string(forKey: SharedUserDefaults.Keys.startJourney) else {return}
            guard let date = sharedUserDefaults?.string(forKey: SharedUserDefaults.Keys.date) else {return}
            guard let time = sharedUserDefaults?.string(forKey: SharedUserDefaults.Keys.time) else {return}
            guard let destination = sharedUserDefaults?.string(forKey: SharedUserDefaults.Keys.destination) else {return}
            guard let classPreferred = sharedUserDefaults?.string(forKey: SharedUserDefaults.Keys.preferredClass) else {return}
            guard let trip = sharedUserDefaults?.string(forKey: SharedUserDefaults.Keys.trip) else {return}
            
            if trip == "Return Trip"{
                guard let returnDate = sharedUserDefaults?.string(forKey: SharedUserDefaults.Keys.returnDate) else {return}
                guard let returnTime = sharedUserDefaults?.string(forKey: SharedUserDefaults.Keys.returnTime) else {return}
                bookingData = BookingDataStruct(departure: startJourney, destination: destination, date: date, time: time, trip: trip, returnDate: returnDate, returnTime: returnTime, preferredClass: classPreferred, isFromSiri: true)
            }else{
                bookingData = BookingDataStruct(departure: startJourney, destination: destination, date: date, time: time, trip: trip, returnDate: "", returnTime: "", preferredClass: classPreferred, isFromSiri: true)
            }
            
            if Constants.deviceType == DeviceType.iPad.rawValue{
                removeIpad(asChildViewController: HomeVCiPad)
                addIpad(asChildViewController: BookVCiPadHome)
            }else{
                let storyID = UIStoryboard(name: Storyboards.BookingDetailStoryboard, bundle:nil)
                let vc = storyID.instantiateViewController(withIdentifier: ViewControllers.BookingDetailViewController) as! BookingDetailsViewController
                vc.bookData = bookingData
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }

    //Perform actions when the app will enter the foreground
    
    @objc func appWillEnterForeground() {
        print("App will enter foreground")
        setSiriData()
    }
    
    deinit {
          NotificationCenter.default.removeObserver(self)
      }
    
    //MARK: Siri Shortcut Setup Methods
    
    func createSiriShortcut() {
        guard !isCreatingShortcut else {
            return
        }
        let intent = FlightBookingIntent()
        intent.suggestedInvocationPhrase = "Book My Flight"
        isCreatingShortcut = true
        guard let shortcut = INShortcut(intent: intent) else {
            // Handle the case where creating the shortcut failed
            print("Failed to create Siri shortcut")
            isCreatingShortcut = false
            return
        }
        
        let viewController = INUIAddVoiceShortcutViewController(shortcut: shortcut)
        viewController.delegate = self
        present(viewController, animated: true) {
            self.isCreatingShortcut = false
        }
    }
    
    //MARK: Initial View Setup Methods
    
    
    func setUpInitialView(){
        UserDefaults.standard.set(true, forKey: Constants.isShowOnBoardScreen)
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        elevateYourVoiceLabel.text = Messages.elevateYourVoiceTitle
        self.homeTableView.register(UINib.init(nibName: Cells.HomeTableViewCell, bundle: nil), forCellReuseIdentifier: Cells.HomeTableViewCell)
        
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture))
        swipeDown.direction = .down
        self.view.addGestureRecognizer(swipeDown)
        
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipeGesture))
        swipeUp.direction = .up
        self.view.addGestureRecognizer(swipeUp)
    
        
        if Constants.isFromNotification == true{
            if Constants.deviceType == DeviceType.iPhone.rawValue{
                switch Constants.notificationIssueNameValue{
                case IncidentTypeEnumForNotification.CancelledFlight.rawValue:
                    navigateToFlightCancellation()
                case IncidentTypeEnumForNotification.DelayFlight.rawValue:
                    navigateToFlightDelay()
                case IncidentTypeEnumForNotification.LostBaggage.rawValue:
                    navigateToLostBaggage()
                default:
                    print("nothing")
                }
            }else{
                switch Constants.notificationIssueNameValue{
                case IncidentTypeEnumForNotification.CancelledFlight.rawValue:
                    navigateToFlightCancellationiPad()
                case IncidentTypeEnumForNotification.DelayFlight.rawValue:
                    navigateToFlightDelayiPad()
                case IncidentTypeEnumForNotification.LostBaggage.rawValue:
                    navigateToLostBaggageiPad()
                default:
                    print("nothing")
                }
            }
        }
        
    }
    
    func setUpIpadTabelViewCell(){
        UserDefaults.standard.set(true, forKey: Constants.isShowOnBoardScreeniPad)
        self.homeTableView.register(UINib.init(nibName: Cells.HomeiPadTableViewCell, bundle: nil), forCellReuseIdentifier: Cells.HomeiPadTableViewCell)
    }
    
    @objc func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            
            switch swipeGesture.direction {
            case .right:
                openSideMenu()
            case .left:
                closeSideMenu()
            default:
                break
            }
        }
    }
    
    func closeSideMenu(){
        let transition = CATransition()
        transition.duration = 0
        transition.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        transition.type = .push
        transition.subtype = .fromRight
        self.view.window!.layer.add(transition, forKey: nil)
        self.dismiss(animated: false, completion: nil)
    }
    
    func openSideMenu(){
        let storyBoard = UIStoryboard(name: Storyboards.HomeStoryboard, bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: ViewControllers.SideMenuViewController) as! SideMenuViewController
        vc.helpCallBack = { (result: Bool) in
            self.navigateToOnboarding()
        }
        vc.aboutUsCallBack = { (result: Bool) in
            DispatchQueue.main.asyncAfter(deadline: .now()) { [self] in
                navigateToAboutUs()
            }}
        vc.contactUsCallBack = { (result: Bool) in
            DispatchQueue.main.asyncAfter(deadline: .now()) { [self] in
                navigateToContactUs()
            }}
        vc.modalPresentationStyle = .overFullScreen
        let transition = CATransition()
        transition.duration = 0
        transition.type = .push
        transition.subtype = .fromLeft
        transition.timingFunction = CAMediaTimingFunction(name: .easeIn)
        self.view.window!.layer.add(transition, forKey: nil)
        UserDefaults.standard.setValue(true, forKey: "isSlideMenuOpened")
        UserDefaults.standard.synchronize()
        self.present(vc, animated:false)
    }
    
    func navigateToOnboarding(){
        let storyID = UIStoryboard(name: Storyboards.OnboardingStoryboard, bundle:nil)
        let vc = storyID.instantiateViewController(withIdentifier: ViewControllers.OnboardingViewController) as! OnboardingViewController
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func navigateToAboutUs(){
        let storyID = UIStoryboard(name: Storyboards.AboutUsStoryboard, bundle:nil)
        let vc = storyID.instantiateViewController(withIdentifier: ViewControllers.AboutUsViewController) as! AboutUsViewController
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func navigateToContactUs(){
        let storyID = UIStoryboard(name: Storyboards.ContactUsStoryboard, bundle:nil)
        let vc = storyID.instantiateViewController(withIdentifier: ViewControllers.ContactUsViewController) as! ContactUsViewController
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    func navigateToBookingDetail(){
        VIEWMANAGER.isShowBookingDetailsForIpad = false
        if Constants.deviceType == DeviceType.iPhone.rawValue{
            let storyID = UIStoryboard(name: Storyboards.BookingDetailStoryboard, bundle:nil)
            let vc = storyID.instantiateViewController(withIdentifier: ViewControllers.BookingDetailViewController) as! BookingDetailsViewController
            self.navigationController?.pushViewController(vc, animated: true)
        }else{
            removeIpad(asChildViewController: HomeVCiPad)
            addIpad(asChildViewController: BookVCiPadHome)
        }
    }
    
    lazy var BookVCiPadHome: BookingDetailsViewController = {
        let storyBoard : UIStoryboard = UIStoryboard(name: Storyboards.BookingDetailIpadStoryboard, bundle:nil)
        var viewController = storyBoard.instantiateViewController(withIdentifier: ViewControllers.BookingDetailViewController) as! BookingDetailsViewController
        if bookingData.isFromSiri {
            viewController.bookData = bookingData
        }
        addIpad(asChildViewController: viewController)
        return viewController
    }()
    
    
    func navigateToFlightCancellation(){
        if Constants.deviceType == DeviceType.iPhone.rawValue{
            let storyID = UIStoryboard(name: Storyboards.FlightCancellationStoryboard, bundle:nil)
            let vc = storyID.instantiateViewController(withIdentifier: ViewControllers.FlightCancellationViewController) as! FlightCancellationViewController
            navigationController?.pushViewController(vc, animated: true)
        }else{
            VIEWMANAGER.isBackInIpadCancel = true
            removeIpad(asChildViewController: HomeVCiPad)
            addIpad(asChildViewController: FlightCanceliPad)
        }
    }
    
    func navigateToFlightDelay(){
        if Constants.deviceType == DeviceType.iPhone.rawValue{
            let storyID = UIStoryboard(name: Storyboards.FlightDelayStoryboard, bundle:nil)
            let vc = storyID.instantiateViewController(withIdentifier: ViewControllers.FlightDelayViewController) as! FlightDelayViewController
            navigationController?.pushViewController(vc, animated: true)
        }else{
            VIEWMANAGER.isBackInIpadDelay = true
            removeIpad(asChildViewController: HomeVCiPad)
            addIpad(asChildViewController: FlightDelayiPad)
        }
    }
    
    func navigateToLostBaggage(){
        if Constants.deviceType == DeviceType.iPhone.rawValue{
            let storyID = UIStoryboard(name: Storyboards.LostBaggageStoryboard, bundle:nil)
            let vc = storyID.instantiateViewController(withIdentifier: ViewControllers.LostBaggageViewController) as! LostBaggageViewController
            navigationController?.pushViewController(vc, animated: true)
        }else{
            VIEWMANAGER.isBackInIpadLost = true
            removeIpad(asChildViewController: HomeVCiPad)
            addIpad(asChildViewController: LostLuggageiPad)
        }
    }
    
    func navigateToFlightCancellationiPad(){
        let storyID = UIStoryboard(name: Storyboards.FlightCancellationiPadStoryboard, bundle:nil)
        let vc = storyID.instantiateViewController(withIdentifier: ViewControllers.FlightCancellationViewController) as! FlightCancellationViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func navigateToFlightDelayiPad(){
        let storyID = UIStoryboard(name: Storyboards.FlightDelayiPadStoryboard, bundle:nil)
        let vc = storyID.instantiateViewController(withIdentifier: ViewControllers.FlightDelayViewController) as! FlightDelayViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func navigateToLostBaggageiPad(){
        let storyID = UIStoryboard(name: Storyboards.LostBaggageiPadStoryboard, bundle:nil)
        let vc = storyID.instantiateViewController(withIdentifier: ViewControllers.LostBaggageViewController) as! LostBaggageViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func navigateToIssueListingiPad(){
        let storyID = UIStoryboard(name: Storyboards.IssueListiPadStoryboard, bundle:nil)
        let vc = storyID.instantiateViewController(withIdentifier: ViewControllers.IssueListingViewController) as! IssueListingViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func navigateToFlightBookingDetails(){
        let storyID = UIStoryboard(name: Storyboards.FlightBookingDetailsStoryboard, bundle:nil)
        let vc = storyID.instantiateViewController(withIdentifier: ViewControllers.FlightBookingDetailsViewController) as! FlightBookingDetailsViewController
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    // MARK: Button Action Methods
    
    @IBAction func sideMenuButtonClicked(_ sender: UIButton) {
        openSideMenu()
    }
    
    
    @IBAction func btnBookingClicked(_ sender: Any) {
        navigateToBookingDetail()
    }
  
    
    @IBAction func btnSiriClicked(_ sender: Any) {
        createSiriShortcut()
    }
    
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource{
    
    // MARK: TableView Methods
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reportImageArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if Constants.deviceType == DeviceType.iPad.rawValue{
            let cell = self.homeTableView.dequeueReusableCell(withIdentifier: Cells.HomeiPadTableViewCell, for: indexPath) as! HomeiPadTableViewCell
            cell.reportImageView.image = reportImageArray[indexPath.row]
            cell.reportImageView.contentMode = .scaleAspectFit
            cell.reportImageView.clipsToBounds = true
            return cell
        }else{
            let cell = self.homeTableView.dequeueReusableCell(withIdentifier: Cells.HomeTableViewCell, for: indexPath) as! HomeTableViewCell
            cell.reportImageView.image = reportImageArray[indexPath.row]
            cell.contentView.backgroundColor = UIColor.black
            cell.backgroundColor = UIColor.blue
            cell.backgroundView?.backgroundColor = UIColor.red
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            switch indexPath.row{
            case 0:
                navigateToFlightCancellation()
            case 1:
                navigateToFlightDelay()
            case 2:
                navigateToLostBaggage()
            default:
                print("nothing")
            }
    }
    
}

extension HomeViewController: INUIAddVoiceShortcutViewControllerDelegate {
    func addVoiceShortcutViewController(_ controller: INUIAddVoiceShortcutViewController, didFinishWith voiceShortcut: INVoiceShortcut?, error: Error?) {
        // Handle the result of adding the voice shortcut
        if let error = error {
           // print("Error adding voice shortcut: \(error.localizedDescription)")
        } else if let voiceShortcut = voiceShortcut {
            print("Voice shortcut added successfully: \(voiceShortcut.invocationPhrase)")
        }
        
        // Dismiss the view controller
        controller.dismiss(animated: true, completion: nil)
    }
    
 
    //MARK: Siri Shortcut Setup Methods
    
//    func addVoiceShortcutViewController(_ controller: INUIAddVoiceShortcutViewController, didFinishWith voiceShortcut: INVoiceShortcut?, error: Error?) {
//        // Handle the result of adding the voice shortcut
//        if let error = error {
//           // print("Error adding voice shortcut: \(error.localizedDescription)")
//        } else if let voiceShortcut = voiceShortcut {
//            print("Voice shortcut added successfully: \(voiceShortcut.invocationPhrase)")
//        }
//        
//        // Dismiss the view controller
//        controller.dismiss(animated: true, completion: nil)
//    }
    
    func addVoiceShortcutViewControllerDidCancel(_ controller: INUIAddVoiceShortcutViewController) {
        // User canceled adding the voice shortcut
        // Dismiss the view controller
        controller.dismiss(animated: true, completion: nil)
    }
}


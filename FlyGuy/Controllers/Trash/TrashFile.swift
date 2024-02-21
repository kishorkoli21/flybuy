//
//  TrashFile.swift
//  FlyGuy
//
//  Created by Springup Labs on 13/07/23.
//

import Foundation

// MARK: PersonalInfoViewController


//            if Constants.deviceType == DeviceType.iPad.rawValue{
//                showOnboardingScreeniPad()
//            }else{
//                navigateToOnboarding()
//            }


//    func showOnboardingScreeniPad(){
//        let storyboard = UIStoryboard(name: Storyboards.OnboardingiPadStoryboard, bundle:nil)
//        let onboardingVC = storyboard.instantiateViewController(withIdentifier: ViewControllers.OnboardingViewController) as! OnboardingViewController
//        onboardingVC.hidesBottomBarWhenPushed = true
//        self.navigationController?.pushViewController(onboardingVC, animated: true)
//    }
//
//    func navigateToOnboarding(){
//        let storyID = UIStoryboard(name: Storyboards.OnboardingStoryboard, bundle:nil)
//        let vc = storyID.instantiateViewController(withIdentifier: ViewControllers.OnboardingViewController) as! OnboardingViewController
//        vc.hidesBottomBarWhenPushed = true
//        navigationController?.pushViewController(vc, animated: true)
//    }


// MARK: PaymentGatewayViewController

//                    self.openInAppBrowser(withURL: url)


//extension PaymentGatewayViewController: SFSafariViewControllerDelegate{
//
//    func openInAppBrowser(withURL url: URL) {
//          let safariViewController = SFSafariViewController(url: url)
//          safariViewController.delegate = self
//          present(safariViewController, animated: true, completion: nil)
//      }
//
//}

// MARK: FlightBookingDetailsViewController


//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        if Constants.deviceType == DeviceType.iPhone.rawValue{
//            let customView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width - 40, height: 50))
//            let titleLabel = UILabel(frame: CGRect(x:0,y: customView.frame.midY - 15 ,width:200,height:30))
//            titleLabel.backgroundColor = UIColor.clear
//            titleLabel.textColor = .black
//            titleLabel.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
//            titleLabel.text  = "Inbound Flight"
//            titleLabel.textAlignment = .natural
//            customView.addSubview(titleLabel)
//            let lineView = UIView(frame: CGRect(x: 0, y: titleLabel.frame.height + 5, width: tableView.frame.width, height: 1))
//            lineView.backgroundColor = UIColor.lightGray
//            customView.addSubview(lineView)
//            return customView
//        }else{
//            let customView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width - 40, height: 60))
//            let titleLabel = UILabel(frame: CGRect(x:0,y: customView.frame.midY - 15 ,width:200,height:50))
//            titleLabel.backgroundColor = UIColor.clear
//            titleLabel.textColor = .black
//            titleLabel.font = UIFont.systemFont(ofSize: 25, weight: .semibold)
//            titleLabel.text  = "Inbound Flight"
//            titleLabel.textAlignment = .natural
//            customView.addSubview(titleLabel)
//            let lineView = UIView(frame: CGRect(x: 0, y: titleLabel.frame.height + 5, width: tableView.frame.width, height: 1))
//            lineView.backgroundColor = UIColor.lightGray
//            customView.addSubview(lineView)
//            return customView
//
//        }
//    }
//
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        if Constants.deviceType == DeviceType.iPhone.rawValue{
//            return 50
//        }else{
//            return 60
//        }
//    }

//        downloadPDF(from: finalURL) { (fileURL, error) in
//            if let error = error {
//                print("Error downloading PDF: \(error)")
//            } else if let fileURL = fileURL {
//                print("PDF downloaded successfully. File URL: \(fileURL)")
//                // You can now access the downloaded PDF file using the fileURL
//            }
//        }
        

//    func savePdf(urlString:String, fileName:String) {
//           DispatchQueue.main.async {
//               let url = URL(string: urlString)
//               let pdfData = try? Data.init(contentsOf: url!)
//               let resourceDocPath = (FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)).last! as URL
//               let pdfNameFromUrl = "FlyGuy-\(fileName).pdf"
//               let actualPath = resourceDocPath.appendingPathComponent(pdfNameFromUrl)
//               do {
//                   try pdfData?.write(to: actualPath, options: .atomic)
//                   print("pdf successfully saved!")
//               } catch {
//                   print("Pdf could not be saved")
//               }
//           }
//       }

//    func savePdf(urlString: String, fileName: String) {
//        DispatchQueue.global().async {
//            if let url = URL(string: urlString) {
//                let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
//                    if let error = error {
//                        print("Error downloading PDF: \(error)")
//                        return
//                    }
//
//                    guard let pdfData = data else {
//                        print("No data received for PDF")
//                        return
//                    }
//
//                    let resourceDocPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last!
//                    let pdfNameFromUrl = "FlyGuy-\(fileName).pdf"
//                    let actualPath = resourceDocPath.appendingPathComponent(pdfNameFromUrl)
//
//                    do {
//                        try pdfData.write(to: actualPath, options: .atomic)
//                        print("PDF successfully saved!")
//                    } catch {
//                        print("PDF could not be saved: \(error)")
//                    }
//                }
//
//                task.resume()
//            } else {
//                print("Invalid URL")
//            }
//        }
//    }
//
//
//       func showSavedPdf(url:String, fileName:String) {
//           if #available(iOS 10.0, *) {
//               do {
//                   let docURL = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
//                   let contents = try FileManager.default.contentsOfDirectory(at: docURL, includingPropertiesForKeys: [.fileResourceTypeKey], options: .skipsHiddenFiles)
//                   for url in contents {
//                       if url.description.contains("\(fileName).pdf") {
//                          // its your file! do what you want with it!
//                   }
//               }
//           } catch {
//               print("could not locate pdf file !!!!!!!")
//           }
//       }
//   }
//
//   // check to avoid saving a file multiple times
//   func pdfFileAlreadySaved(url:String, fileName:String)-> Bool {
//       var status = false
//       if #available(iOS 10.0, *) {
//           do {
//               let docURL = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
//               let contents = try FileManager.default.contentsOfDirectory(at: docURL, includingPropertiesForKeys: [.fileResourceTypeKey], options: .skipsHiddenFiles)
//               for url in contents {
//                   if url.description.contains("FlyGuy-\(fileName).pdf") {
//                       status = true
//                   }
//               }
//           } catch {
//               print("could not locate pdf file !!!!!!!")
//           }
//       }
//       return status
//   }


//The URL to Save
//        let url = API.downloadTicketApi.rawValue.self
//        let pnrid = url + ViewManager.shared.pnrID
//        let BaseURL = Bundle.main.infoDictionary?[Constants.baseURL]
//        let finalURL = BaseURL as! String + pnrid
//        guard let url = URL(string: finalURL.replacingOccurrences(of: " ", with: "%20")) else { return }
//        //Create a URL request
//        let urlRequest = NSURLRequest(url: url)
//        //get the data
//        let theData = NSURLConnection.sendSynchronousRequest(urlRequest as URLRequest, returningResponse: nil, error: nil)
//
//        //Get the local docs directory and append your local filename.
//        var docURL = (FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)).last as? NSURL
//
//        docURL = docURL?.URLByAppendingPathComponent( "myFileName.pdf")
//
//        //Lastly, write your file to the disk.
//        theData?.writeToURL(docURL!, atomically: true)



  
//    func downloadTicketApiConfigure(){
////        viewModel.view = self
////        viewModel.getDownloadTicketApi { isSuccess in
////            if isSuccess{
////                print("Success")
////            }else{
////                print("Error")
////            }
////        }
//            DispatchQueue.main.async {
//                let url = API.downloadTicketApi.rawValue.self
//                let pnrid = url + ViewManager.shared.pnrID
//                let BaseURL = Bundle.main.infoDictionary?[Constants.baseURL]
//                let finalURL = BaseURL as! String + pnrid
//                self.showActionSheet(["View","Download"]) { (value) in
//                    if value == "View" {
////                        self.showSavedPdf(url: finalURL, fileName: "Ticket\(ViewManager.shared.pnrID)")
//                    }
//                    else if value == "Download" {
//
//                        guard let url = URL(string: finalURL.replacingOccurrences(of: " ", with: "%20")) else { return }
////
////                        let value = self.pdfFileAlreadySaved(url: finalURL, fileName: "Ticket\(ViewManager.shared.pnrID)")
////                        if !value{
////                            self.savePdf(urlString: finalURL, fileName: "Ticket\(ViewManager.shared.pnrID)")
////                        }
//                        let urlSession = URLSession(configuration: .default, delegate: self, delegateQueue: OperationQueue())
//
//                        let downloadTask = urlSession.downloadTask(with: url)
//                        downloadTask.resume()
//                    }
//                }
//            }
//
//    }

//
//// Your download URL
//let downloadURLString = "https://testapi.datascalp.com/apiv1/flightbooking/flightbookingticket?pnr_id=TR40412023"


//                if let passengerName = internalModel?["PassengerFirstName"], let passengerLastName = internalModel?["PassengerLastName"], let ticketNumber = internalModel?["eTicketNumber"], let type = internalModel?["PassengerType"]{
//                    cell.lblPassengerName.text = "\(passengerName ?? "") \(passengerLastName ?? "")"
//                    cell.lblTicketNumber.text = ticketNumber
//                    if type == "ADT"{
//                        cell.lblType.text = "Adult"
//                    }else if type == "CHD"{
//                        cell.lblType.text = "Child"
//                    }else{
//                        cell.lblType.text =  "Infant"
//                    }
//                }




//    override func showActionSheet(_ actionSheetData:NSArray,isIpad: Bool = false, actionSheetImages:NSArray = [],completion:@escaping (String) -> Void)
//    {
//        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
//
//        for i in 0..<actionSheetData.count  {
//            let title = actionSheetData[i] as? String
//            let alertAction = UIAlertAction(title: title , style: .default, handler: { (action) in
//                completion(action.title!)
//
//                if self.onSelect != nil{
//                    self.onSelect!()
//                }
//            })
//            if actionSheetImages.count == actionSheetData.count {
//                let image = UIImage(named: actionSheetImages[i] as! String)
//                alertAction.setValue(image?.withRenderingMode(.alwaysOriginal), forKey: "image")
//            }
//            alert.addAction(alertAction)
//        }
//        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { action in
//            completion(action.title!)
//
//            if self.onSelect != nil{
//                self.onSelect!()
//            }
//        }
//        alert.addAction(cancelAction)
//        if isIpad{
//            alert.popoverPresentationController?.sourceView = view
//            alert.popoverPresentationController?.sourceRect = CGRect(x: view.bounds.midX, y: view.bounds.midY, width: 0, height: 0)
//            alert.popoverPresentationController?.permittedArrowDirections = []
//        }
//        self.present(alert, animated: true, completion: nil)
//
//    }


//        let url = API.downloadTicketApi.rawValue.self
//        let pnrid = url + ViewManager.shared.pnrID
//        let BaseURL = Bundle.main.infoDictionary?[Constants.baseURL]
//        let finalURL = BaseURL as! String + pnrid
//        if let sharingUrl = URL(string: finalURL), !sharingUrl.absoluteString.isEmpty {
//          let objectsToShare = [sharingUrl]
//          let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
//          self.present(activityVC, animated: true, completion: nil)
//        } else {
//          // show alert for not available
//        }


// MARK: BookingDetailsViewController

//extension BookingDetailsViewController {
//    func activateActivity(using board: Board) {
//        userActivity = NSUserActivity(activityType: "Open_board")
//        let title = "Open board \(board.title)"
//        userActivity?.title = title
//        userActivity?.userInfo = ["id": board.identifier]
//        userActivity?.suggestedInvocationPhrase = title
//        userActivity?.isEligibleForPrediction = true
//        userActivity?.persistentIdentifier = board.identifier
//    }
//}

// Adjust the height of the table view based on the number of rows
//                let maxHeight = self.view.safeAreaLayoutGuide.layoutFrame.height - self.tblViewDestination.frame.origin.y
//                let numRows = self.tblViewDestination.numberOfRows(inSection: 0)
//                let rowHeight = self.tblViewDestination.rowHeight
//                let totalHeight = CGFloat(numRows) * rowHeight
//                let height = min(totalHeight, maxHeight)


//        if strDate == strReturnDate{
//            let modifiedDate = Calendar.current.date(byAdding: .year, value: 1, to: today)!
//            let modifiedStrDate = formatter.string(from: modifiedDate)
//            self.showAlert(error: Messages.pastDate, dateStr: modifiedStrDate, isDeparture: false)
//            return false
//        }


// MARK: ContactUsViewController

//    func setLabelData(){
////        contactUsTextLabel.text = Messages.mediaKitTitle
////        contactUsDescLabel.text = Messages.contactUsDescription
////        mailOneLabel.text = Messages.mailRecipient1
////        mailTwoLabel.text = Messages.mailRecipient2
//      //  mediaKitButton.setTitle(Messages.mediaKitTitle, for: .normal)
////        mailOneLabel.underline()
////        mailTwoLabel.underline()
//    }


// MARK: HomeViewController

//
//    //MARK: Calender Methods
//    func requestAccess() {
//        eventStore.requestAccess(to: .event) { (granted, error) in
//            if granted {
//                DispatchQueue.main.async {
//                    print("Permission granted")
//                    let dateFormatter = DateFormatter()
//                    let endDate = dateFormatter.date(from: "2023-05-12")
//
//                    let nextMonth = Calendar.current.date(byAdding: .month, value: 1, to: Date())
//
//                    let predicate = self.eventStore.predicateForEvents(withStart: Date(), end: nextMonth ?? Date(), calendars: nil)
//                    let events = self.eventStore.events(matching: predicate)
//                    //print("Event desc",events.description)
//                    print("events",events)
//
//                }
//            }else{
//                print("Permission denied")
//            }
//        }
//    }
//
//
//    func eventData(){
//        let store = EKEventStore()
//        store.requestAccess(to: EKEntityType.event) { [self] (granted, error) in
//            if(granted){
//                let calendars = store.calendars(for: EKEntityType.event)
//                let nextMonth = Calendar.current.date(byAdding: .month, value: 1, to: Date())
//
//                for calendar in calendars {
//                    let predicate = store.predicateForEvents(withStart: Date(), end: nextMonth ?? Date(), calendars: [calendar])
//
//                    store.enumerateEvents(matching: predicate){ (event, stop) in
//                        print(event.title ?? "")
//                        print(event.description)
//                        let tempEvent = CalenderEventStruct(eventTitle: event.title ?? "", eventDescription: event.description )
//                        self.allEventArray.append(tempEvent)
//                    }
//
//                }
//
//                for event in self.allEventArray {
//                    let cancelledTitleCheck = flightCancelledKeywordsArray.contains(event.eventTitle ?? "")
//                    let flightDelayCheckTitleCheck = flightDelayKeywordsArray.contains(event.eventTitle ?? "")
//                    let lostBaggageTitleCheck = lostBaggageKeywordsArray.contains(event.eventTitle ?? "")
//
//                    if cancelledTitleCheck == true{
//                        let flightNumber = getFlightNumber(eventDesc: event.eventDescription ?? "")
//                        self.selectedCalenderEventArray.append(SelectedCalenderEventStruct(issueTitle: IncidentTypeEnumForNotification.CancelledFlight.rawValue.self, flightNumber: flightNumber, lateness: ""))
//                    }
//
//                    if flightDelayCheckTitleCheck == true{
//                        let flightNumber = getFlightNumber(eventDesc: event.eventDescription ?? "")
//                        self.selectedCalenderEventArray.append(SelectedCalenderEventStruct(issueTitle: IncidentTypeEnumForNotification.CancelledFlight.rawValue.self, flightNumber: flightNumber, lateness: ""))
//                    }
//
//                    if lostBaggageTitleCheck == true{
//                        let flightNumber = getFlightNumber(eventDesc: event.eventDescription ?? "")
//                        self.selectedCalenderEventArray.append(SelectedCalenderEventStruct(issueTitle: IncidentTypeEnumForNotification.CancelledFlight.rawValue.self, flightNumber: flightNumber, lateness: ""))
//                    }
//
//                }
//
//                //sendNotification(issueName: selectedCalenderEventArray.first?.issueTitle ?? "", flightNumber: selectedCalenderEventArray.first?.flightNumber ?? "", lateness: selectedCalenderEventArray.first?.lateness ?? "")
//
//            }else{
//                print(error ?? "")
//            }
//        }
//
//    }
//
//    func sendNotification(issueName:String, flightNumber:String, lateness:String) {
//        let center = UNUserNotificationCenter.current()
//        let notificationContent = UNMutableNotificationContent()
//        notificationContent.title = Constants.AppName
//        notificationContent.body = "Test body"
//        notificationContent.sound = .default
//        notificationContent.userInfo = [Constants.issueName: issueName,Constants.flightNumber: flightNumber,Constants.lateness: lateness]
//        //notificationContent.badge = NSNumber(value: 3)
//
//        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1,
//                                                        repeats: false)
//        let request = UNNotificationRequest(identifier: Constants.incidentNotification,
//                                            content: notificationContent,
//                                            trigger: trigger)
//
//        center.add(request) { (error) in
//            if let error = error {
//                print("Notification Error: ", error)
//            }
//        }
//    }
//
//    func getFlightNumber(eventDesc:String) -> String{
//        var stringAfterFlight = ""
//        let snippet = eventDesc
//
//        if let range = snippet.range(of: "flight ") {
//            stringAfterFlight = String(snippet[range.upperBound...])
//        }
//
//        let flightNumber = stringAfterFlight.components(separatedBy: " ").first
//        let checkIsFlightNumber = flightNumber?.match ?? false
//        if checkIsFlightNumber == true{
//            return flightNumber ?? ""
//        }else{
//            return ""
//        }
//    }

//Siri

//    func resolveDestination(for intent: FlightBookingIntent, with completion: @escaping (INStringResolutionResult) -> Void) {
//        guard let destinationJourney = intent.destination else{
//            completion(.needsValue())
//            return
//        }
//        completion(.success(with: destinationJourney))
//    }
//
//    func resolveDeparture(for intent: FlightBookingIntent, with completion: @escaping (INStringResolutionResult) -> Void) {
//        guard let startJourney = intent.departure else{
//            completion(.needsValue())
//            return
//        }
//        completion(.success(with: startJourney))
//    }
//
//
//
//    func resolveDate(for intent: FlightBookingIntent, with completion: @escaping (FlightBookingDateResolutionResult) -> Void) {
//
//        guard let journeyDate = intent.date else{
//            completion(.needsValue())
//            return
//        }
//        let comps = DateComponents()
//        let formatter = DateFormatter()
//        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
//        if let date = Calendar.current.date(from: journeyDate ) {
//            completion(.success(with: journeyDate))
//        }else{
//            completion(.unsupported(forReason: .notValid))
//        }
//
//    }
//
//
//
//    func resolveTime(for intent: FlightBookingIntent, with completion: @escaping (INDateComponentsResolutionResult) -> Void) {
//        guard let journeyTime = intent.time else{
//            completion(.needsValue())
//            return
//        }
//        completion(.success(with: journeyTime))
//    }
//
//    func resolveTrip(for intent: FlightBookingIntent, with completion: @escaping (INStringResolutionResult) -> Void) {
//        guard let trip = intent.trip else{
//            completion(.disambiguation(with: ["One Way Trip","Return Trip"]))
//            return
//        }
//        completion(.success(with: trip))
//    }
//
//    func resolveReturnDate(for intent: FlightBookingIntent, with completion: @escaping (FlightBookingReturnDateResolutionResult) -> Void) {
//        if intent.trip == "One Way Trip"{
//            completion(.notRequired())
//            return
//        }
//        guard let returnDate = intent.returnDate else{
//            completion(.needsValue())
//            return
//        }
//        let comps = DateComponents()
//        let formatter = DateFormatter()
//        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
//        if let date = Calendar.current.date(from: returnDate ) {
//            completion(.success(with: returnDate))
//        }else{
//            completion(.unsupported(forReason: .notValid))
//        }
//    }
//
//    func resolveReturnTime(for intent: FlightBookingIntent, with completion: @escaping (INDateComponentsResolutionResult) -> Void) {
//        if intent.trip == "One Way Trip"{
//            completion(.notRequired())
//            return
//        }
//        guard let returnTime = intent.returnTime else{
//            completion(.needsValue())
//            return
//        }
//        completion(.success(with: returnTime))
//    }
//
//    func resolvePreferredClass(for intent: FlightBookingIntent, with completion: @escaping (INStringResolutionResult) -> Void) {
//        guard let journeyClass = intent.preferredClass else{
//            completion(.disambiguation(with: ["Economy Class","Business Class"]))
//            return
//        }
//        completion(.success(with: journeyClass))
//    }
//
//
//    func resolveConfirm(for intent: FlightBookingIntent, with completion: @escaping (INBooleanResolutionResult) -> Void) {
//        guard let confirmation = intent.confirm, confirmation != false else {
//            //Siri ask questions only once
//            if isSiriAskedConfirmation {
//                DispatchQueue.main.asyncAfter(deadline: .now()) {
//                    exit(0)
//                }
//            }
//            isSiriAskedConfirmation = true
//            completion(INBooleanResolutionResult.confirmationRequired(with: true))
//            return
//        }
//    }
//
//
//
//
//    func handle(intent: FlightBookingIntent, completion: @escaping (FlightBookingIntentResponse) -> Void) {
//        sharedUserDefaults?.set("siri", forKey: SharedUserDefaults.Keys.from)
//        sharedUserDefaults?.set(intent.departure, forKey: SharedUserDefaults.Keys.startJourney)
//        sharedUserDefaults?.set(intent.destination, forKey: SharedUserDefaults.Keys.destination)
//        sharedUserDefaults?.set(intent.trip, forKey: SharedUserDefaults.Keys.trip)
//        sharedUserDefaults?.set(intent.preferredClass, forKey: SharedUserDefaults.Keys.preferredClass)
//        guard let from = sharedUserDefaults?.string(forKey: SharedUserDefaults.Keys.from) else {return}
//        print(from)
//        let comps = DateComponents()
//        let formatter = DateFormatter()
//        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
//        if let date = Calendar.current.date(from: intent.date ?? comps) {
//            let myString = formatter.string(from: date)
//            print(myString)
//            sharedUserDefaults?.set(myString, forKey: SharedUserDefaults.Keys.date)
//        }
//        if let time = Calendar.current.date(from: intent.time ?? comps) {
//            let myString = formatter.string(from: time)
//            print(myString)
//            sharedUserDefaults?.set(myString, forKey: SharedUserDefaults.Keys.time)
//        }
//        if intent.trip == "Return Trip"  {
//            if let date = Calendar.current.date(from: intent.returnDate ?? comps) {
//                let myString = formatter.string(from: date)
//                print(myString)
//                sharedUserDefaults?.set(myString, forKey: SharedUserDefaults.Keys.returnDate)
//            }
//            if let time = Calendar.current.date(from: intent.returnTime ?? comps) {
//                let myString = formatter.string(from: time)
//                print(myString)
//                sharedUserDefaults?.set(myString, forKey: SharedUserDefaults.Keys.returnTime)
//            }
//        }
//        completion(.init(code: .continueInApp, userActivity: nil))
//    }

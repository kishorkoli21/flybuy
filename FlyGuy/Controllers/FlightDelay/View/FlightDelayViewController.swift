//
//  FlightDelayViewController.swift
//  FlyGuy
//
//  Created by Mac on 16/03/23.
//

import UIKit

protocol FlightDelayProtocol {
    var controller: FlightDelayViewController { get }
}

class FlightDelayViewController: BaseViewController, UITextFieldDelegate, UIPopoverPresentationControllerDelegate {
    
    @IBOutlet weak var latenessTextLabel: UILabel!
    @IBOutlet weak var latenessTextFiled: UITextField!
    @IBOutlet weak var flightDealyTextLabel: UILabel!
    @IBOutlet weak var airlineTextLabel: UILabel!
    @IBOutlet weak var flightNumberTextLabel: UILabel!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var selectAirlineTextFiled: UITextField!
    @IBOutlet weak var flightNumberTextFiled: UITextField!
    @IBOutlet weak var airLineDropDownTableView: UITableView!
    @IBOutlet weak var heightConstraintOfDropDownTableView: NSLayoutConstraint!
    @IBOutlet weak var airlineStackView: UIStackView!
    @IBOutlet weak var airlineLabelNotFoundLabel: UILabel!
    @IBOutlet weak var sideMenuFlightDelayContainerView: UIView!
    @IBOutlet weak var infoRedImageView: UIImageView!
    @IBOutlet weak var infoButton: UIButton!
    @IBOutlet weak var viewBack: UIView!
    @IBOutlet weak var viewBackHeightConstraint: NSLayoutConstraint!
    
    var viewModel = FlightDelayViewModel()
    var searchAirlineList : AirlineCodeModel = []
    var reportParameters = IncidentsParameterKeyStruct()
    let databaseInstance = bt_database.instance
    
    var searchAirlineflag = false
    var infoButtonFlag = false
    var isChecked = true
    var selectedAirlineName = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if Constants.deviceType == DeviceType.iPhone.rawValue{
            setUpInitialData()
        }else{
            setUpInitialData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        configure()
        super.viewWillAppear(animated)
        self.airLineDropDownTableView.addObserver(self, forKeyPath: Messages.contentSizeTitle, options: [], context: nil)
        if VIEWMANAGER.isBackInIpadDelay{
            self.viewBackHeightConstraint.constant = 80
            self.viewBack.isHidden = false
        }
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        self.heightConstraintOfDropDownTableView.constant = airLineDropDownTableView.contentSize.height
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeNotitificationData()
        self.airLineDropDownTableView.removeObserver(self, forKeyPath: Messages.contentSizeTitle)
    }
    
    // MARK: Initial View setup methods

    
    func configure(){
        viewModel.view = self
        viewModel.getAirlineCodeList()
    }
    
    func removeNotitificationData(){
        Constants.notificationIssueNameValue = ""
        Constants.notificationFlightNumberValue = ""
        Constants.notificationlateessValue = ""
        Constants.isFromNotification = false
    }
    
    func setUpInitialData(){
        self.statusBarBackgroundColor(colorHex: AppColor.statusBarColor)
        self.airLineDropDownTableView.register(UINib.init(nibName: Cells.AirLineDropDownTableViewCell, bundle: nil), forCellReuseIdentifier: Cells.AirLineDropDownTableViewCell)
        if #available(iOS 15.0, *){
            self.airLineDropDownTableView.sectionHeaderTopPadding = 0.0
        }
        flightNumberTextFiled.delegate = self
        flightDealyTextLabel.text = Messages.flightDelayTitle
        flightNumberTextLabel.text = Messages.flightNumberTitle
        submitButton.setTitle(Messages.submitTitle, for: .normal)
        flightNumberTextFiled.placeholder = Messages.flightNumberPlaceholderTitle
        latenessTextLabel.text = Messages.latenessTitle
        latenessTextFiled.placeholder = Messages.latenessPlaceholderTitle
        
        flightNumberTextFiled.addTarget(self, action: #selector(searchTextChanged(_:)), for: .editingChanged)
    }
    
    
    @objc func searchTextChanged(_ sender: UITextField) {
        let search = sender.text ?? ""
        if search.count <= 2{
            filterContentForSearchText(search)
        }
    }
    
    func filterContentForSearchText(_ searchText: String?) {
        searchAirlineList.removeAll()
        let searchString = searchText
        if searchString?.count ?? 0 > 1 {
            searchAirlineflag = true
            searchAirlineList = viewModel.airlineCodeList?.filter({ (item) -> Bool in
                let value: NSString = item.iata! as NSString
                return (value.range(of: searchString!, options: .caseInsensitive).location != NSNotFound)
            }) ?? []
            airlineStackView.isHidden = false
            airLineDropDownTableView.isHidden = false
            airlineLabelNotFoundLabel.isHidden = true
            infoRedImageView.isHidden = true
            infoButton.isHidden = true
        }else{
            searchAirlineflag = false
            airlineStackView.isHidden = true
            airLineDropDownTableView.isHidden = true
            airlineLabelNotFoundLabel.isHidden = true
            infoRedImageView.isHidden = true
            infoButton.isHidden = true
        }
        
        if searchString?.count ?? 0 > 1{
            if searchAirlineList.isEmpty == true {
                self.airlineStackView.isHidden = false
                self.airLineDropDownTableView.isHidden = true
                self.airlineLabelNotFoundLabel.isHidden = false
                infoRedImageView.isHidden = false
                infoButton.isHidden = false
            }
        }
        
        UIView.transition(with: self.airLineDropDownTableView,
                          duration: 0.35,
                          options: .transitionCrossDissolve,
                          animations: {
            self.airLineDropDownTableView.reloadData()
        })
        
        print("selectedAirlineName is",selectedAirlineName)
    }
    
       
    //MARK: - Navigation methods
       
    func presentAllFlightPopUp(){
        let storyBoard : UIStoryboard = UIStoryboard(name: Storyboards.AllFlightPopUpStoryboard, bundle:nil)
        let popUpVC = storyBoard.instantiateViewController(withIdentifier: ViewControllers.AllFlightPopUpViewController) as! AllFlightPopUpViewController
        popUpVC.titleText = Messages.flightDelayTitle
        popUpVC.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        popUpVC.callBackLogout = { (result: Bool) in
            DispatchQueue.main.asyncAfter(deadline: .now()) { [self] in
                self.tabBarController?.tabBar.isHidden = false
            }}
        self.tabBarController?.tabBar.isHidden = true
        self.present(popUpVC, animated: true)
    }
       
    func presentAllFlightiPadPopUp(){
        let storyBoard : UIStoryboard = UIStoryboard(name: Storyboards.AllFlightPopUpiPadStoryboard, bundle:nil)
        guard let popUpVC = storyBoard.instantiateViewController(withIdentifier: ViewControllers.AllFlightPopUpViewController) as? AllFlightPopUpViewController else { return }
        popUpVC.modalPresentationStyle = .popover
        let popOverVC = popUpVC.popoverPresentationController
        popOverVC?.delegate = self
        popOverVC?.sourceView = self.infoButton
        popOverVC?.permittedArrowDirections = .left
        popOverVC?.sourceRect = self.infoButton.bounds
        popUpVC.preferredContentSize = CGSize(width: 500, height: 1000)
        self.present(popUpVC, animated: true)
    }
       
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        UIModalPresentationStyle.none
    }
    
    //MARK: - Button Action methods
    
    @IBAction func backButtonClicked(_ sender: UIButton) {
        if Constants.deviceType == DeviceType.iPhone.rawValue{
            navigationController?.popViewController(animated: true)
        }else{
            VIEWMANAGER.isBackInIpadDelay = false
            removeIpad(asChildViewController: FlightDelayiPad)
            addIpad(asChildViewController: HomeVCiPad)
        }
    }
    
    @IBAction func dropDownButtonClicked(_ sender: UIButton) {
        if searchAirlineList.count > 0 {
            UIView.animate(withDuration: 0.5) {
                self.airLineDropDownTableView.isHidden = !self.airLineDropDownTableView.isHidden
            }
        }
    }
 
    @IBAction func infoButtonClicked(_ sender: UIButton) {
        infoButtonFlag = true
        self.airLineDropDownTableView.isHidden = true
        self.flightNumberTextFiled.text = ""
        if Constants.deviceType == DeviceType.iPhone.rawValue{
            presentAllFlightPopUp()
        }else{
            presentAllFlightiPadPopUp()
        }
    }
 
    
    @IBAction func reportIncidentButtonClicked(_ sender: UIButton) {
        
        if flightNumberTextFiled.text == ""{
            self.view.makeToast(Messages.EmptyFlightNumberMessage, duration: 2.0, position: .bottom)
        }else if latenessTextFiled.text == ""{
            self.view.makeToast(Messages.EmptyLatenessMessage, duration: 2.0, position: .bottom)
        }else{
            let ipAddress = getIPAddress()
            print("ipAddress is",ipAddress ?? "")
            reportParameters.issue = IncidentTypeEnum.LateFlight.rawValue.self
            reportParameters.difference = latenessTextFiled.text ?? ""
            reportParameters.airlineName = selectedAirlineName
            reportParameters.clientIP = ipAddress ?? ""
            reportParameters.flightNumber = flightNumberTextFiled.text ?? ""
            reportParameters.sum = Constants.sum
            reportParameters.channel = Constants.channel
    
            viewModel.reportIncidents(flightDelayParameters: reportParameters)
        }
    }
    
    
}

extension FlightDelayViewController : UITableViewDelegate, UITableViewDataSource{
    
    //MARK: - TableView methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchAirlineList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.airLineDropDownTableView.dequeueReusableCell(withIdentifier: Cells.AirLineDropDownTableViewCell, for: indexPath) as! AirLineDropDownTableViewCell
        cell.airLineNameLabel.text = searchAirlineList[indexPath.row].airlineName ?? ""
        selectedAirlineName = searchAirlineList[indexPath.row].airlineName ?? ""
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}


extension FlightDelayViewController: FlightDelayProtocol {
    var controller: FlightDelayViewController {
        self
    }
}

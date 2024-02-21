//
//  MainiPadContainerViewController.swift
//  FlyGuy
//
//  Created by Mac on 07/04/23.
//

import UIKit

struct rowSideMenuStruct {
  var name = ""
  var image = ""
}

struct sectionStruct{
    var sectionName = ""
    var rowArray = [rowSideMenuStruct]()
}

class MainiPadContainerViewController: BaseViewController {

    @IBOutlet weak var iPadSideMenuTableView: UITableView!
    @IBOutlet weak var container1: UIView!
    @IBOutlet weak var sideMenuContainerView: UIView!
    var sideMenuArray = [sectionStruct]()
    static var selectedSideMenu = Messages.homeTitle
    var isFromipadOnboarding = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpInitialView()
    }
    
    func setUpInitialView(){
        setUpSideMenuArray()
        if isFromipadOnboarding == true{
            MainiPadContainerViewController.selectedSideMenu = Messages.homeTitle
            //sideMenuContainerView.removeShadowForiPadCell()
        }else{
            //sideMenuContainerView.addShadowForiPadCell()
        }
        configureView()
        self.iPadSideMenuTableView.register(UINib.init(nibName: Cells.iPadSideMenuTableViewCell, bundle: nil), forCellReuseIdentifier: Cells.iPadSideMenuTableViewCell)
        if #available(iOS 15.0, *){
            self.iPadSideMenuTableView.sectionHeaderTopPadding = 0.0
        }
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        sideMenuContainerView.addShadowForiPadCell()
        //sideMenuContainerView.clipsToBounds = false
    }
    
    func setUpSideMenuArray(){
        
        sideMenuArray.append(sectionStruct(sectionName: "",rowArray: [rowSideMenuStruct(name: Messages.homeTitle,image: Messages.homeIcon),rowSideMenuStruct(name: Messages.myTripsTitle,image: Messages.myTripIcon),rowSideMenuStruct(name: Messages.profileTitle,image: Messages.profileIcon)]))
        
        sideMenuArray.append(sectionStruct(sectionName: "Report Issues",rowArray: [rowSideMenuStruct(name: Messages.myIssuesTitle,image: Messages.myIssuesIcon),rowSideMenuStruct(name: Messages.cancelledFlightTitle,image: Messages.cancelFlightIcon),rowSideMenuStruct(name: Messages.lateFlightTitle,image: Messages.lateFlightIcon),rowSideMenuStruct(name: Messages.lostLuggageTitle,image: Messages.lostLuggageIcon)]))
        
        sideMenuArray.append(sectionStruct(sectionName: "Know Us",rowArray: [rowSideMenuStruct(name: Messages.help,image: Messages.helpIcon),rowSideMenuStruct(name: Messages.aboutUs,image: Messages.aboutUsIcon),rowSideMenuStruct(name: Messages.contactUs,image: Messages.contactUsIcon)]))
    }
    
    func configureView(){
       addHomeVC()
    }
    
    private lazy var HomeVCiPads: HomeViewController = {
        let storyBoard : UIStoryboard = UIStoryboard(name: Storyboards.HomeiPadStoryboard, bundle:nil)
        var viewController = storyBoard.instantiateViewController(withIdentifier: ViewControllers.HomeViewController) as! HomeViewController
        self.add(asChildViewController: viewController)
        return viewController
    }()
    
    private lazy var MyIssuesVCiPad: IssueListingViewController = {
        let storyBoard : UIStoryboard = UIStoryboard(name: Storyboards.IssueListiPadStoryboard, bundle:nil)
        let viewController = storyBoard.instantiateViewController(withIdentifier: ViewControllers.IssueListingViewController) as! IssueListingViewController
        self.add(asChildViewController: viewController)
        return viewController
    }()
    
    private lazy var MyTripsVCiPad: MyTripViewController = {
        let storyBoard : UIStoryboard = UIStoryboard(name: Storyboards.MyTripipadStoryboard, bundle:nil)
        let viewController = storyBoard.instantiateViewController(withIdentifier: ViewControllers.MyTripViewController) as! MyTripViewController
        self.add(asChildViewController: viewController)
        return viewController
    }()
    
    private lazy var ProfileVCiPad: ProfileViewController = {
       // ViewManager.shared.isCreateAccountFromTabBar = false
        let storyBoard : UIStoryboard = UIStoryboard(name: Storyboards.CreateAccountIpadStoryboard, bundle:nil)
        let viewController = storyBoard.instantiateViewController(withIdentifier: ViewControllers.ProfileViewController) as! ProfileViewController
        self.add(asChildViewController: viewController)
        return viewController
    }()
    
    private lazy var FlightCancelVCiPad: FlightCancellationViewController = {
        let storyBoard : UIStoryboard = UIStoryboard(name: Storyboards.FlightCancellationiPadStoryboard, bundle:nil)
        let viewController = storyBoard.instantiateViewController(withIdentifier: ViewControllers.FlightCancellationViewController) as! FlightCancellationViewController
        self.add(asChildViewController: viewController)
        return viewController
    }()
    
    private lazy var FlightDelayVCiPad: FlightDelayViewController = {
        let storyBoard : UIStoryboard = UIStoryboard(name: Storyboards.FlightDelayiPadStoryboard, bundle:nil)
        let viewController = storyBoard.instantiateViewController(withIdentifier: ViewControllers.FlightDelayViewController) as! FlightDelayViewController
        self.add(asChildViewController: viewController)
        return viewController
    }()
    
    private lazy var LostLuggageVCiPad: LostBaggageViewController = {
        let storyBoard : UIStoryboard = UIStoryboard(name: Storyboards.LostBaggageiPadStoryboard, bundle:nil)
        let viewController = storyBoard.instantiateViewController(withIdentifier: ViewControllers.LostBaggageViewController) as! LostBaggageViewController
        self.add(asChildViewController: viewController)
        return viewController
    }()
    
    private lazy var AboutUsVCiPad: AboutUsViewController = {
        let storyBoard : UIStoryboard = UIStoryboard(name: Storyboards.AboutUsiPadStoryboard, bundle:nil)
        let viewController = storyBoard.instantiateViewController(withIdentifier: ViewControllers.AboutUsViewController) as! AboutUsViewController
        self.add(asChildViewController: viewController)
        return viewController
    }()
    
    private lazy var ContactUsVCiPad: ContactUsViewController = {
        let storyBoard : UIStoryboard = UIStoryboard(name: Storyboards.ContactUsiPadStoryboard, bundle:nil)
        let viewController = storyBoard.instantiateViewController(withIdentifier: ViewControllers.ContactUsViewController) as! ContactUsViewController
        self.add(asChildViewController: viewController)
        return viewController
    }()
    
    
    func showOnboardingScreeniPad(){
        let storyboard = UIStoryboard(name: Storyboards.OnboardingiPadStoryboard, bundle:nil)
        let onboardingVC = storyboard.instantiateViewController(withIdentifier: ViewControllers.OnboardingViewController) as! OnboardingViewController
        onboardingVC.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(onboardingVC, animated: true)
    }
    
    private lazy var PersonalInfosiPad: PersonalInfoViewController = {
    let storyID = UIStoryboard(name: Storyboards.CreateAccountIpadStoryboard, bundle:nil)
    let viewController = storyID.instantiateViewController(withIdentifier: ViewControllers.PersonalInfoViewController) as! PersonalInfoViewController
        self.add(asChildViewController: viewController)
        return viewController
    }()
    

    func addHomeVC(){
        remove(asChildViewController: MyTripsVCiPad)
        remove(asChildViewController: ProfileVCiPad)
        remove(asChildViewController: ContactUsVCiPad)
        remove(asChildViewController: AboutUsVCiPad)
        remove(asChildViewController: LostLuggageVCiPad)
        remove(asChildViewController: FlightDelayVCiPad)
        remove(asChildViewController: FlightCancelVCiPad)
        remove(asChildViewController: MyIssuesVCiPad)
        add(asChildViewController: HomeVCiPads)
    }
    
    func addMyIssuesVC(){
        remove(asChildViewController: MyTripsVCiPad)
        remove(asChildViewController: ProfileVCiPad)
        remove(asChildViewController: ContactUsVCiPad)
        remove(asChildViewController: AboutUsVCiPad)
        remove(asChildViewController: LostLuggageVCiPad)
        remove(asChildViewController: FlightDelayVCiPad)
        remove(asChildViewController: FlightCancelVCiPad)
        remove(asChildViewController: HomeVCiPads)
        add(asChildViewController: MyIssuesVCiPad)
    }
    
    func addMyTripsVC(){
        remove(asChildViewController: PersonalInfosiPad)
        remove(asChildViewController: ContactUsVCiPad)
        remove(asChildViewController: AboutUsVCiPad)
        remove(asChildViewController: LostLuggageVCiPad)
        remove(asChildViewController: FlightDelayVCiPad)
        remove(asChildViewController: FlightCancelVCiPad)
        remove(asChildViewController: HomeVCiPads)
        remove(asChildViewController: MyIssuesVCiPad)
        add(asChildViewController: MyTripsVCiPad)
    }
    
    func addMyProfileVC(){
        VIEWMANAGER.isFromLoginBtn =  true
        remove(asChildViewController: MyTripsVCiPad)
        remove(asChildViewController: MyIssuesVCiPad)
        remove(asChildViewController: ContactUsVCiPad)
        remove(asChildViewController: AboutUsVCiPad)
        remove(asChildViewController: LostLuggageVCiPad)
        remove(asChildViewController: FlightDelayVCiPad)
        remove(asChildViewController: FlightCancelVCiPad)
        remove(asChildViewController: HomeVCiPads)
        add(asChildViewController: PersonalInfosiPad)
    }
    
    func addFlightCancelVC(){
        remove(asChildViewController: MyTripsVCiPad)
        remove(asChildViewController: PersonalInfosiPad)
        remove(asChildViewController: ContactUsVCiPad)
        remove(asChildViewController: AboutUsVCiPad)
        remove(asChildViewController: LostLuggageVCiPad)
        remove(asChildViewController: FlightDelayVCiPad)
        remove(asChildViewController: FlightCancelVCiPad)
        remove(asChildViewController: HomeVCiPads)
        add(asChildViewController: FlightCancelVCiPad)
    }
    
    func addMyLostLauuageVC(){
        remove(asChildViewController: MyTripsVCiPad)
        remove(asChildViewController: PersonalInfosiPad)
        remove(asChildViewController: ContactUsVCiPad)
        remove(asChildViewController: AboutUsVCiPad)
        remove(asChildViewController: FlightDelayVCiPad)
        remove(asChildViewController: MyIssuesVCiPad)
        remove(asChildViewController: FlightCancelVCiPad)
        remove(asChildViewController: HomeVCiPads)
        add(asChildViewController: LostLuggageVCiPad)
    }
    
    func addFlightDelayVC(){
        remove(asChildViewController: MyTripsVCiPad)
        remove(asChildViewController: PersonalInfosiPad)
        remove(asChildViewController: ContactUsVCiPad)
        remove(asChildViewController: AboutUsVCiPad)
        remove(asChildViewController: LostLuggageVCiPad)
        remove(asChildViewController: MyIssuesVCiPad)
        remove(asChildViewController: FlightCancelVCiPad)
        remove(asChildViewController: HomeVCiPads)
        add(asChildViewController: FlightDelayVCiPad)
    }
    
    func addAboutUsVC(){
        remove(asChildViewController: MyTripsVCiPad)
        remove(asChildViewController: PersonalInfosiPad)
        remove(asChildViewController: ContactUsVCiPad)
        remove(asChildViewController: AboutUsVCiPad)
        remove(asChildViewController: MyIssuesVCiPad)
        remove(asChildViewController: LostLuggageVCiPad)
        remove(asChildViewController: FlightCancelVCiPad)
        remove(asChildViewController: HomeVCiPads)
        add(asChildViewController: AboutUsVCiPad)
    }
    
    func addContactUsUsVC(){
        remove(asChildViewController: MyTripsVCiPad)
        remove(asChildViewController: PersonalInfosiPad)
        remove(asChildViewController: FlightDelayVCiPad)
        remove(asChildViewController: AboutUsVCiPad)
        remove(asChildViewController: MyIssuesVCiPad)
        remove(asChildViewController: LostLuggageVCiPad)
        remove(asChildViewController: FlightCancelVCiPad)
        remove(asChildViewController: HomeVCiPads)
        add(asChildViewController: ContactUsVCiPad)
    }
   
    
    //MARK: - Required Functions
    private func add(asChildViewController viewController: UIViewController) {
        // Add Child View Controller
        addChild(viewController)
        // Add Child View as Subview
        container1.addSubview(viewController.view)
        viewController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            viewController.view.leadingAnchor.constraint(equalTo: container1.leadingAnchor),
            viewController.view.trailingAnchor.constraint(equalTo: container1.trailingAnchor),
            viewController.view.topAnchor.constraint(equalTo: container1.topAnchor),
            viewController.view.bottomAnchor.constraint(equalTo: container1.bottomAnchor)
        ])
        viewController.view.frame = view.bounds
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        viewController.didMove(toParent: self)
    }

    private func remove(asChildViewController viewController: UIViewController) {
        viewController.willMove(toParent: nil)
        viewController.view.removeFromSuperview()
        viewController.removeFromParent()
    }

}


extension MainiPadContainerViewController : UITableViewDataSource, UITableViewDelegate{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sideMenuArray.count
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let myView = UIView()
        myView.backgroundColor = UIColor.clear
        
        let label = UILabel()
        label.text = sideMenuArray[section].sectionName
        label.textColor = UIColor().hexStringToUIColor(hex: AppColor.sideMenuSelectedTextColor)
        label.font = UIFont(name: Fonts.SFProTextSemiBold, size: 18.0)
        label.frame = CGRect(x: 60, y: 15, width: iPadSideMenuTableView.frame.size.width - 25, height: 15)
        myView.addSubview(label)
       
        return myView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50.0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sideMenuArray[section].rowArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.iPadSideMenuTableView.dequeueReusableCell(withIdentifier: Cells.iPadSideMenuTableViewCell, for: indexPath) as! iPadSideMenuTableViewCell
        
        let name = sideMenuArray[indexPath.section].rowArray[indexPath.row].name
        
        cell.iconImageView.image = UIImage(named: sideMenuArray[indexPath.section].rowArray[indexPath.row].image)
        cell.sideMenuNameLabel.text = name
       
        if MainiPadContainerViewController.selectedSideMenu == name{
            cell.sideMenuNameLabel.textColor = UIColor().hexStringToUIColor(hex: AppColor.blueColor)
            cell.baseView.backgroundColor = UIColor().hexStringToUIColor(hex: AppColor.backgroundLightBlueColor)
            //cell.iconImageView.setImageColor(color: UIColor().hexStringToUIColor(hex: AppColor.blueColor))
        }else{
            cell.sideMenuNameLabel.textColor = UIColor().hexStringToUIColor(hex: AppColor.darkGreyColor)
            cell.baseView.backgroundColor = .clear
            //cell.iconImageView.setImageColor(color: UIColor().hexStringToUIColor(hex: AppColor.darkGreyColor))
        }

        return cell
    }
     
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        MainiPadContainerViewController.selectedSideMenu = sideMenuArray[indexPath.section].rowArray[indexPath.row].name
        iPadSideMenuTableView.reloadData()
        
        switch MainiPadContainerViewController.selectedSideMenu {
        case Messages.homeTitle:
            addHomeVC()
        case Messages.myIssuesTitle:
            addMyIssuesVC()
        case Messages.myTripsTitle:
            addMyTripsVC()
        case Messages.profileTitle:
            addMyProfileVC()
        case Messages.cancelledFlightTitle:
            addFlightCancelVC()
        case Messages.lateFlightTitle:
            addFlightDelayVC()
        case Messages.lostLuggageTitle:
            addMyLostLauuageVC()
        case Messages.help:
            showOnboardingScreeniPad()
        case Messages.aboutUs:
            addAboutUsVC()
        case Messages.contactUs:
            addContactUsUsVC()
        default:
            print("defalut")
        }
    }
    
    
}


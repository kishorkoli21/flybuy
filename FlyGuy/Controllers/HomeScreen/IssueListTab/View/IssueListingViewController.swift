//
//  IssueListingViewController.swift
//  FlyGuy
//
//  Created by Mac on 16/03/23.
//

import UIKit

class IssueListingViewController: BaseViewController {

    @IBOutlet weak var issueListingTableView: UITableView!
    @IBOutlet weak var issueListingLabel: UILabel!
    @IBOutlet weak var lblNoIssues: UILabel!
    
    
    let databaseInstance = bt_database.instance
    var issuesList = [ReportIncidentStruct]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getAllIssuesList()
        if Constants.deviceType == DeviceType.iPhone.rawValue{
            setUpInitialView()
        }else{
            setUpIpadTabelViewCell()
        }
    }
    
    //MARK: - Database Functions
    func getAllIssuesList(){
        issuesList = databaseInstance.getReportIncidentFromDb()
        if issuesList.count == 0{
            issueListingTableView.isHidden = true
        }
        DispatchQueue.main.async {
            self.issueListingTableView.reloadData()
        }
    }
    
    func setUpInitialView(){
        issueListingLabel.text = Messages.issueListingTitle
        self.issueListingTableView.register(UINib.init(nibName: Cells.IssueListingTableViewCell, bundle: nil), forCellReuseIdentifier: Cells.IssueListingTableViewCell)
    }
    
    func setUpIpadTabelViewCell(){
        self.issueListingTableView.register(UINib.init(nibName: Cells.IssueListingiPadTableViewCell, bundle: nil), forCellReuseIdentifier: Cells.IssueListingiPadTableViewCell)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.statusBarBackgroundColor(colorHex: AppColor.statusBarColor)
    }

}

extension IssueListingViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return dataArray.count
        return issuesList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if Constants.deviceType == DeviceType.iPad.rawValue{
            let cell = self.issueListingTableView.dequeueReusableCell(withIdentifier: Cells.IssueListingiPadTableViewCell, for: indexPath) as! IssueListingiPadTableViewCell
            
            var name = issuesList[indexPath.row].issueName
            
            switch name{
            case IncidentTypeEnum.CancelledFlight.rawValue:
                name = Messages.cancelledFlightTitle
                cell.reportedOnView.isHidden = false
                cell.flightNumberView.isHidden = false
                cell.latenessView.isHidden = true
                cell.issueImageView.image = UIImage(named: Images.MyIssuesCancelFlightIcon)
            case IncidentTypeEnum.Baggage.rawValue:
                name = Messages.lostLuggageTitle
                cell.reportedOnView.isHidden = false
                cell.flightNumberView.isHidden = false
                cell.latenessView.isHidden = true
                cell.issueImageView.image = UIImage(named: Images.MyIssuesLostbaggageIcon)
            case IncidentTypeEnum.LateFlight.rawValue:
                name = Messages.delayFlightTitle
                cell.reportedOnView.isHidden = false
                cell.flightNumberView.isHidden = false
                cell.latenessView.isHidden = false
                cell.issueImageView.image = UIImage(named: Images.MyIssuesDelayFlightIcon)
            default :
                print(Messages.noDataFound)
            }
            
            cell.issueNameLabel.text = name
            cell.reportedOnDateLabel.text = issuesList[indexPath.row].reportedOnDate
            cell.flightNumberLabel.text = issuesList[indexPath.row].flightNumber
            cell.latnessLabel.text = issuesList[indexPath.row].lateness
            
            return cell
        }else{
            let cell = self.issueListingTableView.dequeueReusableCell(withIdentifier: Cells.IssueListingTableViewCell, for: indexPath) as! IssueListingTableViewCell
            
            var name = issuesList[indexPath.row].issueName
            
            print("name is",name)
            
            switch name{
            case Messages.cancelledFlightTitle:
                name = Messages.cancelledFlightTitle
                cell.reportedOnView.isHidden = false
                cell.flightNumberView.isHidden = false
                cell.latenessView.isHidden = true
                cell.issueImageView.image = UIImage(named: Images.MyIssuesCancelFlightIcon)
            case Messages.lostLuggageTitle:
                name = Messages.lostLuggageTitle
                cell.reportedOnView.isHidden = false
                cell.flightNumberView.isHidden = false
                cell.latenessView.isHidden = true
                cell.issueImageView.image = UIImage(named: Images.MyIssuesLostbaggageIcon)
            case Messages.delayFlightTitle:
                name = Messages.delayFlightTitle
                cell.reportedOnView.isHidden = false
                cell.flightNumberView.isHidden = false
                cell.latenessView.isHidden = false
                cell.issueImageView.image = UIImage(named: Images.MyIssuesDelayFlightIcon)
            default :
                print(Messages.noDataFound)
            }
            
            cell.issueNameLabel.text = name
            cell.reportedOnDateLabel.text = issuesList[indexPath.row].reportedOnDate
            cell.flightNumberLabel.text = issuesList[indexPath.row].flightNumber
            cell.latnessLabel.text = issuesList[indexPath.row].lateness
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}

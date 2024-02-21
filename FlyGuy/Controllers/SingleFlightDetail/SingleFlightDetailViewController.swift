//
//  SingleFlightDetailViewController.swift
//  FlyGuy
//
//  Created by Springup Labs on 18/05/23.
//

import UIKit

class SingleFlightDetailViewController: BaseViewController {

    
    @IBOutlet weak var BGDownload: UIView!
    @IBOutlet weak var BGShare: UIView!
    @IBOutlet weak var BGModify: UIView!
    @IBOutlet weak var BGCancel: UIView!
    @IBOutlet weak var tblView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        BGDownload.addShadowForCell()
        BGShare.addShadowForCell()
        BGModify.addShadowForCell()
        BGCancel.addShadowForCell()
        
        if Constants.deviceType == DeviceType.iPhone.rawValue{
            tblView.register(UINib(nibName: "FlightBookingDetailsCell", bundle: nil), forCellReuseIdentifier: "FlightBookingDetailsCell")
        }else{
            tblView.register(UINib(nibName: "FlightBookingDetailsIpadCell", bundle: nil), forCellReuseIdentifier: "FlightBookingDetailsIpadCell")
        }
    }
    
    
    @IBAction func btnDownloadClicked(_ sender: Any) {
    }
    
    @IBAction func btnShareClicked(_ sender: Any) {
    }
    
    
    @IBAction func btnModifyClicked(_ sender: Any) {
    }
    
    
    @IBAction func btnCancelClicked(_ sender: Any) {
    }
    
}

//extension SingleFlightDetailViewController : UITableViewDataSource, UITableViewDelegate{
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 5
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        if Constants.deviceType == DeviceType.iPhone.rawValue{
//            let cell = tableView.dequeueReusableCell(withIdentifier: "FlightBookingDetailsCell") as! FlightBookingDetailsCell
//            return cell
//        }else{
//            let cell = tableView.dequeueReusableCell(withIdentifier: "FlightBookingDetailsIpadCell") as! FlightBookingDetailsIpadCell
//            return cell
//        }
//        return UITableViewCell()
//    }
//
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
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        if Constants.deviceType == DeviceType.iPhone.rawValue{
//            return 50
//        }else{
//            return 60
//
//        }
//    }
    
//}

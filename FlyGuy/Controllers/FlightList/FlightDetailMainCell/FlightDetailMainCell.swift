//
//  FlightDetailMainCell.swift
//  FlyGuy
//
//  Created by Springup Labs on 11/05/23.
//

import UIKit

class FlightDetailMainCell: UITableViewCell {

    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var tblViewHeightConstraint: NSLayoutConstraint!
   
    var arrDownloadList : String = "sanjana"{
        didSet {
            DispatchQueue.main.async {
                self.tblView.reloadData()
            }
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        tblView.register(UINib(nibName: "FlightDetailsCell", bundle: nil), forCellReuseIdentifier: "FlightDetailsCell")
        tblView.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)
        tblView.dataSource = self
        tblView.delegate = self
        tblView.isScrollEnabled = false
    }


    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        tblViewHeightConstraint.constant = tblView.contentSize.height
    }
  
}

extension FlightDetailMainCell : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FlightDetailsCell") as! FlightDetailsCell
        if indexPath.row == 2{
            cell.layoverView.isHidden = true
        }else{
            cell.layoverView.isHidden = false
        }
        return cell
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let customView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 70))
        customView.backgroundColor = UIColor.white
        customView.layer.cornerRadius = 10
        customView.addShadow()
        let titleLabel = UILabel(frame: CGRect(x:customView.frame.midX - 60,y: customView.frame.midY - 20 ,width:70,height:30))
        titleLabel.backgroundColor = UIColor.clear
        titleLabel.textColor = .black
        titleLabel.font = .boldSystemFont(ofSize: 22)
        titleLabel.text  = "Price"
        customView.addSubview(titleLabel)
        let titleLabel2 = UILabel(frame: CGRect(x:customView.frame.midX + 10 ,y: customView.frame.midY - 20  ,width:120,height:30))
        titleLabel2.backgroundColor = UIColor.clear
        titleLabel2.textColor = UIColor(red: 0.318, green: 0.396, blue: 0.722, alpha: 1)
        titleLabel2.font = .boldSystemFont(ofSize: 28)
        titleLabel2.text  = "$420"
        customView.addSubview(titleLabel2)
        tableView.tableFooterView = customView
        return customView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat.leastNonzeroMagnitude
    }
 
    
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 70
//
//    }
//
//
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let customView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 70))
//        customView.backgroundColor = UIColor.white
//        customView.layer.cornerRadius = 10
//        customView.addShadowForCell()
//        let titleLabel = UILabel(frame: CGRect(x:customView.frame.midX - 100,y: customView.frame.midY - 18 ,width:200,height:30))
//        titleLabel.backgroundColor = UIColor.clear
//        titleLabel.textColor = .black
//        titleLabel.font = .boldSystemFont(ofSize: 18)
//        titleLabel.text  = "3h 55m Layover"
//        titleLabel.textAlignment =  .center
//        customView.addSubview(titleLabel)
//        return customView
//    }
   
}

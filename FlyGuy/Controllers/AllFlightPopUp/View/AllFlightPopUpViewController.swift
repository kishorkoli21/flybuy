//
//  AllFlightPopUpViewController.swift
//  FlyGuy
//
//  Created by Mac on 30/03/23.
//

import UIKit

protocol AllFlightPopUpProtocol {
    var controller: AllFlightPopUpViewController { get }
}

class AllFlightPopUpViewController: BaseViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var allFlightBackView: UIView!
    @IBOutlet weak var allAirLineListTableView: UITableView!
    @IBOutlet weak var infoMessageLabel: UILabel!
    
    var titleText = ""
    var viewModel = AllFlightPopUpViewModel()
    var callBackLogout: ((_ submit: Bool) -> Void)?
   
    override func viewDidLoad() {
        super.viewDidLoad()
        if Constants.deviceType == DeviceType.iPhone.rawValue{
            titleLabel.text = titleText
        }
        configure()
        setUpTableView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
    }
    
    // MARK: Initial Setup Methods
    
    func setUpTableView(){
        if #available(iOS 15.0, *){
            self.allAirLineListTableView.sectionHeaderTopPadding = 0.0
        }
        self.allAirLineListTableView.register(UINib.init(nibName: Cells.AllFlightPopUpTableViewCell, bundle: nil), forCellReuseIdentifier: Cells.AllFlightPopUpTableViewCell)
    }
    
    // MARK: Api Configuration Methods
    
    func configure(){
        viewModel.view = self
        viewModel.getAirlineCodeList()
    }
    
    // MARK: Button Action Methods
    
    @IBAction func closeButtonClicked(_ sender: UIButton) {
        DispatchQueue.main.asyncAfter(deadline: .now()){
            self.callBackLogout?(true)
        }
        self.dismiss(animated: true)
    }
    
}


extension AllFlightPopUpViewController : UITableViewDelegate, UITableViewDataSource{
    
    // MARK: TableView Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.airlineCodeList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.allAirLineListTableView.dequeueReusableCell(withIdentifier: Cells.AllFlightPopUpTableViewCell, for: indexPath) as! AllFlightPopUpTableViewCell
        
        let airlineCode = viewModel.airlineCodeList?[indexPath.row].iata ?? ""
        let airlineName = viewModel.airlineCodeList?[indexPath.row].airlineName ?? ""
        
        cell.airLineNameLabel.text = "\(airlineCode) - \(airlineName)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}


extension AllFlightPopUpViewController: AllFlightPopUpProtocol {
    var controller: AllFlightPopUpViewController {
        self
    }
}

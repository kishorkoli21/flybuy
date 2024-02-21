//
//  FlightDetailsCell.swift
//  FlyGuy
//
//  Created by Springup Labs on 08/05/23.
//

import UIKit

class FlightDetailsCell: UITableViewCell {

    
    @IBOutlet weak var BGView: UIView!
    @IBOutlet weak var layoverView: UIView!
    @IBOutlet weak var lblFlightName: UILabel!
    @IBOutlet weak var lblOriginTime: UILabel!
    @IBOutlet weak var lblOriginDate: UILabel!
    @IBOutlet weak var lblOrigin: UILabel!
    @IBOutlet weak var lblOriginCode: UILabel!
    @IBOutlet weak var lblFlightTime: UILabel!
    @IBOutlet weak var lblDepartureTime: UILabel!
    @IBOutlet weak var lblDepartureDate: UILabel!
    @IBOutlet weak var lblDeparture: UILabel!
    @IBOutlet weak var lblDepartureCode: UILabel!
    @IBOutlet weak var lblSeat: UILabel!
    @IBOutlet weak var lblLayoverView: UIView!
    @IBOutlet weak var lblLayOverTime: UILabel!
    @IBOutlet weak var lblFlightNumber: UILabel!
    @IBOutlet weak var lblCabinBaggage: UILabel!
    @IBOutlet weak var lblCheckInBaggage: UILabel!
    
   
    var arrCityList : [String]? = []

    
    override func awakeFromNib() {
        super.awakeFromNib()
        BGView.addShadow()
    }

    
    func setUpCellData(model: OriginDestinationOptionOriginDestinationOption){
        
      
        
        let getReachingTime = self.getDateAndTime(complexDate: model.flightSegment?.departureDateTime ?? "")
        lblOriginTime.text = getReachingTime.resultTime
        lblOriginDate.text = getReachingTime.resultDate
       // self.getDate(complexDate: model.flightSegment?.departureDateTime ?? "")
        let getDestinationTime = self.getDateAndTime(complexDate: model.flightSegment?.arrivalDateTime ?? "")
        lblDepartureTime.text = getDestinationTime.resultTime
        lblDepartureDate.text = getDestinationTime.resultDate
        
        let journeyTime =  Int(model.flightSegment?.journeyDuration ?? "") ?? 0
        lblFlightTime.text = self.calculateTime(journeyTime)
        
        lblFlightName.text = model.flightSegment?.marketingAirlineName
        lblSeat.text = model.flightSegment?.cabinClassText
        lblFlightNumber.text = "(\(model.flightSegment?.marketingAirlineCode ?? "")\(model.flightSegment?.flightNumber ?? ""))"
        
    }
    
    func getDateAndTime(complexDate: String) -> (resultDate: String, resultTime: String){
        let formatter = DateFormatter()
        let tempLocale = formatter.locale
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        let date = formatter.date(from: complexDate)
        formatter.locale = tempLocale
        formatter.dateFormat = "HH:mm"
        let strTime = formatter.string(from: date!)
        formatter.dateFormat = "yyyy-MM-dd"
        let strDate = formatter.string(from: date!)
        return (strDate, strTime)
    }
    
    func calculateTime(_ timeValue: Int) -> String {
        let hours = timeValue / 60
        let minutes = timeValue % 60
        return "\(hours) h \(minutes) min"
    }
    
    func getDate(complexDate: String){
        let dateFormatter = DateFormatter()
        let tempLocale = dateFormatter.locale // save locale temporarily
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        let date = dateFormatter.date(from: complexDate)!
        dateFormatter.dateFormat = "dd-MM-yyyy HH:mm:ss"
        dateFormatter.locale = tempLocale // reset the locale
        let dateString = dateFormatter.string(from: date)
        print("EXACT_DATE : \(dateString)")
    }

    
}

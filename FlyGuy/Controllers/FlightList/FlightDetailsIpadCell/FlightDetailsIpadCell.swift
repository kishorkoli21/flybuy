//
//  FlightDetailsCell.swift
//  FlyGuy
//
//  Created by Springup Labs on 08/05/23.
//

import UIKit

class FlightDetailsIpadCell: UITableViewCell {

    
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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        BGView.addShadow()
    }

    
    func setUpCellData(model: OriginDestinationOptionOriginDestinationOption){
//        lblOrigin.text = model.flightSegment?.departureAirportLocationCode
//        lblDeparture.text = model.flightSegment?.arrivalAirportLocationCode
        
        let getReachingTime = self.getDateAndTime(complexDate: model.flightSegment?.departureDateTime ?? "")
        lblOriginTime.text = getReachingTime.resultTime
        lblOriginDate.text = getReachingTime.resultDate
        
        let getDestinationTime = self.getDateAndTime(complexDate: model.flightSegment?.arrivalDateTime ?? "")
        lblDepartureTime.text = getDestinationTime.resultTime
        lblDepartureDate.text = getDestinationTime.resultDate
        
        let journeyTime : Int = Int(model.flightSegment?.journeyDuration ?? "") ?? 0
        lblFlightTime.text = self.calculateTime(journeyTime)
        
        lblFlightName.text = model.flightSegment?.marketingAirlineName
        lblSeat.text = model.flightSegment?.cabinClassText
        lblFlightNumber.text = "(\(model.flightSegment?.marketingAirlineCode ?? "")\(model.flightSegment?.flightNumber ?? ""))"
        
    }
    
    func getDateAndTime(complexDate: String) -> (resultDate: String, resultTime: String){
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        let date = formatter.date(from: complexDate)
        formatter.dateFormat = "HH:mm"
        let strTime = formatter.string(from: date ?? Date())
        formatter.dateFormat = "yyyy-MM-dd"
        let strDate = formatter.string(from: date ?? Date())
        return (strDate, strTime)
    }
    
    func calculateTime(_ timeValue: Int) -> String {
        let hours = timeValue / 60
        let minutes = timeValue % 60
        return "\(hours) h \(minutes) min"
    }
    
}

//
//  FlightBookingFlightInfoCell.swift
//  FlyGuy
//
//  Created by Springup Labs on 07/06/23.
//

import UIKit

class FlightBookingFlightInfoCell: UITableViewCell {

   
    @IBOutlet weak var lblFlightNumber: UILabel!
    @IBOutlet weak var lblCabinClass: UILabel!
    @IBOutlet weak var lblArrivalDate: UILabel!
    @IBOutlet weak var lblArrivalTime: UILabel!
    @IBOutlet weak var lblDepartureDate: UILabel!
    @IBOutlet weak var lblDepartureTime: UILabel!
    @IBOutlet weak var lblFlightDuration: UILabel!
    @IBOutlet weak var lblTicketNumber: UILabel!
    @IBOutlet weak var lblOriginCode: UILabel!
    @IBOutlet weak var lblOriginCity: UILabel!
    @IBOutlet weak var lblDestinationCode: UILabel!
    @IBOutlet weak var lblDestinationCity: UILabel!
    
    var travelCities : (String, String) = ("", "")
    var airLineCityList : [ResultCityList]?

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setUpData(model: ReservationItemElement){
        lblFlightNumber.text = "\(model.reservationItem?.marketingAirlineCode ?? "")-\(model.reservationItem?.flightNumber ?? "")"
        lblCabinClass.text = model.reservationItem?.cabinClassText
        let arrivalDateTime = getDateTime(jorneyDateTime: model.reservationItem?.arrivalDateTime ?? "")
        lblArrivalDate.text = arrivalDateTime.0
        lblArrivalTime.text = arrivalDateTime.1
        let departDateTime = getDateTime(jorneyDateTime: model.reservationItem?.departureDateTime ?? "")
        lblDepartureDate.text = departDateTime.0
        lblDepartureTime.text = departDateTime.1
        lblTicketNumber.text = model.reservationItem?.baggage
        let totTime = Int(model.reservationItem?.journeyDuration ?? "0")
        lblFlightDuration.text = self.calculateTime(totTime ?? 0)
        lblOriginCode.text = model.reservationItem?.departureAirportLocationCode
        lblDestinationCode.text = model.reservationItem?.arrivalAirportLocationCode
        lblOriginCity.text = travelCities.0
        lblDestinationCity.text = travelCities.1
     
    }
    
    func getDateTime(jorneyDateTime : String) -> (String,String) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        let date = formatter.date(from: jorneyDateTime) ?? Date()
        formatter.dateFormat = "dd-MMM-yyyy"
        let jorneyDate = formatter.string(from: date)
        formatter.dateFormat = "hh:mm a"
        let journeytime = formatter.string(from: date)
        return (jorneyDate, journeytime)
    }
    
    func calculateTime(_ timeValue: Int) -> String {
        let hours = timeValue / 60
        let minutes = timeValue % 60
        return "\(hours) h \(minutes) min"
    }
    
}


//if airLineCityList?.count != 0{
//    if let airLineCityList = airLineCityList {
//        let filteredAirports = airLineCityList.filter { airport in
//            if let airportCode = airport.airportCode {
//                if airportCode == model.reservationItem?.departureAirportLocationCode{
//                    lblOriginCode.text = airport.city
//                }
//                if airportCode == model.reservationItem?.arrivalAirportLocationCode{
//                    lblDestinationCode.text = airport.city
//                }
//            }
//            return false
//        }
//        
//        print(filteredAirports)
//    }
//}

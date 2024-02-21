//
//  FlightListCellTableViewCell.swift
//  FlyGuy
//
//  Created by Springup Labs on 02/05/23.
//

import UIKit

class FlightListCellTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var lblOffer: UILabel!
    @IBOutlet weak var btnSelect: UIButton!
    @IBOutlet weak var viewOffer: UIView!
    @IBOutlet weak var lblOriginTime: UILabel!
    @IBOutlet weak var lblDestinationTime: UILabel!
    @IBOutlet weak var lblOrigin: UILabel!
    @IBOutlet weak var lblDestination: UILabel!
    @IBOutlet weak var lblJourneyTime: UILabel!
    @IBOutlet weak var lblStops: UILabel!
    @IBOutlet weak var ImgAirplaneCompanyIcon: UIImageView!
    @IBOutlet weak var lblAirlines: UILabel!
    @IBOutlet weak var lblFlightNumber: UILabel!
    @IBOutlet weak var lblTicketPrice: UILabel!
    @IBOutlet weak var lblSeatsAvailable: UILabel!
    @IBOutlet weak var lblLcc: UILabel!
    
    var indexPath : IndexPath?
    var flightDetails = [Result]()
    var shareClosure : (() -> ())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setUpData(flightDetails: Result, isReturn: Bool = false){
        let model = flightDetails
        var originDestinationOptionsModel = FareItineraryOriginDestinationOption()
        
        if model.fareItinerary?.airItineraryFareInfo?.fareType == "WebFare"{
            self.lblLcc.text = "LCC"
        }else{
            self.lblLcc.text = "Non-LCC"
        }
        
        if let value = model.fareItinerary?.originDestinationOptions?[isReturn ? 1 : 0]{
            originDestinationOptionsModel = value
        }
        
        if originDestinationOptionsModel.totalStops ?? 0 > 0{
            lblStops.text = "\(originDestinationOptionsModel.totalStops ?? 0) stop"
            
            let firstStartArr = originDestinationOptionsModel.originDestinationOption?[0]
            let getTime = self.getDateAndTime(complexDate: firstStartArr?.flightSegment?.departureDateTime ?? "")
            //            lblDestination.text = firstStartArr?.flightSegment?.departureAirportLocationCode
            //            lblDestinationTime.text = getTime.resultTime
            
            lblOrigin.text = firstStartArr?.flightSegment?.departureAirportLocationCode
            lblOriginTime.text = getTime.resultTime
            
            lblSeatsAvailable.text = "\(firstStartArr?.seatsRemaining?.number ?? 0)"
            
            let lastStopArr = originDestinationOptionsModel.originDestinationOption?[originDestinationOptionsModel.totalStops ?? 0]
            let getReachingTime = self.getDateAndTime(complexDate: lastStopArr?.flightSegment?.arrivalDateTime ?? "")
            //            lblOriginTime.text = getReachingTime.resultTime
            //            lblOrigin.text = lastStopArr?.flightSegment?.arrivalAirportLocationCode
            
            lblDestinationTime.text = getReachingTime.resultTime
            lblDestination.text = lastStopArr?.flightSegment?.arrivalAirportLocationCode
            print("destination Time \(getReachingTime)")
            print("Arrival Time \(getTime)")
            
            lblAirlines.text = lastStopArr?.flightSegment?.marketingAirlineName
            lblFlightNumber.text = "\(lastStopArr?.flightSegment?.marketingAirlineCode ?? "")\(lastStopArr?.flightSegment?.flightNumber ?? "")"
            
            let currencyModel = model.fareItinerary?.airItineraryFareInfo?.itinTotalFares
            if currencyModel?.totalFare?.currencyCode == "USD"{
                lblTicketPrice.text = "$\(currencyModel?.totalFare?.amount ?? "-")"
            }else{
                lblTicketPrice.text = currencyModel?.totalFare?.amount
            }
            
            var journeyTotalTime : Int = 0
            if let arr = originDestinationOptionsModel.originDestinationOption{
                for value in arr  {
                    journeyTotalTime = journeyTotalTime + (Int(value.flightSegment?.journeyDuration ?? "") ?? 0)
                }
                lblJourneyTime.text = self.calculateTime(journeyTotalTime)
            }
        }else{
            lblStops.text = "No stop"
            //[isReturn ? 1 : 0]
            
            let firstStartArr = originDestinationOptionsModel.originDestinationOption?[0]
            let getTime = self.getDateAndTime(complexDate: firstStartArr?.flightSegment?.departureDateTime ?? "")
            
            //            lblDestination.text = firstStartArr?.flightSegment?.departureAirportLocationCode
            //            lblDestinationTime.text = getTime.resultTime
            
            lblOrigin.text = firstStartArr?.flightSegment?.departureAirportLocationCode
            lblOriginTime.text = getTime.resultTime
            
            let getReachingTime = self.getDateAndTime(complexDate: firstStartArr?.flightSegment?.arrivalDateTime ?? "")
            //            lblDestinationTime.text = getReachingTime.resultTime
            //            lblOrigin.text = firstStartArr?.flightSegment?.arrivalAirportLocationCode
            
            lblDestinationTime.text = getReachingTime.resultTime
            lblDestination.text = firstStartArr?.flightSegment?.arrivalAirportLocationCode
            
            lblAirlines.text = firstStartArr?.flightSegment?.marketingAirlineName
            lblFlightNumber.text = "\(firstStartArr?.flightSegment?.marketingAirlineCode ?? "")\(firstStartArr?.flightSegment?.flightNumber ?? "")"
            
            //lblTicketPrice.text = FareItinerary(airItineraryFareInfo: <#T##AirItineraryFareInfo?#>, ticketType: <#T##String?#>)
            let currencyModel = model.fareItinerary?.airItineraryFareInfo?.itinTotalFares
            if currencyModel?.totalFare?.currencyCode == "USD"{
                lblTicketPrice.text = "$\(currencyModel?.totalFare?.amount ?? "-")"
            }else{
                lblTicketPrice.text = currencyModel?.totalFare?.amount
            }
            
            lblSeatsAvailable.text = "\(firstStartArr?.seatsRemaining?.number ?? 0)"
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
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
    func onSelectViewDetailsClicked(closure: @escaping ()->()) {
        shareClosure = closure
        
    }
    
    
    @IBAction func btnSelectClicked(_ sender: Any) {
        if shareClosure != nil {
            shareClosure!()
        }
    }
    
}


//   if !isReturn{

//      }
//        else{
//            if let value = model.fareItinerary?.originDestinationOptions?[1]{
//                originDestinationOptionsModel = value
//            }
//        }

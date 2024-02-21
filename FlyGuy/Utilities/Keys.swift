//
//  Keys.swift
//  FlyGuy
//
//  Created by Mac on 05/04/23.
//

import Foundation

class ParameterKeys{
    
    //MARK: Alamofire Keys
    static let Authorization = "Authorization"
    static let Accept = "Accept"
    static let ContentType = "Content-Type"
    static let AcceptValue = "application/json"
    static let GZip = "Accept-Encoding"
    static let GZipContent = "gzip, deflate, br"
    
    //MARK: POST Incident Keys
    static let Issue = "issue"
    static let Difference = "difference"
    static let AirlineName = "airlineName"
    static let ClientIP = "clientIP"
    static let FlightNumber = "flightNumber"
    static let Sum = "sum"
    static let Channel = "channel"
   
    //static let City = "city"
    static let City = "searchQuery"
    static let AirportCode = "AirportCode"
    static let pnrID = "pnr_id"
    //MARK: Sign UP Keys
    static let firstname = "firstname"
    static let lastname = "lastname"
    static let email = "email"
    static let password = "password"
    static let phonenumber = "phonenumber"
    static let repassword = "repassword"
    static let userId = "user_id"
    static let token = "token"
    static let oldpassword = "oldpassword"
    static let newpassword = "newpassword"
    static let birthdate = "birthdate"
 
    static let classType = "classtype"
    static let trip = "trip"
    static let destination = "destination"
    static let departure = "departure"
    static let departureDate = "departureDate"
    static let departureTime = "departureTime"
    static let returnDate = "returnDate"
    static let returnTime = "returnTime"
    static let adults = "adults"
    static let childs = "childs"
    static let infants = "infants"
    
    //MARK: Valid Fare Api Keys
    static let sessionId = "session_id"
    static let fareSourceCode = "fare_source_code"
    
    //MARK: Airline Logo Api Key
    static let airLineCode = "AirLineCode"

}

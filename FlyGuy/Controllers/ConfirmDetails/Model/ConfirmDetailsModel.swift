//
//  ConfirmDetailsModel.swift
//  FlyGuy
//
//  Created by Springup Labs on 30/05/23.
//

import Foundation

// MARK: - FlightBookingInputDTO
struct FlightBookingInputDTO: Codable {
    var flightBookingInfo: FlightBookingInformation?
    var paxInfo: PaxInfo?
    var bookingDetails: BookingDetails?
    var userID, pnrID, cancellationStatus, paymentID: String?
    var journeyTime, journeyDate, createdBy,refId: String?
    
    enum CodingKeys: String, CodingKey {
           case flightBookingInfo, paxInfo
           case bookingDetails = "booking_details"
           case userID = "user_id"
           case pnrID = "pnr_id"
           case cancellationStatus = "cancellation_status"
           case paymentID = "payment_id"
           case journeyTime = "journey_time"
           case journeyDate = "journey_date"
           case createdBy = "created_by"
           case refId = "tr_refId"
       }
}

// MARK: - FlightBookingInformation
struct FlightBookingInformation: Codable {
    var flightSessionID, fareSourceCode, isPassportMandatory, fareType: String?
    var areaCode, countryCode: String?

    enum CodingKeys: String, CodingKey {
        case flightSessionID = "flight_session_id"
        case fareSourceCode = "fare_source_code"
        case isPassportMandatory = "IsPassportMandatory"
        case fareType, areaCode, countryCode
    }
}

// MARK: - PaxInfo
struct PaxInfo: Codable {
    var clientRef, postCode, customerEmail, customerPhone: String?
    var bookingNote: String?
    var paxDetails: [PaxDetail]?
}

// MARK: - PaxDetail
struct PaxDetail: Codable {
    var adult, child, infant: Adult?
}

// MARK: - Adult
struct Adult: Codable {
    var title, firstName, lastName, dob: [String]?
    var nationality, passportNo, passportIssueCountry, passportExpiryDate: [String]?
    var extraServiceOutbound, extraServiceInbound: [[String]]?

    enum CodingKeys: String, CodingKey {
        case title, firstName, lastName, dob, nationality, passportNo, passportIssueCountry, passportExpiryDate
        case extraServiceOutbound = "ExtraServiceOutbound"
        case extraServiceInbound = "ExtraServiceInbound"
    }
}

struct BookingDetails: Codable {
    var trip, from, to, fromtime: String?
    var totime, airlineName, bookingprice, totalStop: String?
    var flightNo, ticketID: String?

    enum CodingKeys: String, CodingKey {
        case trip, from, to, fromtime, totime
        case airlineName = "AirlineName"
        case bookingprice
        case totalStop = "TotalStop"
        case flightNo = "FlightNo."
        case ticketID = "ticketId"
    }
}

// MARK: - ConfirmBookingOutputDTO

struct ConfirmBookingOutputDTO: Codable {
    
    var msg: Int?
    var result: ResultConfirmBooking?

}

// MARK: - Result
struct ResultConfirmBooking: Codable {
    var id: Int?
    var updatedAt, bookingDetails, paymentID, createdBy: String?
    var userID, travellerDetails, bookingID, pnrID: String?
    var journeyTime, cancellationStatus, journeyDate, createdAt: String?

    enum CodingKeys: String, CodingKey {
        case id, updatedAt
        case bookingDetails = "booking_details"
        case paymentID = "payment_id"
        case createdBy = "created_by"
        case userID = "user_id"
        case travellerDetails = "traveller_details"
        case bookingID = "booking_id"
        case pnrID = "pnr_id"
        case journeyTime = "journey_time"
        case cancellationStatus = "cancellation_status"
        case journeyDate = "journey_date"
        case createdAt
    }
}


// MARK: - RevalidateErrorOutputDTOError
struct RevalidateErrorOutputDTOError: Codable {
    var bookFlightResponse: BookFlightResponse?

    enum CodingKeys: String, CodingKey {
        case bookFlightResponse = "BookFlightResponse"
    }
}

// MARK: - BookFlightResponse
struct BookFlightResponse: Codable {
    var bookFlightResult: BookFlightResult?

    enum CodingKeys: String, CodingKey {
        case bookFlightResult = "BookFlightResult"
    }
}

// MARK: - BookFlightResult
struct BookFlightResult: Codable {
    var errors: ErrorsBookingFlight?
    var status, success, target, tktTimeLimit: String?
    var uniqueID: String?

    enum CodingKeys: String, CodingKey {
        case errors = "Errors"
        case status = "Status"
        case success = "Success"
        case target = "Target"
        case tktTimeLimit = "TktTimeLimit"
        case uniqueID = "UniqueID"
    }
}

// MARK: - Errors
struct ErrorsBookingFlight: Codable {
    var error: ErrorsError?

    enum CodingKeys: String, CodingKey {
        case error = "Error"
    }
}

// MARK: - ErrorsError
struct ErrorsError: Codable {
    var errorCode, errorMessage: String?

    enum CodingKeys: String, CodingKey {
        case errorCode = "ErrorCode"
        case errorMessage = "ErrorMessage"
    }
}

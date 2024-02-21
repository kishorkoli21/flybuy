//
//  UpcomingFlightsModel.swift
//  FlyGuy
//
//  Created by Springup Labs on 08/06/23.
//

import Foundation

//// MARK: - BookingFlightListOutputDTO
//struct BookingFlightListOutputDTO: Codable {
//    var msg: Int?
//    var complated, upcomming, cancellation: [Cancellation]?
//}
//
//// MARK: - Cancellation
//struct Cancellation: Codable {
//    var mergedDateTime: String?
//    var bookingID, userID, bookingDetails, travellerDetails: String?
//    var pnrID: String?
//    var cancellationStatus: String?
//    var paymentID: String?
//    var journeyDate: String?
//
//    enum CodingKeys: String, CodingKey {
//        case mergedDateTime
//        case bookingID = "booking_id"
//        case userID = "user_id"
//        case bookingDetails = "booking_details"
//        case travellerDetails = "traveller_details"
//        case pnrID = "pnr_id"
//        case cancellationStatus = "cancellation_status"
//        case paymentID = "payment_id"
//        case journeyDate = "journey_date"
//    }
//}

// MARK: - BookingFlightListInputDTO
struct BookingFlightListInputDTO: Codable {
    var userID: String?

    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
    }
}

//
//// MARK: - BookingFlightListOutputDTO
//struct BookingFlightListOutputDTO: Codable {
//    var msg: Int?
//    var complated, upcomming, cancellation: [Cancellation]?
//}
//
//// MARK: - Cancellation
//struct Cancellation: Codable {
//    var mergedDateTime: MergedDateTime?
//    var bookingID, userID, bookingDetails, travellerDetails: String?
//    var pnrID: PnrID?
//    var cancellationStatus: String?
//    var paymentID: PaymentID?
//    var journeyDate: String?
//
//    enum CodingKeys: String, CodingKey {
//        case mergedDateTime
//        case bookingID = "booking_id"
//        case userID = "user_id"
//        case bookingDetails = "booking_details"
//        case travellerDetails = "traveller_details"
//        case pnrID = "pnr_id"
//        case cancellationStatus = "cancellation_status"
//        case paymentID = "payment_id"
//        case journeyDate = "journey_date"
//    }
//}
//
//enum MergedDateTime: String, Codable {
//    case the20230607130500 = "2023-06-07 13:05:00"
//    case the20230720130500 = "2023-07-20 13:05:00"
//}
//
//enum PaymentID: String, Codable {
//    case empty = ""
//    case wqeqw = "wqeqw"
//}
//
//enum PnrID: String, Codable {
//    case tr25582023 = "TR25582023"
//    case tr62282023 = "TR62282023"
//}

// MARK: - BookingFlightListOutputDTO
struct BookingFlightListOutputDTO: Codable {
    var complated, cancellation: [Cancellation]?
    var msg: Int?
    var upcomming: [Cancellation]?
}

// MARK: - Cancellation
struct Cancellation: Codable {
    var pnrID, bookingID, cancellationStatus, travellerDetails: String?
    var paymentID, bookingDetails, journeyDate, refund: String?
    var mergedDateTime: String?
    var userID: String?

    enum CodingKeys: String, CodingKey {
        case pnrID = "pnr_id"
        case bookingID = "booking_id"
        case cancellationStatus = "cancellation_status"
        case travellerDetails = "traveller_details"
        case paymentID = "payment_id"
        case bookingDetails = "booking_details"
        case journeyDate = "journey_date"
        case mergedDateTime
        case userID = "user_id"
        case refund = "refund_amount"
    }
}

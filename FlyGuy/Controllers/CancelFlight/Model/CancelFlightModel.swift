//
//  CancelFlightModel.swift
//  FlyGuy
//
//  Created by Springup Labs on 12/06/23.
//

import Foundation

// MARK: - CancelrefundInputDTO
struct CancelrefundInputDTO: Codable {
    var pnrID: String?

    enum CodingKeys: String, CodingKey {
        case pnrID = "pnr_id"
    }
}

// MARK: - CancelrefundOutputDTO
struct CancelrefundOutputDTO: Codable {
    var msg: Int?
    var result: ResultRefund?
    var sum: Float?
    var is24HoursBefore: Bool?
    var finalpaymentgetwaycharges : Bool?
    var paymentgetwaycharges: Float?
    var ConfirmationNo : String?
    var refundStatus : Int?
    var Error: String?
}

// MARK: - Result
struct ResultRefund: Codable {
    var ptrResponse: PtrResponse?

    enum CodingKeys: String, CodingKey {
        case ptrResponse = "PtrResponse"
    }
}

// MARK: - PtrResponse
struct PtrResponse: Codable {
    var ptrResult: PtrResult?

    enum CodingKeys: String, CodingKey {
        case ptrResult = "PtrResult"
    }
}

// MARK: - PtrResult
struct PtrResult: Codable {
    var success: String?
    var errors: [String]?
    var ptrDetails: [PtrDetailRefund]?

    enum CodingKeys: String, CodingKey {
        case success = "Success"
        case errors = "Errors"
        case ptrDetails = "PtrDetails"
    }
}

// MARK: - PtrDetail
struct PtrDetailRefund: Codable {
    var uniqueID: String?
    var ptrUniqueID: Int?
    var ptrType, ptrStatus, resolution: String?
    var paxDetails: [PaxDetailRefund]?

    enum CodingKeys: String, CodingKey {
        case uniqueID = "UniqueID"
        case ptrUniqueID = "PtrUniqueID"
        case ptrType = "PtrType"
        case ptrStatus = "PtrStatus"
        case resolution = "Resolution"
        case paxDetails = "PaxDetails"
    }
}

// MARK: - PaxDetail
struct PaxDetailRefund: Codable {
    var passengerType, title, firstName, lastName: String?
    var eTicket: String?
    var quotedFares: [String: QuotedFare]?

    enum CodingKeys: String, CodingKey {
        case passengerType = "PassengerType"
        case title = "Title"
        case firstName = "FirstName"
        case lastName = "LastName"
        case eTicket = "ETicket"
        case quotedFares = "QuotedFares"
    }
}

// MARK: - QuotedFare
struct QuotedFare: Codable {
    var amount: String?
    var currencyCode: String?
    var decimalPlaces: String?

    enum CodingKeys: String, CodingKey {
        case amount = "Amount"
        case currencyCode = "CurrencyCode"
        case decimalPlaces = "DecimalPlaces"
    }
}


// MARK: - CancelFlightOutputDTO
struct CancelFlightOutputDTO: Codable {
    var msg: Int?
    var result: ResultCancelFlight?
    var Error: String?
}

// MARK: - Result
struct ResultCancelFlight: Codable {
    var voidQuoteResponse: VoidQuoteResponse?

    enum CodingKeys: String, CodingKey {
        case voidQuoteResponse = "VoidQuoteResponse"
    }
}

// MARK: - VoidQuoteResponse
struct VoidQuoteResponse: Codable {
    var voidQuoteResult: VoidQuoteResult?

    enum CodingKeys: String, CodingKey {
        case voidQuoteResult = "VoidQuoteResult"
    }
}

// MARK: - VoidQuoteResult
struct VoidQuoteResult: Codable {
    var success, uniqueID: String?
    var errors: [String]?
    var ptrUniqueID: Int?
    var status, processingTime: String?
    var voidQuotes: [VoidQuote]?

    enum CodingKeys: String, CodingKey {
        case success = "Success"
        case uniqueID = "UniqueID"
        case errors = "Errors"
        case ptrUniqueID
        case status = "Status"
        case processingTime = "ProcessingTime"
        case voidQuotes = "VoidQuotes"
    }
}

// MARK: - VoidQuote
struct VoidQuote: Codable {
    var passengerType, title, firstName, lastName: String?
    var eTicket: String?

    enum CodingKeys: String, CodingKey {
        case passengerType = "PassengerType"
        case title = "Title"
        case firstName = "FirstName"
        case lastName = "LastName"
        case eTicket = "ETicket"
    }
}


// MARK: - CancelFlightErrorOutputDTO
struct CancelFlightErrorOutputDTO: Codable {
    var msg: Int?
    var result: ResultError?
    var Error: String?
}

// MARK: - Result
struct ResultError: Codable {
    var errors: Errors?

    enum CodingKeys: String, CodingKey {
        case errors = "Errors"
    }
}

// MARK: - Errors
struct Errors: Codable {
    var errorCode, errorMessage: String?

    enum CodingKeys: String, CodingKey {
        case errorCode = "ErrorCode"
        case errorMessage = "ErrorMessage"
    }
}

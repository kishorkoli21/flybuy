//
//  FlightBookingDetail.swift
//  FlyGuy
//
//  Created by Springup Labs on 05/06/23.
//

import Foundation

// MARK: - ConfirmBookingDetailInputDTO
//struct ConfirmBookingDetailInputDTO: Codable {
//    var userID, userPassword, access, ipAddress: String?
//    var uniqueID: String?
//
//    enum CodingKeys: String, CodingKey {
//        case userID = "user_id"
//        case userPassword = "user_password"
//        case access
//        case ipAddress = "ip_address"
//        case uniqueID = "UniqueID"
//    }
//}

struct ConfirmBookingDetailInputDTO: Codable {
    var pnrID: String?

    enum CodingKeys: String, CodingKey {
        case pnrID = "pnr_id"
    }
}


//
//// MARK: - ConfirmBookingDetailOutputDTO
//struct ConfirmBookingDetailOutputDTO: Codable {
//    var tripDetailsResponse: TripDetailsResponse?
//    var errors: ErrorsRevalidate?
//
//    enum CodingKeys: String, CodingKey {
//        case tripDetailsResponse = "TripDetailsResponse"
//    }
//}
//
//// MARK: - TripDetailsResponse
//struct TripDetailsResponse: Codable {
//    var tripDetailsResult: TripDetailsResult?
//
//    enum CodingKeys: String, CodingKey {
//        case tripDetailsResult = "TripDetailsResult"
//    }
//}
//
//// MARK: - TripDetailsResult
//struct TripDetailsResult: Codable {
//    var success, target: String?
//    var travelItinerary: TravelItinerary?
//
//    enum CodingKeys: String, CodingKey {
//        case success = "Success"
//        case target = "Target"
//        case travelItinerary = "TravelItinerary"
//    }
//}
//
//// MARK: - TravelItinerary
//struct TravelItinerary: Codable {
//    var isCommissionable: Bool?
//    var bookingStatus: String?
//    var isMOFare: Bool?
//    var destination, origin, ticketStatus: String?
//    var itineraryInfo: ItineraryInfo?
//    var crossBorderIndicator: Bool?
//    var fareType, uniqueID: String?
//
//    enum CodingKeys: String, CodingKey {
//        case isCommissionable = "IsCommissionable"
//        case bookingStatus = "BookingStatus"
//        case isMOFare = "IsMOFare"
//        case destination = "Destination"
//        case origin = "Origin"
//        case ticketStatus = "TicketStatus"
//        case itineraryInfo = "ItineraryInfo"
//        case crossBorderIndicator = "CrossBorderIndicator"
//        case fareType = "FareType"
//        case uniqueID = "UniqueID"
//    }
//}
//
//// MARK: - ItineraryInfo
//struct ItineraryInfo: Codable {
//    var itineraryPricing: ItineraryPricing?
//    var tripDetailsPTCFareBreakdowns: [TripDetailsPTCFareBreakdownElement]?
//    var reservationItems: [ReservationItemElement]?
//    var customerInfos: [CustomerInfoElement]?
//
//    enum CodingKeys: String, CodingKey {
//        case itineraryPricing = "ItineraryPricing"
//        case tripDetailsPTCFareBreakdowns = "TripDetailsPTC_FareBreakdowns"
//        case reservationItems = "ReservationItems"
//        case customerInfos = "CustomerInfos"
//    }
//}
//
//// MARK: - CustomerInfoElement
//struct CustomerInfoElement: Codable {
//    var customerInfo: [String: String]?
//    enum CodingKeys: String, CodingKey {
//        case customerInfo = "CustomerInfo"
//    }
//}
//
//// MARK: - CustomerInfoCustomerInfo
//struct CustomerInfoCustomerInfo: Codable {
//    var dateOfBirth, passengerLastName, passengerFirstName, emailAddress: String?
//    var passengerTitle, passengerType, eTicketNumber, gender: String?
//    var passportNumber, passengerNationality, itemRPH, phoneNumber: String?
//    var postCode: String?
//
//    enum CodingKeys: String, CodingKey {
//        case dateOfBirth = "DateOfBirth"
//        case passengerLastName = "PassengerLastName"
//        case passengerFirstName = "PassengerFirstName"
//        case emailAddress = "EmailAddress"
//        case passengerTitle = "PassengerTitle"
//        case passengerType = "PassengerType"
//        case eTicketNumber
//        case gender = "Gender"
//        case passportNumber = "PassportNumber"
//        case passengerNationality = "PassengerNationality"
//        case itemRPH = "ItemRPH"
//        case phoneNumber = "PhoneNumber"
//        case postCode = "PostCode"
//    }
//}
//
//// MARK: - ItineraryPricing
//struct ItineraryPricing: Codable {
//    var tax, equiFare, serviceTax, totalFare: EquiFare?
//
//    enum CodingKeys: String, CodingKey {
//        case tax = "Tax"
//        case equiFare = "EquiFare"
//        case serviceTax = "ServiceTax"
//        case totalFare = "TotalFare"
//    }
//}
//
//// MARK: - EquiFare
//struct EquiFare: Codable {
//    var currencyCode, amount: String?
//   // var decimalPlaces: Int?
//
//    enum CodingKeys: String, CodingKey {
//        case currencyCode = "CurrencyCode"
//        case amount = "Amount"
//       // case decimalPlaces = "DecimalPlaces"
//    }
//}
//
//// MARK: - ReservationItemElement
//struct ReservationItemElement: Codable {
//    var reservationItem: ReservationItemReservationItem?
//
//    enum CodingKeys: String, CodingKey {
//        case reservationItem = "ReservationItem"
//    }
//}
//
//// MARK: - ReservationItemReservationItem
//struct ReservationItemReservationItem: Codable {
//    var journeyDuration, departureAirportLocationCode, flightNumber, baggage: String?
//    var cabinClassText, operatingAirlineCode, airlinePNR, departureTerminal: String?
//    var arrivalDateTime, airEquipmentType, departureDateTime, marketingAirlineCode: String?
//    var resBookDesigCode, arrivalAirportLocationCode, itemRPH, numberInParty: String?
//    var arrivalTerminal, stopQuantity: String?
//
//    enum CodingKeys: String, CodingKey {
//        case journeyDuration = "JourneyDuration"
//        case departureAirportLocationCode = "DepartureAirportLocationCode"
//        case flightNumber = "FlightNumber"
//        case baggage = "Baggage"
//        case cabinClassText = "CabinClassText"
//        case operatingAirlineCode = "OperatingAirlineCode"
//        case airlinePNR = "AirlinePNR"
//        case departureTerminal = "DepartureTerminal"
//        case arrivalDateTime = "ArrivalDateTime"
//        case airEquipmentType = "AirEquipmentType"
//        case departureDateTime = "DepartureDateTime"
//        case marketingAirlineCode = "MarketingAirlineCode"
//        case resBookDesigCode = "ResBookDesigCode"
//        case arrivalAirportLocationCode = "ArrivalAirportLocationCode"
//        case itemRPH = "ItemRPH"
//        case numberInParty = "NumberInParty"
//        case arrivalTerminal = "ArrivalTerminal"
//        case stopQuantity = "StopQuantity"
//    }
//}
//
//// MARK: - TripDetailsPTCFareBreakdownElement
//struct TripDetailsPTCFareBreakdownElement: Codable {
//    var tripDetailsPTCFareBreakdown: TripDetailsPTCFareBreakdownTripDetailsPTCFareBreakdown?
//
//    enum CodingKeys: String, CodingKey {
//        case tripDetailsPTCFareBreakdown = "TripDetailsPTC_FareBreakdown"
//    }
//}
//
//// MARK: - TripDetailsPTCFareBreakdownTripDetailsPTCFareBreakdown
//struct TripDetailsPTCFareBreakdownTripDetailsPTCFareBreakdown: Codable {
//    var passengerTypeQuantity: PassengerTypeQuantityies?
//    var tripDetailsPassengerFare: ItineraryPricing?
//
//    enum CodingKeys: String, CodingKey {
//        case passengerTypeQuantity = "PassengerTypeQuantity"
//        case tripDetailsPassengerFare = "TripDetailsPassengerFare"
//    }
//}
//
//// MARK: - PassengerTypeQuantity
//struct PassengerTypeQuantityies: Codable {
//    var code: String?
//    var quantity: Int?
//
//    enum CodingKeys: String, CodingKey {
//        case code = "Code"
//        case quantity = "Quantity"
//    }
//}
//
//
// MARK: - FareRulesInputDTO
struct FareRulesInputDTO: Codable {
    var sessionID, fareSourceCode: String?

    enum CodingKeys: String, CodingKey {
        case sessionID = "session_id"
        case fareSourceCode = "fare_source_code"
    }
}



// MARK: - FareRulesOutputDTO
struct FareRulesOutputDTO: Codable {
    var fareRules11Response: FareRules11Response?
    var errors: ErrorsRevalidate?

    enum CodingKeys: String, CodingKey {
        case fareRules11Response = "FareRules1_1Response"
        case errors = "Errors"

    }
}

// MARK: - FareRules11Response
struct FareRules11Response: Codable {
    var fareRules11Result: FareRules11Result?

    enum CodingKeys: String, CodingKey {
        case fareRules11Result = "FareRules1_1Result"
    }
}

// MARK: - FareRules11Result
struct FareRules11Result: Codable {
    var baggageInfos: [BaggageInfoElement]?
    var fareRules: [FareRuleElement]?

    enum CodingKeys: String, CodingKey {
        case baggageInfos = "BaggageInfos"
        case fareRules = "FareRules"
    }
}

// MARK: - BaggageInfoElement
struct BaggageInfoElement: Codable {
    var baggageInfo: BaggageInfoBaggageInfo?

    enum CodingKeys: String, CodingKey {
        case baggageInfo = "BaggageInfo"
    }
}

// MARK: - BaggageInfoBaggageInfo
struct BaggageInfoBaggageInfo: Codable {
    var arrival, baggage, departure, flightNo: String?

    enum CodingKeys: String, CodingKey {
        case arrival = "Arrival"
        case baggage = "Baggage"
        case departure = "Departure"
        case flightNo = "FlightNo"
    }
}

// MARK: - FareRuleElement
struct FareRuleElement: Codable {
    var fareRule: FareRuleFareRule?

    enum CodingKeys: String, CodingKey {
        case fareRule = "FareRule"
    }
}

// MARK: - FareRuleFareRule
struct FareRuleFareRule: Codable {
    var airline, cityPair, category: String?
    var rules: String?

    enum CodingKeys: String, CodingKey {
        case airline = "Airline"
        case cityPair = "CityPair"
        case category = "Category"
        case rules = "Rules"
    }
}

// MARK: - ConfirmBookingDetailOutputDTO
struct ConfirmBookingDetailOutputDTO: Codable {
    var msg: Int?
    var result: ResultBookingDetail?
    var errors: ErrorsRevalidate?
}

// MARK: - Result
struct ResultBookingDetail: Codable {
    var tripDetailsResponse: TripDetailsResponse?

    enum CodingKeys: String, CodingKey {
        case tripDetailsResponse = "TripDetailsResponse"
    }
}

//// MARK: - ConfirmBookingDetailOutputDTO
//struct ConfirmBookingDetailOutputDTO: Codable {
//    var tripDetailsResponse: TripDetailsResponse?
//    var errors: ErrorsRevalidate?
//    enum CodingKeys: String, CodingKey {
//        case tripDetailsResponse = "TripDetailsResponse"
//    }
//}

// MARK: - TripDetailsResponse
struct TripDetailsResponse: Codable {
    var tripDetailsResult: TripDetailsResult?

    enum CodingKeys: String, CodingKey {
        case tripDetailsResult = "TripDetailsResult"
    }
}

// MARK: - TripDetailsResult
struct TripDetailsResult: Codable {
    var success, target: String?
    var travelItinerary: TravelItinerary?

    enum CodingKeys: String, CodingKey {
        case success = "Success"
        case target = "Target"
        case travelItinerary = "TravelItinerary"
    }
}

// MARK: - TravelItinerary
struct TravelItinerary: Codable {
    var isCommissionable: Bool?
    var bookingStatus: String?
    var isMOFare: Bool?
    var destination, origin, ticketStatus: String?
    var itineraryInfo: ItineraryInfo?
    var crossBorderIndicator: Bool?
    var fareType, uniqueID: String?

    enum CodingKeys: String, CodingKey {
        case isCommissionable = "IsCommissionable"
        case bookingStatus = "BookingStatus"
        case isMOFare = "IsMOFare"
        case destination = "Destination"
        case origin = "Origin"
        case ticketStatus = "TicketStatus"
        case itineraryInfo = "ItineraryInfo"
        case crossBorderIndicator = "CrossBorderIndicator"
        case fareType = "FareType"
        case uniqueID = "UniqueID"
    }
}

// MARK: - ItineraryInfo
struct ItineraryInfo: Codable {
    var itineraryPricing: ItineraryPricing?
    var tripDetailsPTCFareBreakdowns: [TripDetailsPTCFareBreakdownElement]?
    var extraServices: String?
    var bookingNotes: [JSONAny]?
    var reservationItems: [ReservationItemElement]?
    var customerInfos: [CustomerInfoElement]?

    enum CodingKeys: String, CodingKey {
        case itineraryPricing = "ItineraryPricing"
        case tripDetailsPTCFareBreakdowns = "TripDetailsPTC_FareBreakdowns"
        case extraServices = "ExtraServices"
        case bookingNotes = "BookingNotes"
        case reservationItems = "ReservationItems"
        case customerInfos = "CustomerInfos"
    }
}

// MARK: - CustomerInfoElement
struct CustomerInfoElement: Codable {
    var customerInfo: CustomerInfoCustomerInfo?
    
    enum CodingKeys: String, CodingKey {
        case customerInfo = "CustomerInfo"
    }
}

// MARK: - CustomerInfoCustomerInfo
struct CustomerInfoCustomerInfo: Codable {
    var dateOfBirth, passengerLastName, passengerFirstName, emailAddress: String?
    var passengerTitle, passengerType, eTicketNumber, passportNumber: String?
    var gender, passengerNationality: String?
    var itemRPH: Int?
    var phoneNumber, postCode: String?

    enum CodingKeys: String, CodingKey {
        case dateOfBirth = "DateOfBirth"
        case passengerLastName = "PassengerLastName"
        case passengerFirstName = "PassengerFirstName"
        case emailAddress = "EmailAddress"
        case passengerTitle = "PassengerTitle"
        case passengerType = "PassengerType"
        case eTicketNumber
        case passportNumber = "PassportNumber"
        case gender = "Gender"
        case passengerNationality = "PassengerNationality"
        case itemRPH = "ItemRPH"
        case phoneNumber = "PhoneNumber"
        case postCode = "PostCode"
    }
}

// MARK: - ItineraryPricing
struct ItineraryPricing: Codable {
    var tax, equiFare, serviceTax, totalFare: EquiFare?

    enum CodingKeys: String, CodingKey {
        case tax = "Tax"
        case equiFare = "EquiFare"
        case serviceTax = "ServiceTax"
        case totalFare = "TotalFare"
    }
}

// MARK: - EquiFare
struct EquiFare: Codable {
    var currencyCode, amount: String?
    var decimalPlaces: Int?

    enum CodingKeys: String, CodingKey {
        case currencyCode = "CurrencyCode"
        case amount = "Amount"
        case decimalPlaces = "DecimalPlaces"
    }
}

// MARK: - ReservationItemElement
struct ReservationItemElement: Codable {
    var reservationItem: ReservationItemReservationItem?

    enum CodingKeys: String, CodingKey {
        case reservationItem = "ReservationItem"
    }
}

// MARK: - ReservationItemReservationItem
struct ReservationItemReservationItem: Codable {
    var journeyDuration, departureAirportLocationCode, flightNumber, baggage: String?
    var cabinClassText, operatingAirlineCode, airlinePNR, departureTerminal: String?
    var arrivalDateTime, airEquipmentType, departureDateTime, marketingAirlineCode: String?
    var resBookDesigCode, arrivalAirportLocationCode: String?
    var itemRPH, numberInParty: Int?
    var arrivalTerminal: String?
    var stopQuantity: Int?

    enum CodingKeys: String, CodingKey {
        case journeyDuration = "JourneyDuration"
        case departureAirportLocationCode = "DepartureAirportLocationCode"
        case flightNumber = "FlightNumber"
        case baggage = "Baggage"
        case cabinClassText = "CabinClassText"
        case operatingAirlineCode = "OperatingAirlineCode"
        case airlinePNR = "AirlinePNR"
        case departureTerminal = "DepartureTerminal"
        case arrivalDateTime = "ArrivalDateTime"
        case airEquipmentType = "AirEquipmentType"
        case departureDateTime = "DepartureDateTime"
        case marketingAirlineCode = "MarketingAirlineCode"
        case resBookDesigCode = "ResBookDesigCode"
        case arrivalAirportLocationCode = "ArrivalAirportLocationCode"
        case itemRPH = "ItemRPH"
        case numberInParty = "NumberInParty"
        case arrivalTerminal = "ArrivalTerminal"
        case stopQuantity = "StopQuantity"
    }
}

// MARK: - TripDetailsPTCFareBreakdownElement
struct TripDetailsPTCFareBreakdownElement: Codable {
    var tripDetailsPTCFareBreakdown: TripDetailsPTCFareBreakdownTripDetailsPTCFareBreakdown?

    enum CodingKeys: String, CodingKey {
        case tripDetailsPTCFareBreakdown = "TripDetailsPTC_FareBreakdown"
    }
}

// MARK: - TripDetailsPTCFareBreakdownTripDetailsPTCFareBreakdown
struct TripDetailsPTCFareBreakdownTripDetailsPTCFareBreakdown: Codable {
    var passengerTypeQuantity: PassengerTypeQuantityies?
    var tripDetailsPassengerFare: ItineraryPricing?

    enum CodingKeys: String, CodingKey {
        case passengerTypeQuantity = "PassengerTypeQuantity"
        case tripDetailsPassengerFare = "TripDetailsPassengerFare"
    }
}

// MARK: - PassengerTypeQuantity
struct PassengerTypeQuantityies: Codable {
    var code: String?
    var quantity: Int?

    enum CodingKeys: String, CodingKey {
        case code = "Code"
        case quantity = "Quantity"
    }
}

// MARK: - AirlineCityListOutputDTO
struct AirlineCityListOutputDTO: Codable {
    var msg: Int?
    var result: [ResultCityList]?
}

// MARK: - Result
struct ResultCityList: Codable {
    var airportCode, airportName, city, country, alias, searchflag: String?

    enum CodingKeys: String, CodingKey {
        case airportCode = "AirportCode"
        case airportName = "AirportName"
        case city = "City"
        case country = "Country"
        case alias = "Alias"
        case searchflag = "Searchflag"
    }
}

// MARK: - AirlineNameInpuDTO
struct AirlineNameInpuDTO: Codable {
    var airlineCode: String?
}

// MARK: - AirlineCityNameInpuDTO
struct AirlineCityNameInpuDTO: Codable {
    var airportCode: [String]?

    enum CodingKeys: String, CodingKey {
        case airportCode = "AirportCode"
    }
}

// MARK: - AirlineLogoInputDTO
struct AirlineLogoInputDTO: Codable {
    var airLineCode: [String]?

    enum CodingKeys: String, CodingKey {
        case airLineCode = "AirLineCode"
    }
}

// MARK: - VoidPaymentInputDTO
struct VoidPaymentInputDTO: Codable {
    var sslMerchantID, sslUserID, sslPin, sslTestMode: String?
    var sslTransactionType, sslInvoice, sslTxnID: String?

    enum CodingKeys: String, CodingKey {
        case sslMerchantID = "ssl_merchant_id"
        case sslUserID = "ssl_user_id"
        case sslPin = "ssl_pin"
        case sslTestMode = "ssl_test_mode"
        case sslTransactionType = "ssl_transaction_type"
        case sslInvoice = "ssl_invoice"
        case sslTxnID = "ssl_txn_id"
    }
}

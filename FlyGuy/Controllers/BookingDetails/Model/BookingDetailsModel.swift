//
//  BookingDetailsModel.swift
//  FlyGuy
//
//  Created by Springup Labs on 23/05/23.
//

import Foundation

// MARK: - Welcome
struct BookingDetailsOutputDTO: Codable {
    var msg: Int?
    var result: [ResultBookingCityList]?
    var error, message, code: String?


    enum CodingKeys: String, CodingKey {
        case msg
        case error = "Error"
        case result
        case code = "code"
        case message = "message"
    }
}

// MARK: - Result
struct ResultBookingCityList: Codable {
    let airportCode, airportName: String?
    let city: String?
    let country: String?
    let alias: String?
    let searchflag: String?

    enum CodingKeys: String, CodingKey {
        case airportCode = "AirportCode"
        case airportName = "AirportName"
        case city = "City"
        case country = "Country"
        case alias = "Alias"
        case searchflag = "Searchflag"
    }
}

struct BookingDetailsInputDTO: Codable {
    var classtype, trip, destination, departure: String?
    var departureDate, departureTime, returnDate, returnTime: String?
    var adults, childs, infants : String?
}

struct BookingDetailsInputDTOIpad: Codable {
    var classtype, trip, destination, departure: String?
    var departureDate, departureTime, returnDate, returnTime: String?
    var adults, childs, infants, destinationCity, departureCity  : String?
}

struct PaymentAddressInputDTOIpad: Codable {
    var firstName,lastname,address: String?
    var city, state, zipcode: String?
}

//
//// MARK: - FareInfos
//struct BookingDetailFareInfos: Codable {
//    var msg: Int?
//    var result: [Result]?
//    var sessionID: String?
//
//    enum CodingKeys: String, CodingKey {
//        case msg, result
//        case sessionID = "sessionId"
//    }
//}
//
//// MARK: - Result
//struct Result: Codable {
//    var fareItinerary: FareItinerary?
//
//    enum CodingKeys: String, CodingKey {
//        case fareItinerary = "FareItinerary"
//    }
//}
//
//// MARK: - FareItinerary
//struct FareItinerary: Codable {
//    var directionInd: String?
//    var airItineraryFareInfo: AirItineraryFareInfo?
//    var originDestinationOptions: [FareItineraryOriginDestinationOption]?
//    var isPassportMandatory: Bool?
//    var sequenceNumber, ticketType, validatingAirlineCode: String?
//
//    enum CodingKeys: String, CodingKey {
//        case directionInd = "DirectionInd"
//        case airItineraryFareInfo = "AirItineraryFareInfo"
//        case originDestinationOptions = "OriginDestinationOptions"
//        case isPassportMandatory = "IsPassportMandatory"
//        case sequenceNumber = "SequenceNumber"
//        case ticketType = "TicketType"
//        case validatingAirlineCode = "ValidatingAirlineCode"
//    }
//}
//
//// MARK: - AirItineraryFareInfo
//struct AirItineraryFareInfo: Codable {
//    var divideInPartyIndicator, fareSourceCode: String?
//    var fareInfos: [String]?
//    var fareType, resultIndex, isRefundable: String?
//    var itinTotalFares: ItinTotalFares?
//    var fareBreakdown: [FareBreakdown]?
//    var splitItinerary: Bool?
//
//    enum CodingKeys: String, CodingKey {
//        case divideInPartyIndicator = "DivideInPartyIndicator"
//        case fareSourceCode = "FareSourceCode"
//        case fareInfos = "FareInfos"
//        case fareType = "FareType"
//        case resultIndex = "ResultIndex"
//        case isRefundable = "IsRefundable"
//        case itinTotalFares = "ItinTotalFares"
//        case fareBreakdown = "FareBreakdown"
//        case splitItinerary = "SplitItinerary"
//    }
//}
//
//// MARK: - FareBreakdown
//struct FareBreakdown: Codable {
//    var fareBasisCode: String?
//    var baggage: [Baggage]?
//    var cabinBaggage: [CabinBaggage]?
//    var passengerFare: PassengerFare?
//    var passengerTypeQuantity: PassengerTypeQuantity?
//    var penaltyDetails: PenaltyDetails?
//
//    enum CodingKeys: String, CodingKey {
//        case fareBasisCode = "FareBasisCode"
//        case baggage = "Baggage"
//        case cabinBaggage = "CabinBaggage"
//        case passengerFare = "PassengerFare"
//        case passengerTypeQuantity = "PassengerTypeQuantity"
//        case penaltyDetails = "PenaltyDetails"
//    }
//}
//
//enum Baggage: String, Codable {
//    case the1PC = "1PC"
//    case the2PC = "2PC"
//}
//
//enum CabinBaggage: String, Codable {
//    case sb = "SB"
//}
//
//// MARK: - PassengerFare
//struct PassengerFare: Codable {
//    var baseFare, equivFare, serviceTax, surcharges: BaseFare?
//    var taxes: [BaseFare]?
//    var totalFare: BaseFare?
//
//    enum CodingKeys: String, CodingKey {
//        case baseFare = "BaseFare"
//        case equivFare = "EquivFare"
//        case serviceTax = "ServiceTax"
//        case surcharges = "Surcharges"
//        case taxes = "Taxes"
//        case totalFare = "TotalFare"
//    }
//}
//
//// MARK: - BaseFare
//struct BaseFare: Codable {
//    var amount: String?
//    var currencyCode: String?
//    var decimalPlaces, taxCode: String?
//
//    enum CodingKeys: String, CodingKey {
//        case amount = "Amount"
//        case currencyCode = "CurrencyCode"
//        case decimalPlaces = "DecimalPlaces"
//        case taxCode = "TaxCode"
//    }
//}
//
//enum Currency: String, Codable {
//    case usd = "USD"
//}
//
//// MARK: - PassengerTypeQuantity
//struct PassengerTypeQuantity: Codable {
//    var code: String?
//    var quantity: Int?
//
//    enum CodingKeys: String, CodingKey {
//        case code = "Code"
//        case quantity = "Quantity"
//    }
//}
//
//// MARK: - PenaltyDetails
//struct PenaltyDetails: Codable {
//    var currency: String?
//    var refundAllowed: Bool?
//    var refundPenaltyAmount: String?
//    var changeAllowed: Bool?
//    var changePenaltyAmount: String?
//
//    enum CodingKeys: String, CodingKey {
//        case currency = "Currency"
//        case refundAllowed = "RefundAllowed"
//        case refundPenaltyAmount = "RefundPenaltyAmount"
//        case changeAllowed = "ChangeAllowed"
//        case changePenaltyAmount = "ChangePenaltyAmount"
//    }
//}
//
//// MARK: - ItinTotalFares
//struct ItinTotalFares: Codable {
//    var baseFare, equivFare, serviceTax, totalTax: BaseFare?
//    var totalFare: BaseFare?
//
//    enum CodingKeys: String, CodingKey {
//        case baseFare = "BaseFare"
//        case equivFare = "EquivFare"
//        case serviceTax = "ServiceTax"
//        case totalTax = "TotalTax"
//        case totalFare = "TotalFare"
//    }
//}
//
//// MARK: - FareItineraryOriginDestinationOption
//struct FareItineraryOriginDestinationOption: Codable {
//    var originDestinationOption: [OriginDestinationOptionOriginDestinationOption]?
//    var totalStops: Int?
//
//    enum CodingKeys: String, CodingKey {
//        case originDestinationOption = "OriginDestinationOption"
//        case totalStops = "TotalStops"
//    }
//}
//
//// MARK: - OriginDestinationOptionOriginDestinationOption
//struct OriginDestinationOptionOriginDestinationOption: Codable {
//    var flightSegment: FlightSegment?
//    var resBookDesigCode, resBookDesigText: String?
//    var seatsRemaining: SeatsRemaining?
//    var stopQuantity: Int?
//    var stopQuantityInfo: StopQuantityInfo?
//
//    enum CodingKeys: String, CodingKey {
//        case flightSegment = "FlightSegment"
//        case resBookDesigCode = "ResBookDesigCode"
//        case resBookDesigText = "ResBookDesigText"
//        case seatsRemaining = "SeatsRemaining"
//        case stopQuantity = "StopQuantity"
//        case stopQuantityInfo = "StopQuantityInfo"
//    }
//}
//
//// MARK: - FlightSegment
//struct FlightSegment: Codable {
//    var arrivalAirportLocationCode, arrivalDateTime, cabinClassCode, cabinClassText: String?
//    var departureAirportLocationCode, departureDateTime: String?
//    var eticket: Bool?
//    var journeyDuration, flightNumber, marketingAirlineCode, marketingAirlineName: String?
//    var marriageGroup, mealCode: String?
//    var operatingAirline: OperatingAirline?
//
//    enum CodingKeys: String, CodingKey {
//        case arrivalAirportLocationCode = "ArrivalAirportLocationCode"
//        case arrivalDateTime = "ArrivalDateTime"
//        case cabinClassCode = "CabinClassCode"
//        case cabinClassText = "CabinClassText"
//        case departureAirportLocationCode = "DepartureAirportLocationCode"
//        case departureDateTime = "DepartureDateTime"
//        case eticket = "Eticket"
//        case journeyDuration = "JourneyDuration"
//        case flightNumber = "FlightNumber"
//        case marketingAirlineCode = "MarketingAirlineCode"
//        case marketingAirlineName = "MarketingAirlineName"
//        case marriageGroup = "MarriageGroup"
//        case mealCode = "MealCode"
//        case operatingAirline = "OperatingAirline"
//    }
//}
//
//// MARK: - OperatingAirline
//struct OperatingAirline: Codable {
//    var code, name, equipment, flightNumber: String?
//
//    enum CodingKeys: String, CodingKey {
//        case code = "Code"
//        case name = "Name"
//        case equipment = "Equipment"
//        case flightNumber = "FlightNumber"
//    }
//}
//
//// MARK: - SeatsRemaining
//struct SeatsRemaining: Codable {
//    var belowMinimum: Bool?
//    var number: Int?
//
//    enum CodingKeys: String, CodingKey {
//        case belowMinimum = "BelowMinimum"
//        case number = "Number"
//    }
//}
//
//// MARK: - StopQuantityInfo
//struct StopQuantityInfo: Codable {
//    var arrivalDateTime, departureDateTime, duration, locationCode: String?
//
//    enum CodingKeys: String, CodingKey {
//        case arrivalDateTime = "ArrivalDateTime"
//        case departureDateTime = "DepartureDateTime"
//        case duration = "Duration"
//        case locationCode = "LocationCode"
//    }
//}

// MARK: - BookingDetailFareInfos
struct BookingDetailFareInfos: Codable {
    var msg: Int?
    var result: [Result]?
    var sessionID, code, message, error: String?

    enum CodingKeys: String, CodingKey {
        case msg, result
        case sessionID = "sessionId"
        case error = "Error"
        case code = "code"
        case message = "message"
    }
}

// MARK: - Result
struct Result: Codable {
    var fareItinerary: FareItinerary?

    enum CodingKeys: String, CodingKey {
        case fareItinerary = "FareItinerary"
    }
}

// MARK: - FareItinerary
struct FareItinerary: Codable {
    var directionInd: String?
    var airItineraryFareInfo: AirItineraryFareInfo?
    var originDestinationOptions: [FareItineraryOriginDestinationOption]?
    var isPassportMandatory: Bool?
    var sequenceNumber, ticketType, validatingAirlineCode: String?

    enum CodingKeys: String, CodingKey {
        case directionInd = "DirectionInd"
        case airItineraryFareInfo = "AirItineraryFareInfo"
        case originDestinationOptions = "OriginDestinationOptions"
        case isPassportMandatory = "IsPassportMandatory"
        case sequenceNumber = "SequenceNumber"
        case ticketType = "TicketType"
        case validatingAirlineCode = "ValidatingAirlineCode"
    }
}

// MARK: - AirItineraryFareInfo
struct AirItineraryFareInfo: Codable {
    var divideInPartyIndicator, fareSourceCode: String?
    var fareInfos: [String]?
    var fareType, resultIndex, isRefundable: String?
    var itinTotalFares: ItinTotalFares?
    var fareBreakdown: [FareBreakdown]?
    var splitItinerary: Bool?

    enum CodingKeys: String, CodingKey {
        case divideInPartyIndicator = "DivideInPartyIndicator"
        case fareSourceCode = "FareSourceCode"
        case fareInfos = "FareInfos"
        case fareType = "FareType"
        case resultIndex = "ResultIndex"
        case isRefundable = "IsRefundable"
        case itinTotalFares = "ItinTotalFares"
        case fareBreakdown = "FareBreakdown"
        case splitItinerary = "SplitItinerary"
    }
}

// MARK: - FareBreakdown
struct FareBreakdown: Codable {
    var fareBasisCode: String?
    var baggage, cabinBaggage: [String]?
    var passengerFare: PassengerFare?
    var passengerTypeQuantity: PassengerTypeQuantity?
    var penaltyDetails: PenaltyDetails?

    enum CodingKeys: String, CodingKey {
        case fareBasisCode = "FareBasisCode"
        case baggage = "Baggage"
        case cabinBaggage = "CabinBaggage"
        case passengerFare = "PassengerFare"
        case passengerTypeQuantity = "PassengerTypeQuantity"
        case penaltyDetails = "PenaltyDetails"
    }
}

// MARK: - PassengerFare
struct PassengerFare: Codable {
    var baseFare, equivFare, serviceTax, surcharges: BaseFare?
    var taxes: [BaseFare]?
    var totalFare: BaseFare?

    enum CodingKeys: String, CodingKey {
        case baseFare = "BaseFare"
        case equivFare = "EquivFare"
        case serviceTax = "ServiceTax"
        case surcharges = "Surcharges"
        case taxes = "Taxes"
        case totalFare = "TotalFare"
    }
}

// MARK: - BaseFare
struct BaseFare: Codable {
    var amount: String?
    var currencyCode: String?
    var decimalPlaces, taxCode: String?

    enum CodingKeys: String, CodingKey {
        case amount = "Amount"
        case currencyCode = "CurrencyCode"
        case decimalPlaces = "DecimalPlaces"
        case taxCode = "TaxCode"
    }
}

// MARK: - PassengerTypeQuantity
struct PassengerTypeQuantity: Codable {
    var code: String?
    var quantity: Int?

    enum CodingKeys: String, CodingKey {
        case code = "Code"
        case quantity = "Quantity"
    }
}

// MARK: - PenaltyDetails
struct PenaltyDetails: Codable {
    var currency: String?
    var refundAllowed: Bool?
    var refundPenaltyAmount: String?
    var changeAllowed: Bool?
    var changePenaltyAmount: String?

    enum CodingKeys: String, CodingKey {
        case currency = "Currency"
        case refundAllowed = "RefundAllowed"
        case refundPenaltyAmount = "RefundPenaltyAmount"
        case changeAllowed = "ChangeAllowed"
        case changePenaltyAmount = "ChangePenaltyAmount"
    }
}

// MARK: - ItinTotalFares
struct ItinTotalFares: Codable {
    var baseFare, equivFare, serviceTax, totalTax: BaseFare?
    var totalFare: BaseFare?

    enum CodingKeys: String, CodingKey {
        case baseFare = "BaseFare"
        case equivFare = "EquivFare"
        case serviceTax = "ServiceTax"
        case totalTax = "TotalTax"
        case totalFare = "TotalFare"
    }
}

// MARK: - FareItineraryOriginDestinationOption
struct FareItineraryOriginDestinationOption: Codable {
    var originDestinationOption: [OriginDestinationOptionOriginDestinationOption]?
    var totalStops: Int?

    enum CodingKeys: String, CodingKey {
        case originDestinationOption = "OriginDestinationOption"
        case totalStops = "TotalStops"
    }
}

// MARK: - OriginDestinationOptionOriginDestinationOption
struct OriginDestinationOptionOriginDestinationOption: Codable {
    var flightSegment: FlightSegment?
    var resBookDesigCode, resBookDesigText: String?
    var seatsRemaining: SeatsRemaining?
    var stopQuantity: Int?
    var stopQuantityInfo: StopQuantityInfo?

    enum CodingKeys: String, CodingKey {
        case flightSegment = "FlightSegment"
        case resBookDesigCode = "ResBookDesigCode"
        case resBookDesigText = "ResBookDesigText"
        case seatsRemaining = "SeatsRemaining"
        case stopQuantity = "StopQuantity"
        case stopQuantityInfo = "StopQuantityInfo"
    }
}

// MARK: - FlightSegment
struct FlightSegment: Codable {
    var arrivalAirportLocationCode, arrivalDateTime, cabinClassCode, cabinClassText: String?
    var departureAirportLocationCode, departureDateTime, departureCity, arrivalCity: String?
    var eticket: Bool?
    var journeyDuration, flightNumber, marketingAirlineCode, marketingAirlineName: String?
    var marriageGroup, mealCode: String?
    var operatingAirline: OperatingAirline?

    enum CodingKeys: String, CodingKey {
        case arrivalAirportLocationCode = "ArrivalAirportLocationCode"
        case arrivalDateTime = "ArrivalDateTime"
        case cabinClassCode = "CabinClassCode"
        case cabinClassText = "CabinClassText"
        case departureAirportLocationCode = "DepartureAirportLocationCode"
        case departureDateTime = "DepartureDateTime"
        case eticket = "Eticket"
        case journeyDuration = "JourneyDuration"
        case flightNumber = "FlightNumber"
        case marketingAirlineCode = "MarketingAirlineCode"
        case marketingAirlineName = "MarketingAirlineName"
        case marriageGroup = "MarriageGroup"
        case mealCode = "MealCode"
        case operatingAirline = "OperatingAirline"
    }
}

// MARK: - OperatingAirline
struct OperatingAirline: Codable {
    var code, name, equipment, flightNumber: String?

    enum CodingKeys: String, CodingKey {
        case code = "Code"
        case name = "Name"
        case equipment = "Equipment"
        case flightNumber = "FlightNumber"
    }
}

// MARK: - SeatsRemaining
struct SeatsRemaining: Codable {
    var belowMinimum: Bool?
    var number: Int?

    enum CodingKeys: String, CodingKey {
        case belowMinimum = "BelowMinimum"
        case number = "Number"
    }
}

// MARK: - StopQuantityInfo
struct StopQuantityInfo: Codable {
    var arrivalDateTime, departureDateTime, duration, locationCode: String?

    enum CodingKeys: String, CodingKey {
        case arrivalDateTime = "ArrivalDateTime"
        case departureDateTime = "DepartureDateTime"
        case duration = "Duration"
        case locationCode = "LocationCode"
    }
}

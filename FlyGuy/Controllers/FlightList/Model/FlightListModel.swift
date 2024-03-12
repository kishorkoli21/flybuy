//
//  FlightListModel.swift
//  FlyGuy
//
//  Created by Springup Labs on 29/05/23.
//

import Foundation


//
//// MARK: - ValidFareOutputDTO
//struct ValidFareOutputDTO: Codable {
//    var airRevalidateResponse: AirRevalidateResponseErr?
//
//}
//
//// MARK: - AirRevalidateResponse
//struct AirRevalidateResponseErr: Codable {
//    var airRevalidateResult: AirRevalidateResult?
//
//    enum CodingKeys: String, CodingKey {
//        case airRevalidateResult = "AirRevalidateResult"
//    }
//}
//
//// MARK: - AirRevalidateResult
//struct AirRevalidateResult: Codable {
//    var isValid: Bool?
//
////    var fareItineraries: FareItineraries?
////    var extraServices: ExtraServices?
//
//    enum CodingKeys: String, CodingKey {
//        case isValid = "IsValid"
////        case fareItineraries = "FareItineraries"
////        case extraServices = "ExtraServices"
//    }
//}
//
//// MARK: - ExtraServices
//struct ExtraServices: Codable {
//    var services: [ServiceElement]?
//
//    enum CodingKeys: String, CodingKey {
//        case services = "Services"
//    }
//}
//
//// MARK: - ServiceElement
//struct ServiceElement: Codable {
//    var service: ServiceService?
//
//    enum CodingKeys: String, CodingKey {
//        case service = "Service"
//    }
//}
//
//// MARK: - ServiceService
//struct ServiceService: Codable {
//    var behavior, checkInType, description, flightDesignator: String?
//    var isMandatory: Bool?
//    var relation: String?
//    var serviceCost: ServiceCost?
//    var serviceID, type: String?
//
//    enum CodingKeys: String, CodingKey {
//        case behavior = "Behavior"
//        case checkInType = "CheckInType"
//        case description = "Description"
//        case flightDesignator = "FlightDesignator"
//        case isMandatory = "IsMandatory"
//        case relation = "Relation"
//        case serviceCost = "ServiceCost"
//        case serviceID = "ServiceId"
//        case type = "Type"
//    }
//}
//
//// MARK: - ServiceCost
//struct ServiceCost: Codable {
//    var amount: String?
//    var currencyCode: String?
//    var decimalPlaces: String?
//    var taxCode: String?
//
//    enum CodingKeys: String, CodingKey {
//        case amount = "Amount"
//        case currencyCode = "CurrencyCode"
//        case decimalPlaces = "DecimalPlaces"
//        case taxCode = "TaxCode"
//    }
//}
//
//
//
//// MARK: - FareItineraries
//struct FareItineraries: Codable {
//    var fareItinerary: FareItinerarys?
//
//    enum CodingKeys: String, CodingKey {
//        case fareItinerary = "FareItinerary"
//    }
//}
//
//// MARK: - FareItinerary
//struct FareItinerarys: Codable {
//    var airItineraryFareInfo: AirItineraryFareInfos?
//    var directionInd: String?
//    var isPassportMandatory: Bool?
//    var firstNameCharacterLimit, lastNameCharacterLimit, paxNameCharacterLimit: Int?
//    var originDestinationOptions: [FareItineraryOriginDestinationOptions]?
//    var requiredFieldsToBook: [String]?
//    var sequenceNumber: Int?
//    var ticketType, validatingAirlineCode: String?
//
//    enum CodingKeys: String, CodingKey {
//        case airItineraryFareInfo = "AirItineraryFareInfo"
//        case directionInd = "DirectionInd"
//        case isPassportMandatory = "IsPassportMandatory"
//        case firstNameCharacterLimit = "FirstNameCharacterLimit"
//        case lastNameCharacterLimit = "LastNameCharacterLimit"
//        case paxNameCharacterLimit = "PaxNameCharacterLimit"
//        case originDestinationOptions = "OriginDestinationOptions"
//        case requiredFieldsToBook = "RequiredFieldsToBook"
//        case sequenceNumber = "SequenceNumber"
//        case ticketType = "TicketType"
//        case validatingAirlineCode = "ValidatingAirlineCode"
//    }
//}
//
//// MARK: - AirItineraryFareInfo
//struct AirItineraryFareInfos: Codable {
//    var divideInPartyIndicator, fareSourceCode: String?
//    var fareInfos: [FareInfos]?
//    var fareType, resultIndex, isRefundable: String?
//    var itinTotalFares: ItinTotalFaress?
//    var fareBreakdown: [FareBreakdowns]?
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
//struct FareBreakdowns: Codable {
//    var fareBasisCode, baggage, cabinBaggage: [String]?
//    var passengerFare: PassengerFares?
//    var passengerTypeQuantity: PassengerTypeQuantitys?
//
//    enum CodingKeys: String, CodingKey {
//        case fareBasisCode = "FareBasisCode"
//        case baggage = "Baggage"
//        case cabinBaggage = "CabinBaggage"
//        case passengerFare = "PassengerFare"
//        case passengerTypeQuantity = "PassengerTypeQuantity"
//    }
//}
//
//// MARK: - PassengerFare
//struct PassengerFares: Codable {
//    var baseFare, equivFare, serviceTax, surcharges: ServiceCost?
//    var taxes: [ServiceCost]?
//    var totalFare: ServiceCost?
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
//// MARK: - PassengerTypeQuantity
//struct PassengerTypeQuantitys: Codable {
//    var code: String?
//    var quantity: Int?
//
//    enum CodingKeys: String, CodingKey {
//        case code = "Code"
//        case quantity = "Quantity"
//    }
//}
//
//// MARK: - FareInfo
//struct FareInfos: Codable {
//    var fareReference: String?
//
//    enum CodingKeys: String, CodingKey {
//        case fareReference = "FareReference"
//    }
//}
//
//// MARK: - ItinTotalFares
//struct ItinTotalFaress: Codable {
//    var baseFare, equivFare, serviceTax, totalTax: ServiceCost?
//    var totalFare: ServiceCost?
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
//struct FareItineraryOriginDestinationOptions: Codable {
//    var totalStops: Int?
//    var originDestinationOption: [OriginDestinationOptionOriginDestinationOptions]?
//
//    enum CodingKeys: String, CodingKey {
//        case totalStops = "TotalStops"
//        case originDestinationOption = "OriginDestinationOption"
//    }
//}
//
//// MARK: - OriginDestinationOptionOriginDestinationOption
//struct OriginDestinationOptionOriginDestinationOptions: Codable {
//    var flightSegment: FlightSegments?
//    var resBookDesigCode, resBookDesigText: String?
//    var seatsRemaining: SeatsRemainings?
//    var stopQuantity: Int?
//    var stopQuantityInfo: StopQuantityInfos?
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
//struct FlightSegments: Codable {
//    var arrivalAirportLocationCode, arrivalDateTime, cabinClassCode, cabinClassText: String?
//    var departureAirportLocationCode, departureDateTime: String?
//    var eticket: Bool?
//    var flightNumber, journeyDuration, marketingAirlineCode, marketingAirlineName: String?
//    var marriageGroup, mealCode: String?
//    var operatingAirline: OperatingAirlines?
//
//    enum CodingKeys: String, CodingKey {
//        case arrivalAirportLocationCode = "ArrivalAirportLocationCode"
//        case arrivalDateTime = "ArrivalDateTime"
//        case cabinClassCode = "CabinClassCode"
//        case cabinClassText = "CabinClassText"
//        case departureAirportLocationCode = "DepartureAirportLocationCode"
//        case departureDateTime = "DepartureDateTime"
//        case eticket = "Eticket"
//        case flightNumber = "FlightNumber"
//        case journeyDuration = "JourneyDuration"
//        case marketingAirlineCode = "MarketingAirlineCode"
//        case marketingAirlineName = "MarketingAirlineName"
//        case marriageGroup = "MarriageGroup"
//        case mealCode = "MealCode"
//        case operatingAirline = "OperatingAirline"
//    }
//}
//
//// MARK: - OperatingAirline
//struct OperatingAirlines: Codable {
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
//struct SeatsRemainings: Codable {
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
//struct StopQuantityInfos: Codable {
//    var arrivalDateTime, departureDateTime: String?
//    var duration: Int?
//    var locationCode: String?
//
//    enum CodingKeys: String, CodingKey {
//        case arrivalDateTime = "ArrivalDateTime"
//        case departureDateTime = "DepartureDateTime"
//        case duration = "Duration"
//        case locationCode = "LocationCode"
//    }
//}
//
//
// MARK: - Errors
struct ErrorsRevalidate: Codable {
    var errorCode, errorMessage: String?

    enum CodingKeys: String, CodingKey {
        case errorCode = "ErrorCode"
        case errorMessage = "ErrorMessage"
    }
}


// MARK: - ValidFareOutputDTO
struct ValidFareOutputDTO: Codable {
    var airRevalidateResponse: AirRevalidateResponse?

    enum CodingKeys: String, CodingKey {
        case airRevalidateResponse = "AirRevalidateResponse"
    }
}

// MARK: - AirRevalidateResponse
struct AirRevalidateResponse: Codable {
    var airRevalidateResult: AirRevalidateResult?

    enum CodingKeys: String, CodingKey {
        case airRevalidateResult = "AirRevalidateResult"
    }
}

// MARK: - AirRevalidateResult
struct AirRevalidateResult: Codable {
    var isValid: Bool?
    var fareItineraries: FareItineraries?
    var extraServices: ExtraServices?

    enum CodingKeys: String, CodingKey {
        case isValid = "IsValid"
        case fareItineraries = "FareItineraries"
        case extraServices = "ExtraServices"
    }
}

// MARK: - ExtraServices
struct ExtraServices: Codable {
    var services: [JSONAny]?

    enum CodingKeys: String, CodingKey {
        case services = "Services"
    }
}

// MARK: - FareItineraries
struct FareItineraries: Codable {
    var fareItinerary: FareItinerary?

    enum CodingKeys: String, CodingKey {
        case fareItinerary = "FareItinerary"
    }
}

// MARK: - FareItinerary
struct FareItinerary: Codable {
    var airItineraryFareInfo: AirItineraryFareInfo?
    var directionInd: String?
    var isPassportMandatory: Bool?
    var firstNameCharacterLimit, lastNameCharacterLimit, paxNameCharacterLimit: Int?
    var originDestinationOption: [FareItineraryOriginDestinationOption]?
    var requiredFieldsToBook: [JSONAny]?
    var sequenceNumber: String?
    var ticketType, validatingAirlineCode: String?

    enum CodingKeys: String, CodingKey {
        case airItineraryFareInfo = "AirItineraryFareInfo"
        case directionInd = "DirectionInd"
        case isPassportMandatory = "IsPassportMandatory"
        case firstNameCharacterLimit = "FirstNameCharacterLimit"
        case lastNameCharacterLimit = "LastNameCharacterLimit"
        case paxNameCharacterLimit = "PaxNameCharacterLimit"
        case originDestinationOption = "OriginDestinationOptions"
        case requiredFieldsToBook = "RequiredFieldsToBook"
        case sequenceNumber = "SequenceNumber"
        case ticketType = "TicketType"
        case validatingAirlineCode = "ValidatingAirlineCode"
    }
}

// MARK: - AirItineraryFareInfo
struct AirItineraryFareInfo: Codable {
    var divideInPartyIndicator, fareSourceCode: String?
    var fareInfos: [FareInfo]?
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

// MARK: - FareInfo
struct FareInfo: Codable {
    var fareReference: String?

    enum CodingKeys: String, CodingKey {
        case fareReference = "FareReference"
    }
}

// MARK: - ItinTotalFares
struct ItinTotalFaress: Codable {
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
    var totalStops: Int?
    var originDestinationOption: [OriginDestinationOption]?

    enum CodingKeys: String, CodingKey {
        case totalStops = "TotalStops"
        case originDestinationOption = "OriginDestinationOption"
    }
}

// MARK: - OriginDestinationOptionOriginDestinationOption
struct OriginDestinationOption: Codable {
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

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public func hash(into hasher: inout Hasher) {
        // No-op
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}

class JSONCodingKey: CodingKey {
    let key: String

    required init?(intValue: Int) {
        return nil
    }

    required init?(stringValue: String) {
        key = stringValue
    }

    var intValue: Int? {
        return nil
    }

    var stringValue: String {
        return key
    }
}

class JSONAny: Codable {

    let value: Any

    static func decodingError(forCodingPath codingPath: [CodingKey]) -> DecodingError {
        let context = DecodingError.Context(codingPath: codingPath, debugDescription: "Cannot decode JSONAny")
        return DecodingError.typeMismatch(JSONAny.self, context)
    }

    static func encodingError(forValue value: Any, codingPath: [CodingKey]) -> EncodingError {
        let context = EncodingError.Context(codingPath: codingPath, debugDescription: "Cannot encode JSONAny")
        return EncodingError.invalidValue(value, context)
    }

    static func decode(from container: SingleValueDecodingContainer) throws -> Any {
        if let value = try? container.decode(Bool.self) {
            return value
        }
        if let value = try? container.decode(Int64.self) {
            return value
        }
        if let value = try? container.decode(Double.self) {
            return value
        }
        if let value = try? container.decode(String.self) {
            return value
        }
        if container.decodeNil() {
            return JSONNull()
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decode(from container: inout UnkeyedDecodingContainer) throws -> Any {
        if let value = try? container.decode(Bool.self) {
            return value
        }
        if let value = try? container.decode(Int64.self) {
            return value
        }
        if let value = try? container.decode(Double.self) {
            return value
        }
        if let value = try? container.decode(String.self) {
            return value
        }
        if let value = try? container.decodeNil() {
            if value {
                return JSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer() {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decode(from container: inout KeyedDecodingContainer<JSONCodingKey>, forKey key: JSONCodingKey) throws -> Any {
        if let value = try? container.decode(Bool.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(Int64.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(Double.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(String.self, forKey: key) {
            return value
        }
        if let value = try? container.decodeNil(forKey: key) {
            if value {
                return JSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer(forKey: key) {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decodeArray(from container: inout UnkeyedDecodingContainer) throws -> [Any] {
        var arr: [Any] = []
        while !container.isAtEnd {
            let value = try decode(from: &container)
            arr.append(value)
        }
        return arr
    }

    static func decodeDictionary(from container: inout KeyedDecodingContainer<JSONCodingKey>) throws -> [String: Any] {
        var dict = [String: Any]()
        for key in container.allKeys {
            let value = try decode(from: &container, forKey: key)
            dict[key.stringValue] = value
        }
        return dict
    }

    static func encode(to container: inout UnkeyedEncodingContainer, array: [Any]) throws {
        for value in array {
            if let value = value as? Bool {
                try container.encode(value)
            } else if let value = value as? Int64 {
                try container.encode(value)
            } else if let value = value as? Double {
                try container.encode(value)
            } else if let value = value as? String {
                try container.encode(value)
            } else if value is JSONNull {
                try container.encodeNil()
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer()
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: JSONCodingKey.self)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }

    static func encode(to container: inout KeyedEncodingContainer<JSONCodingKey>, dictionary: [String: Any]) throws {
        for (key, value) in dictionary {
            let key = JSONCodingKey(stringValue: key)!
            if let value = value as? Bool {
                try container.encode(value, forKey: key)
            } else if let value = value as? Int64 {
                try container.encode(value, forKey: key)
            } else if let value = value as? Double {
                try container.encode(value, forKey: key)
            } else if let value = value as? String {
                try container.encode(value, forKey: key)
            } else if value is JSONNull {
                try container.encodeNil(forKey: key)
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer(forKey: key)
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }

    static func encode(to container: inout SingleValueEncodingContainer, value: Any) throws {
        if let value = value as? Bool {
            try container.encode(value)
        } else if let value = value as? Int64 {
            try container.encode(value)
        } else if let value = value as? Double {
            try container.encode(value)
        } else if let value = value as? String {
            try container.encode(value)
        } else if value is JSONNull {
            try container.encodeNil()
        } else {
            throw encodingError(forValue: value, codingPath: container.codingPath)
        }
    }

    public required init(from decoder: Decoder) throws {
        if var arrayContainer = try? decoder.unkeyedContainer() {
            self.value = try JSONAny.decodeArray(from: &arrayContainer)
        } else if var container = try? decoder.container(keyedBy: JSONCodingKey.self) {
            self.value = try JSONAny.decodeDictionary(from: &container)
        } else {
            let container = try decoder.singleValueContainer()
            self.value = try JSONAny.decode(from: container)
        }
    }

    public func encode(to encoder: Encoder) throws {
        if let arr = self.value as? [Any] {
            var container = encoder.unkeyedContainer()
            try JSONAny.encode(to: &container, array: arr)
        } else if let dict = self.value as? [String: Any] {
            var container = encoder.container(keyedBy: JSONCodingKey.self)
            try JSONAny.encode(to: &container, dictionary: dict)
        } else {
            var container = encoder.singleValueContainer()
            try JSONAny.encode(to: &container, value: self.value)
        }
    }
}

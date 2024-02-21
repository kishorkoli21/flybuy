//
//  AirlineCodeModel.swift
//  FlyGuy
//
//  Created by Mac on 05/04/23.
//

import Foundation

// MARK: - AirlineCodeModelElement
struct AirlineCodeModelElement: Codable {
    let airlineName, iata, icao: String?

    enum CodingKeys: String, CodingKey {
        case airlineName = "Airline_Name"
        case iata = "IATA"
        case icao = "ICAO"
    }
}

typealias AirlineCodeModel = [AirlineCodeModelElement]

// MARK: - ReportOutputDTO
struct ReportOutputDTO: Codable {
    var serverResponse: String?

    enum CodingKeys: String, CodingKey {
        case serverResponse = "server response"
    }
}

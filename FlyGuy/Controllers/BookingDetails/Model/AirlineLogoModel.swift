//
//  AirlineLogoModel.swift
//  FlyGuy
//
//  Created by sy51629 on 02/10/23.
//

import Foundation

struct AirlineLogoInfo: Codable {
    var msg: Int?
    var result: AirlineLogoResult?
    var sessionID, code, message, error: String?

    enum CodingKeys: String, CodingKey {
        case msg, result
        case error = "Error"
        case code = "code"
        case message = "message"
    }
}

// MARK: - Result
struct AirlineLogoResult: Codable {
    var id: Int?
    var AirLineCode: String?
    var AirLineName: String?
    var AirLineLogo: String?
    var createdAt: String?
    var updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case AirLineCode = "AirLineCode"
        case AirLineName = "AirLineName"
        case AirLineLogo = "AirLineLogo"
        case createdAt = "createdAt"
        case updatedAt = "updatedAt"
    }
}

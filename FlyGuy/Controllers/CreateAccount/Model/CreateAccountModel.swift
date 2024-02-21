//
//  CreateAccountModel.swift
//  FlyGuy
//
//  Created by Springup Labs on 23/05/23.
//

import Foundation

struct SignInOutputDTO: Codable {
    var msg: Int?
    var result, error, code, message: String?

    enum CodingKeys: String, CodingKey {
        case msg, result
        case error = "Error"
        case code = "code"
        case message = "message"
    }
}

// MARK: - LoginOutputDTO
struct LoginOutputDTO: Codable {
    var msg: Int?
    var result: String?
    var id: Int?
    var firstname, lastname, email, token: String?
    var phonenumber, userID, error, code, message, birthdate: String?

    enum CodingKeys: String, CodingKey {
        case msg, result, id, firstname, lastname, email, token, phonenumber, birthdate
        case userID = "userId"
        case code = "code"
        case message = "message"
        case error = "Error"
    }
}

// MARK: - ErrorOutputDTO
struct ErrorOutputDTO: Codable {
    var msg: Int?
    var error, code, message: String?

    enum CodingKeys: String, CodingKey {
        case msg
        case error = "Error"
        case code, message
    }
}

// MARK: - ForgotPasswordInputDTO
struct ForgotPasswordInputDTO: Codable {
    var email : String?
}

// MARK: - ForgotPasswordOutputDTO
struct ForgotPasswordOutputDTO: Codable {
    var msg: Int?
    var result: String?
    var message : String?
}

// MARK: - VoidPaymentInputDTO
struct AddPaymentPNROutputDTO: Codable {
    var msg: Int?
    var result: [Int]?
}

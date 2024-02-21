//
//  ProfileModel.swift
//  FlyGuy
//
//  Created by Springup Labs on 19/05/23.
//

import Foundation

struct SignUpInputDTO: Codable {
    let firstname, lastname, email, password: String
    let phonenumber: String
}

struct SignUpOutputDTO: Codable {
    let message: String
}

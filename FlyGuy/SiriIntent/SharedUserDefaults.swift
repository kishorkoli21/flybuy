//
//  SharedUserDefaults.swift
//  FlyGuy
//
//  Created by Sanjana Shahu on 07/05/23.
//

import Foundation

struct SharedUserDefaults {
    static let suitName = "group.com.datascalp.flyguy.flightBooking"
    //static let suitName = "group.com.datascalp.flyguybeta.flightBooking"
    
    struct Keys{
        static let from = "from"
        static let startJourney = "startJourney"
        static let destination = "destination"
        static let date = "date"
        static let time = "time"
        static let trip = "trip"
        static let preferredClass = "preferredClass"
        static let returnDate = "returnDate"
        static let returnTime = "returnTime"
    }
}


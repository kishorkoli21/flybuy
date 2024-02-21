//
//  Structures.swift
//  FlyGuy
//
//  Created by Springup Labs on 12/05/23.
//

import Foundation

struct BookingDataStruct {
    var departure : String
    var destination : String
    var date : String
    var time : String
    var trip : String
    var returnDate : String
    var returnTime : String
    var preferredClass : String
    var isFromSiri : Bool
    init(departure: String, destination: String, date: String, time: String, trip: String, returnDate: String, returnTime: String, preferredClass: String, isFromSiri : Bool) {
        self.departure = departure
        self.destination = destination
        self.date = date
        self.time = time
        self.trip = trip
        self.returnDate = returnDate
        self.returnTime = returnTime
        self.preferredClass = preferredClass
        self.isFromSiri = isFromSiri
    }
}

//struct BookingDataStructForIpad {
//    var departure : String
//    var destination : String
//    var date : String
//    var time : String
//    var trip : String
//    var returnDate : String
//    var returnTime : String
//    var preferredClass : String
//    init(departure: String, destination: String, date: String, time: String, trip: String, returnDate: String, returnTime: String, preferredClass: String) {
//        self.departure = departure
//        self.destination = destination
//        self.date = date
//        self.time = time
//        self.trip = trip
//        self.returnDate = returnDate
//        self.returnTime = returnTime
//        self.preferredClass = preferredClass
//    }
//}

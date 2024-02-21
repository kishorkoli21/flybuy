//
//  FlightBooking.swift
//  SiriExtension
//
//  Created by Sanjana Shahu on 07/05/23.
//

import UIKit
import Intents

let sharedUserDefaults = UserDefaults(suiteName: SharedUserDefaults.suitName)
var isSiriAskedConfirmation = false

class FlightBooking: INExtension, FlightBookingIntentHandling {
   
    func resolveDestination(for intent: FlightBookingIntent, with completion: @escaping (INStringResolutionResult) -> Void) {
        guard let destinationJourney = intent.destination else{
            completion(.needsValue())
            return
        }
        completion(.success(with: destinationJourney))
    }
    
    func resolveDeparture(for intent: FlightBookingIntent, with completion: @escaping (INStringResolutionResult) -> Void) {
        guard let startJourney = intent.departure else{
            completion(.needsValue())
            return
        }
        completion(.success(with: startJourney))
    }
    
    func resolveDate(for intent: FlightBookingIntent, with completion: @escaping (FlightBookingDateResolutionResult) -> Void) {
        
        guard let journeyDate = intent.date else{
            completion(.needsValue())
            return
        }
       // let comps = DateComponents()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        if Calendar.current.date(from: journeyDate ) != nil {
            completion(.success(with: journeyDate))
        }else{
            completion(.unsupported(forReason: .notValid))
        }
    }
    
    func resolveTime(for intent: FlightBookingIntent, with completion: @escaping (INDateComponentsResolutionResult) -> Void) {
        guard let journeyTime = intent.time else{
            completion(.needsValue())
            return
        }
        completion(.success(with: journeyTime))
    }
    
    func resolveTrip(for intent: FlightBookingIntent, with completion: @escaping (INStringResolutionResult) -> Void) {
        guard let trip = intent.trip else{
            completion(.disambiguation(with: ["One Way Trip","Return Trip"]))
            return
        }
        completion(.success(with: trip))
    }
   
    func resolveReturnDate(for intent: FlightBookingIntent, with completion: @escaping (FlightBookingReturnDateResolutionResult) -> Void) {
        if intent.trip == "One Way Trip"{
            completion(.notRequired())
            return
        }
        guard let returnDate = intent.returnDate else{
            completion(.needsValue())
            return
        }
       // let comps = DateComponents()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        if Calendar.current.date(from: returnDate ) != nil {
            completion(.success(with: returnDate))
        }else{
            completion(.unsupported(forReason: .notValid))
        }
    }
    
    func resolveReturnTime(for intent: FlightBookingIntent, with completion: @escaping (INDateComponentsResolutionResult) -> Void) {
        guard let journeyTime = intent.time else{
            completion(.needsValue())
            return
        }
        completion(.success(with: journeyTime))
    }
    
    func resolvePreferredClass(for intent: FlightBookingIntent, with completion: @escaping (INStringResolutionResult) -> Void) {
        guard let journeyClass = intent.preferredClass else{
            completion(.disambiguation(with: ["Economy Class","Business Class"]))
            return
        }
        completion(.success(with: journeyClass))
    }
    
    func resolveConfirm(for intent: FlightBookingIntent, with completion: @escaping (INBooleanResolutionResult) -> Void) {
        guard let confirmation = intent.confirm, confirmation != false else {
            //Siri ask questions only once
            if isSiriAskedConfirmation {
                DispatchQueue.main.asyncAfter(deadline: .now()) {
                    exit(0)
                }
            }
            isSiriAskedConfirmation = true
            completion(INBooleanResolutionResult.confirmationRequired(with: true))
            return
        }
    }
  
    func handle(intent: FlightBookingIntent, completion: @escaping (FlightBookingIntentResponse) -> Void) {
        sharedUserDefaults?.set("siri", forKey: SharedUserDefaults.Keys.from)
        sharedUserDefaults?.set(intent.departure, forKey: SharedUserDefaults.Keys.startJourney)
        sharedUserDefaults?.set(intent.destination, forKey: SharedUserDefaults.Keys.destination)
        sharedUserDefaults?.set(intent.trip, forKey: SharedUserDefaults.Keys.trip)
        sharedUserDefaults?.set(intent.preferredClass, forKey: SharedUserDefaults.Keys.preferredClass)
        guard let from = sharedUserDefaults?.string(forKey: SharedUserDefaults.Keys.from) else {return}
        print(from)
        let comps = DateComponents()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        if let date = Calendar.current.date(from: intent.date ?? comps) {
            let myString = formatter.string(from: date)
            print(myString)
            sharedUserDefaults?.set(myString, forKey: SharedUserDefaults.Keys.date)
        }
        if let time = Calendar.current.date(from: intent.time ?? comps) {
            let myString = formatter.string(from: time)
            print(myString)
            sharedUserDefaults?.set(myString, forKey: SharedUserDefaults.Keys.time)
        }
        if intent.trip == "Return Trip"  {
            if let date = Calendar.current.date(from: intent.returnDate ?? comps) {
                let myString = formatter.string(from: date)
                print(myString)
                sharedUserDefaults?.set(myString, forKey: SharedUserDefaults.Keys.returnDate)
            }
            if let time = Calendar.current.date(from: intent.returnTime ?? comps) {
                let myString = formatter.string(from: time)
                print(myString)
                sharedUserDefaults?.set(myString, forKey: SharedUserDefaults.Keys.returnTime)
            }
        }
        completion(.init(code: .continueInApp, userActivity: nil))
    }
    
 
//    func resolveDestination(for intent: FlightBookingIntent, with completion: @escaping (INStringResolutionResult) -> Void) {
//        guard let destinationJourney = intent.destination else{
//            completion(.needsValue())
//            return
//        }
//        completion(.success(with: destinationJourney))
//    }
//
//    func resolveDeparture(for intent: FlightBookingIntent, with completion: @escaping (INStringResolutionResult) -> Void) {
//        guard let startJourney = intent.departure else{
//            completion(.needsValue())
//            return
//        }
//        completion(.success(with: startJourney))
//    }
//
//
//
//    func resolveDate(for intent: FlightBookingIntent, with completion: @escaping (FlightBookingDateResolutionResult) -> Void) {
//
//        guard let journeyDate = intent.date else{
//            completion(.needsValue())
//            return
//        }
//        let comps = DateComponents()
//        let formatter = DateFormatter()
//        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
//        if let date = Calendar.current.date(from: journeyDate ) {
//            completion(.success(with: journeyDate))
//        }else{
//            completion(.unsupported(forReason: .notValid))
//        }
//
//    }
//
//
//
//    func resolveTime(for intent: FlightBookingIntent, with completion: @escaping (INDateComponentsResolutionResult) -> Void) {
//        guard let journeyTime = intent.time else{
//            completion(.needsValue())
//            return
//        }
//        completion(.success(with: journeyTime))
//    }
//
//    func resolveTrip(for intent: FlightBookingIntent, with completion: @escaping (INStringResolutionResult) -> Void) {
//        guard let trip = intent.trip else{
//            completion(.disambiguation(with: ["One Way Trip","Return Trip"]))
//            return
//        }
//        completion(.success(with: trip))
//    }
//
//    func resolveReturnDate(for intent: FlightBookingIntent, with completion: @escaping (FlightBookingReturnDateResolutionResult) -> Void) {
//        if intent.trip == "One Way Trip"{
//            completion(.notRequired())
//            return
//        }
//        guard let returnDate = intent.returnDate else{
//            completion(.needsValue())
//            return
//        }
//        let comps = DateComponents()
//        let formatter = DateFormatter()
//        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
//        if let date = Calendar.current.date(from: returnDate ) {
//            completion(.success(with: returnDate))
//        }else{
//            completion(.unsupported(forReason: .notValid))
//        }
//    }
//
//    func resolveReturnTime(for intent: FlightBookingIntent, with completion: @escaping (INDateComponentsResolutionResult) -> Void) {
//        if intent.trip == "One Way Trip"{
//            completion(.notRequired())
//            return
//        }
//        guard let returnTime = intent.returnTime else{
//            completion(.needsValue())
//            return
//        }
//        completion(.success(with: returnTime))
//    }
//
//    func resolvePreferredClass(for intent: FlightBookingIntent, with completion: @escaping (INStringResolutionResult) -> Void) {
//        guard let journeyClass = intent.preferredClass else{
//            completion(.disambiguation(with: ["Economy Class","Business Class"]))
//            return
//        }
//        completion(.success(with: journeyClass))
//    }
//
//
//    func resolveConfirm(for intent: FlightBookingIntent, with completion: @escaping (INBooleanResolutionResult) -> Void) {
//        guard let confirmation = intent.confirm, confirmation != false else {
//            //Siri ask questions only once
//            if isSiriAskedConfirmation {
//                DispatchQueue.main.asyncAfter(deadline: .now()) {
//                    exit(0)
//                }
//            }
//            isSiriAskedConfirmation = true
//            completion(INBooleanResolutionResult.confirmationRequired(with: true))
//            return
//        }
//    }
//
//
//
//
//    func handle(intent: FlightBookingIntent, completion: @escaping (FlightBookingIntentResponse) -> Void) {
//        sharedUserDefaults?.set("siri", forKey: SharedUserDefaults.Keys.from)
//        sharedUserDefaults?.set(intent.departure, forKey: SharedUserDefaults.Keys.startJourney)
//        sharedUserDefaults?.set(intent.destination, forKey: SharedUserDefaults.Keys.destination)
//        sharedUserDefaults?.set(intent.trip, forKey: SharedUserDefaults.Keys.trip)
//        sharedUserDefaults?.set(intent.preferredClass, forKey: SharedUserDefaults.Keys.preferredClass)
//        guard let from = sharedUserDefaults?.string(forKey: SharedUserDefaults.Keys.from) else {return}
//        print(from)
//        let comps = DateComponents()
//        let formatter = DateFormatter()
//        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
//        if let date = Calendar.current.date(from: intent.date ?? comps) {
//            let myString = formatter.string(from: date)
//            print(myString)
//            sharedUserDefaults?.set(myString, forKey: SharedUserDefaults.Keys.date)
//        }
//        if let time = Calendar.current.date(from: intent.time ?? comps) {
//            let myString = formatter.string(from: time)
//            print(myString)
//            sharedUserDefaults?.set(myString, forKey: SharedUserDefaults.Keys.time)
//        }
//        if intent.trip == "Return Trip"  {
//            if let date = Calendar.current.date(from: intent.returnDate ?? comps) {
//                let myString = formatter.string(from: date)
//                print(myString)
//                sharedUserDefaults?.set(myString, forKey: SharedUserDefaults.Keys.returnDate)
//            }
//            if let time = Calendar.current.date(from: intent.returnTime ?? comps) {
//                let myString = formatter.string(from: time)
//                print(myString)
//                sharedUserDefaults?.set(myString, forKey: SharedUserDefaults.Keys.returnTime)
//            }
//        }
//        completion(.init(code: .continueInApp, userActivity: nil))
//    }

}

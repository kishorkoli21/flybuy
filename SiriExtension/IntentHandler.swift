//
//  IntentHandler.swift
//  SiriExtension
//
//  Created by Sanjana Shahu on 07/05/23.
//

import Intents

class IntentHandler: INExtension {
    
    override func handler(for intent: INIntent) -> Any {
        // This is the default implementation.  If you want different objects to handle different intents,
        // you can override this and return the handler you want for that particular intent.
        
        if intent is FlightBookingIntent {
            return FlightBooking()
        }
        
        return self
    }
    
}

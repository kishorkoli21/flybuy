//
//  Messages.swift
//  FlyGuy
//
//  Created by Mac on 15/03/23.
//

import Foundation

class Messages{
    
    //MARK: - Validation Messages
    
    static let firstName = "Please enter your First Name"
    static let LastName = "Please enter your Last Name"
    static let DOB = "Please enter your Date of Birth"
    static let gender = "Please select Gender"
    static let Email = "Please enter your Email ID"
    static let OTP = "Please enter OTP"
    static let ValidEmail = "Please enter valid Email Address"
    static let PhoneNumber = "Please enter your Phone Number"
    static let Password = "Please enter Password"
    static let OldPassword = "Please enter Old Password"
    static let NewPassword = "Please enter New Password"
    static let ReenterPassword = "Please re-enter Password"
    static let ValidPassword = "Password must have 4 to 20 characters"
    static let ConfirmPassword = "Please enter Confirm Password"
    static let PasswordMatch = "Password and Confirm Password does not matched"
    static let trip = "Please select Trip"
    static let destination = "Please enter Destination City"
    static let departure = "Please enter Origin City"
    static let departureDate = "Please enter Departure Date"
    static let departureTime = "Please enter Departure Time"
    static let className = "Please select Class"
    static let returnDate = "Please enter Return Date"
    static let returnTime = "Please enter Return Time"
    static let returnDateGreater = "You cannot select Return Date earlier than Departure Date."
    static let validateDepartureDate = "Departure Date should be after 2 Days from now."
    static let pastDate = "You cannot select Past Date"
    static let departureAndReturnDate = "Departure Date and Return Date should not be on same day"
    static let noFlightsFound = "No Flights are available"
    static let emptyData = "Please fill all the information"
    static let validPassanger = "You cannot remove this Passanger"
    static let ageVaildation = "Age should be minimum 18 years"
    static let OnePersonValidation = "Please select atleast one person"
    static let Address = "Please enter Address"
    static let Zipcode = "Please enter Zipcode"
    static let CardNumber = "Please enter Card Number"
    static let ExpirationDate = "Please enter Expiration Date"
    static let SecurityCode = "Please enter Security Code"
    static let City = "Please enter City"
    static let State = "Please enter State"
    
    //MARK: - Side Menu titles
    static let help = "Help"
    static let aboutUs = "About Us"
    static let contactUs = "Contact Us"
    static let UTitle = "U"
    static let cancelledFlightTitle = "Cancelled Flight"
    static let lateFlightTitle = "Late Flight"
    static let delayFlightTitle = "Delay Flight"
    static let lostLuggageTitle = "Lost Luggage"
    
    //MARK: - Home
    static let homeTitle = "Home"
    static let myIssuesTitle = "My Issues"
    static let myTripsTitle = "My Trips"
    static let profileTitle = "Profile"
    
    //MARK: - Onboarding messages
    static let onboardingTitle1 = "Book a flight"
    static let onboardingTitle2 = "Report for flight delays"
    static let onboardingTitle3 = "Report for damaged or lost bags"
    
    static let onboardingDesc1 = "FlyBuy provides optimized flight options so that your flight is least likely to be cancelled, most likely to be on time, with your bags. Additionally, We locate and apply a coupon code."
    static let onboardingDesc2 = "Use your voice to report poor airline performance and hold airlines immediately accountable by revealing and distinguishing consumer worthy airlines."
    static let onboardingDesc3 = "Lost baggage can be a frustrating and stressful experience for travelers. If you've experienced lost baggage, here is a platform to report these issues."
    
    static let elevateYourVoiceTitle = "Elevate your voice"
    static let issueListingTitle = "Issue Listing"
    
    static let flightDelayTitle = "Flight Delay"
    static let flightCancellationTitle = "Flight Cancellation"
    static let lostBaggageTitle = "Lost Baggage"
    static let airlineTitle = "Airline"
    static let selectAirlineTitle = "Select Airline"
    static let flightNumberTitle = "Flight Number"
    static let flightNumberPlaceholderTitle = "Ex : AG-456789"
    static let latenessTitle = "Lateness"
    static let latenessPlaceholderTitle = "Hours After Expected Time"
    static let submitTitle = "Report"
    static let contentSizeTitle = "contentSize"
    static let mediaKitTitle = "Media Kit"
    static let aboutUsDescription = "Look before you book - Avoid disasters by knowing which airlines have the best and worst track record for flight cancellations and delays, lost or damaged bags, and refunds. Report - Use your voice to report poor airline performance and hold airlines immediately accountable by revealing and distinguishing consumer worthy airlines."
//    static let contactUsDescription = "DataScalp Media kits are available by clicking the Media Kit button above. The DataScalp media kit includes quotes, DataScalp rational, information on the founder, and the pitch deck. For an immediate response from our media team, please email to Lisa at Lisa@bospar.com or Kourtney at or Kourtney@Bospar.com for a reply within 20 minutes."
    static let infoButtonMessageTitle = "FlyBuy's support extends to the following airline codes"
    static let mailMessagBody = "Hi. I would like to discuss DataScalp with you at your earliest convenience. Please contact me at the following number."
    static let mailSubject = "DataScalp"
    static let mailRecipient1 = "flybuy@datascalp.com"
    static let mailRecipient2 = "Kourtney@bospar.com"
    static let whatsAppNumber = "+918767680198"
    static let EmptyFlightNumberMessage = "Please enter flight number"
    static let EmptyLatenessMessage = "Please enter lateness"
    
    //MARK: - Side menu images
    static let homeIcon = "HomeIcon-ipad"
    static let myIssuesIcon = "MyIssuesIcon-ipad"
    static let cancelFlightIcon = "CancelFlightIcon-iPad"
    static let lateFlightIcon = "LateFlightIcon"
    static let lostLuggageIcon = "LostLuggage"
    static let contactUsIcon = "ic_Phone"
    //"ContactUs"
    static let aboutUsIcon = "ic_AboutUS_Dark"
    //"AboutUs"
    static let helpIcon = "Help"
    static let profileIcon = "ic_Person"
    //"ic_User_Tab"
   // static let myTripIcon = "ic_Suitcase_Unselected_Tab"
    static let myTripIcon = "ic_Bag"
    
    
    //MARK: - Internet Connection
    static let noInternetConnection = "The internet connection is lost"
    static let noDataFound = "Unable to process request. Try after sometime"
    static let timeOut = "Request timed out. Please try after sometime"
    static let errMsg = "Unable to process request. Please try again"
    static let FlightDetailErr = "Flight Details not available."
    //"No Data found"
    
    
}

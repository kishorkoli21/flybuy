//
//  constatnts.swift
//  FlyGuy
//
//  Created by Mac on 14/03/23.
//

import Foundation

let VIEWMANAGER = ViewManager.shared

class Constants {
    static let tabBarIdentifier = "MainViewTabController"
    static let isShowOnBoardScreen = "isShowOnBoardScreen"
    static let isShowOnBoardScreeniPad = "isShowOnBoardScreeniPad"
    static var deviceType = ""
    static let baseURL = "BASE_URL"
    static let channel = "MOBILE"
    static let sum = "1"
    static let AppName = "FlyGuy"
    static let issueName = "issue_name"
    static let flightNumber = "flight_number"
    static let lateness = "lateness"
    static let incidentNotification = "incidentNotification"
    
    static var notificationIssueNameValue = ""
    static var notificationFlightNumberValue = ""
    static var notificationlateessValue = ""
    static var isFromNotification = false
    static let serviceCharge = "30.0"
    static let paymentGatewayPercentageCharge = 1.81
    static let dataScalp_UserID = "DataScalp_ProdAPI"
    //"datascalp_testAPI"
    static let dataScalp_Password = "DataScalpPWD_ProdAPI@2023"
    //"datascalpTest@2023"
    static let refundAmountDeductionCharge = "39.0"
}

//MARK: Font Names
class Fonts {
    static let SFProTextMedium = "SF-Pro-Text-Medium"
    static let SFProTextRegular = "SF-Pro-Text-Regular"
    static let SFProTextSemiBold = "SF-Pro-Text-SemiBold"
    static let SFProTextBold = "SF-Pro-Text-Bold"
    static let SFProDisplayBold = "SF-Pro-Display-Bold"
    static let SFProDisplayMedium = "SF-Pro-Display-Medium"
}

class Images{
    static let MyIssuesCancelFlightIcon = "CancelledFlightIssue.png"
    static let MyIssuesDelayFlightIcon = "FlightDelayIssue.png"
    static let MyIssuesLostbaggageIcon = "LostLuggageIssue.png"
}

//MARK: Controller Names
class ViewControllers{
    static let HomeViewController = "HomeViewController"
    static let SideMenuViewController = "SideMenuViewController"
    static let OnboardingViewController = "OnboardingViewController"
    static let SplashScreenViewController = "SplashScreenViewController"
    static let IssueListingViewController = "IssueListingViewController"
    static let LostBaggageViewController = "LostBaggageViewController"
    static let FlightCancellationViewController = "FlightCancellationViewController"
    static let FlightDelayViewController = "FlightDelayViewController"
    static let IssueDetailsViewController = "IssueDetailsViewController"
    static let AboutUsViewController = "AboutUsViewController"
    static let ContactUsViewController = "ContactUsViewController"
    static let ipadSideMenuPortraittViewController = "ipadSideMenuPortraittViewController"
    static let AllFlightPopUpViewController = "AllFlightPopUpViewController"
    static let ThankYouViewController = "ThankYouViewController"
    static let MainiPadContainerViewController = "MainiPadContainerViewController"
    static let BookingDetailViewController = "BookingDetailsViewController"
    static let FlightListViewController = "FlightListViewController"
    static let FlightListInboundViewController = "FlightListInboundViewController"
    static let FlightDetailsViewController = "FlightDetailsViewController"
    static let TravelDetailsViewController = "TravelDetailsViewController"
    static let ConfirmDetailsViewController = "ConfirmDetailsViewController"
    static let FlightBookingDetailsViewController = "FlightBookingDetailsViewController"
    static let MyTripViewController = "MyTripViewController"
    static let ProfileViewController = "ProfileViewController"
    static let UpcomingFlightsViewController = "UpcomingFlightsViewController"
    static let SingleFlightDetailViewController = "SingleFlightDetailViewController"
    static let CreateAccountViewController = "CreateAccountViewController"
    static let LoginViewController = "LoginViewController"
    static let VerificationViewController = "VerificationViewController"
    static let SuccessViewController = "SuccessViewController"
    static let ResetPasswordViewController = "ResetPasswordViewController"
    static let ForgotPasswordViewController = "ForgotPasswordViewController"
    static let CancelledFlightViewController = "CancelledFlightViewController"
    static let CompletedFlightsViewController = "CompletedFlightsViewController"
    static let CancelViewController = "CancelViewController"
    static let PaymentGatewayViewController = "PaymentGatewayViewController"
    static let PersonalInfoViewController = "PersonalInfoViewController"
    static let ChangePasswordViewController = "ChangePasswordViewController"
    static let ProceedToCheckoutVC = "ProceedToCheckoutVC"
    static  let AddAddressViewController = "AddAddressViewController"
    static let PaymentViewController = "PaymentViewController"
}

//MARK: Storyboard Names
class Storyboards{
    //MARK: iPhone Storyboard Names
    static let LogInStoryboard = "LogInStoryboard"
    static let HomeStoryboard = "HomeStoryboard"
    static let SplashScreenStoryboard = "SplashScreenStoryboard"
    static let OnboardingStoryboard = "OnboardingStoryboard"
    static let FlightCancellationStoryboard = "FlightCancellationStoryboard"
    static let FlightDelayStoryboard = "FlightDelayStoryboard"
    static let LostBaggageStoryboard = "LostBaggageStoryboard"
    static let IssueDetailsStoryboard = "IssueDetailsStoryboard"
    static let AboutUsStoryboard = "AboutUsStoryboard"
    static let ContactUsStoryboard = "ContactUsStoryboard"
    static let AllFlightPopUpStoryboard = "AllFlightPopUpStoryboard"
    static let ThankYouStoryboard = "ThankYouStoryboard"
    static let BookingDetailStoryboard = "BookingDetailsStoryboard"
    static let FlightListStoryboard = "FlightListStoryboard"
    static let TravelStoryboard = "TravelStoryboard"
    static let ConfirmDetailsStoryboard = "ConfirmDetailsStoryboard"
    static let FlightBookingDetailsStoryboard = "FlightBookingDetailsStoryboard"
    static let UpcomingFlightsStoryboard = "UpcomingFlightsStoryboard"
    static let SingleFlightDetailStoryboard = "SingleFlightDetailStoryboard"
    static let CreateAccountStoryboard = "CreateAccountStoryboard"
    static let PaymentGatewayStoryboard = "PaymentGateway_Storyboard"
    static let ProfileStoryboard = "ProfileStoryboard"
    
    //MARK: iPad Storyboard Names
    static let SplashScreeniPadStoryboard = "SplashScreeniPadStoryboard"
    static let OnboardingiPadStoryboard = "OnboardingiPadStoryboard"
    static let HomeiPadStoryboard = "HomeiPadStoryboard"
    static let ipadSideMenuPortraitStoryboard = "ipadSideMenuPortraitStoryboard"
    static let FlightCancellationiPadStoryboard = "FlightCancellationiPadStoryboard"
    static let FlightDelayiPadStoryboard = "FlightDelayiPadStoryboard"
    static let LostBaggageiPadStoryboard = "LostBaggageiPadStoryboard"
    static let IssueListiPadStoryboard = "IssueListiPadStoryboard"
    static let IssueDetailsiPadStoryboard = "IssueDetailsiPadStoryboard"
    static let AboutUsiPadStoryboard = "AboutUsiPadStoryboard"
    static let ContactUsiPadStoryboard = "ContactUsiPadStoryboard"
    static let AllFlightPopUpiPadStoryboard = "AllFlightPopUpiPadStoryboard"
    static let ThankYouiPadStoryboard = "ThankYouiPadStoryboard"
    static let MainiPadContanerStoryboard = "MainiPadContanerStoryboard"
    static let BookingDetailIpadStoryboard = "BookingDetailsIpadStoryboard"
    static let FlightListIpadStoryboard = "FlightListIpadStoryboard"
    static let TravelIpadStoryboard = "TravelIpadStoryboard"
    static let ConfirmDetailsIpadStoryboard = "ConfirmDetailsIpadStoryboard"
    static let FlightBookingDetailIpadStoryboard = "FlightBookingDetailIpadStoryboard"
    static let MyTripipadStoryboard = "MyTripipadStoryboard"
    static let ProfileIpadStoryboard = "ProfileIpadStoryboard"
    static let UpcomingFlightsIpadStoryboard = "UpcomingFlightsIpadStoryboard"
    static let SingleFlightDetailIpadStoryboard = "SingleFlightDetailIpadStoryboard"
    static let CreateAccountIpadStoryboard = "CreateAccountIpadStoryboard"
    static let PaymentGatewayIpadStoryboard = "PaymentGatewayIpadStoryboard"
}

//MARK: Cell Files Names
class Cells{
    static let SideMenuTableViewCell = "SideMenuTableViewCell"
    static let OnboardingCollectionViewCell = "OnboardingCollectionViewCell"
    static let HomeTableViewCell = "HomeTableViewCell"
    static let HomeiPadTableViewCell = "HomeiPadTableViewCell"
    static let IssueListingTableViewCell = "IssueListingTableViewCell"
    static let AirLineDropDownTableViewCell = "AirLineDropDownTableViewCell"
    static let AllAirlineTableViewCell = "AllAirlineTableViewCell"
    static let AllFlightPopUpTableViewCell = "AllFlightPopUpTableViewCell"
    
    //MARK: iPad Storyboard Cell Names
    static let IssueListingiPadTableViewCell = "IssueListingiPadTableViewCell"
    static let iPadSideMenuTableViewCell = "iPadSideMenuTableViewCell"
    
}

//MARK: API
enum API:String{
    case getAirlineCode  = "api/airlines/fetch"
    case reportIncidents = "api/incidents/create"
    case signup          = "apiv1/auth/signup"  //
    case login           = "apiv1/auth/signin"  //
    case cityList        = "apiv1/flightbooking/searchAirports" //
    case profileUpdate   = "apiv1/auth/usersprofileupdate" //
    case forgotPassword  = "apiv1/auth/forgotpassword"
    case resetPassword   = "apiv1/auth/resetpassword"
    case logout          = "apiv1/auth/signout"
    case flightBooking   = "apiv1/flightbooking/flightsbooking"
    case travelDetails   = "https://travelnext.works/api/aeroVE5-prod/trip_details"
    case travelDetailsNew = "apiv1/flightbooking/tripdetailsapi"
    //"https://travelnext.works/api/aeroVE5/trip_details" //
    case flightBookingList   =  "apiv1/flightbooking/flightbookinglist"
    case flightCancelRefund  = "apiv1/flightbooking/flightcanclerefund"
    case cancelFlight  = "apiv1/flightbooking/flightbookingcancle"
    case downloadTicketApi = "apiv1/flightbooking/flightbookingticket?pnr_id="
    case paymentApi =         "apiv1/flightbooking/Paymentgetway?amount="
    case changePassword = "apiv1/auth/changepassword"
    case airLineList  =   "apiv1/flightbooking/getairlineList"
    case airlineCityList = "apiv1/flightbooking/airlinecitylist"
    case sendMailApi = "apiv1/flightbooking/sendmailflightbooking"
    case voidPayment = "apiv1/flightbooking/voidPaymentgetway"
    case addAirlinePNR = "apiv1/flightbooking/addairlinepnrId?pnr_id="
    case authorizePaymentApi = "apiv1/flightbooking/authorizepaymentgetwaty"
    case voidPaymentAuthorize = "apiv1/flightbooking/authorizevoidnewpaymentgetway"
    case applePayPaymentApi = "apiv1/flightbooking/authorizeapplepaypaymentgetwaty"
    
    case validFare       = "https://travelnext.works/api/aeroVE5-prod/revalidate" // --> PROD
    //case validFare       = "https://travelnext.works/api/aeroVE5/revalidate" // --> TEST
    
    case fareRules       =  "https://travelnext.works/api/aeroVE5-prod/fare_rules" // --> PROD
    //case fareRules       =  "https://travelnext.works/api/aeroVE5/fare_rules" // --> TEST
    
    
    case bookingDetailsCheckField  = "apiv1/flightbooking/checkField"  //
    case airlineLogoApi = "apiv1/flightbooking/getAirLineLogo"  //
}

////MARK: SFSymbolImage
//enum Icon{
//    static let threeDotMenuIcon = "More"
//    static let physicsSubjectLogoIcon = "ic_subject_physics"
//}

enum DeviceType:String {
    case iPhone = "iPhone"
    case iPad = "iPad"
}

enum BasicAuthEnum:String{
    case Username = "2npW4GLCb9i7wOE"
    case Password = "nmiAtgeojfKPP4C"
}

enum IncidentTypeEnum:String{
    case Baggage = "baggage"
    case CancelledFlight = "cancelledFlight"
    case LateFlight = "lateFlight"
}

enum IncidentTypeEnumForNotification:String{
    case LostBaggage = "Lost Luggage"
    case CancelledFlight = "Cancelled Flight"
    case DelayFlight = "Delay Flight"
}

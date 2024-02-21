//
//  PaymentModel.swift
//  FlyGuy
//
//  Created by Springup Labs on 29/06/23.
//

import Foundation

// MARK: - PaymentOutputDTO
struct PaymentOutputDTO: Codable {
    var msg: Int?
    var result: String?
    var errors: ErrorsRevalidate?
}

// MARK: - SendMailInpuDTO
struct SendMailInpuDTO: Codable {
    var pnrID: String?

    enum CodingKeys: String, CodingKey {
        case pnrID = "pnr_id"
    }
}

struct PaymentDetailsStruct {
    var firstName : String?
    var lastName : String?
    var address : String?
    var zipcode : String?
    var state : String?
    var city : String?
}

// MARK: - PaymentAuthorizeInputDTO
struct PaymentAuthorizeInputDTO: Codable {
    var createTransactionRequest: CreateTransactionRequest?
}

// MARK: - CreateTransactionRequest
struct CreateTransactionRequest: Codable {
    var merchantAuthentication: MerchantAuthentication?
    var refID: String?
    var transactionRequest: TransactionRequest?

    enum CodingKeys: String, CodingKey {
        case merchantAuthentication
        case refID = "refId"
        case transactionRequest
    }
}

// MARK: - MerchantAuthentication
struct MerchantAuthentication: Codable {
    var name, transactionKey: String?
}

// MARK: - TransactionRequest
struct TransactionRequest: Codable {
    var transactionType, amount: String?
    var payment: Payment?
    var billTo: BillTo?
}

// MARK: - BillTo
struct BillTo: Codable {
    var firstName, lastName, address, city: String?
    var state, zip: String?
}

// MARK: - Payment
struct Payment: Codable {
    var creditCard: CreditCard?
}

// MARK: - CreditCard
struct CreditCard: Codable {
    var cardNumber, expirationDate, cardCode: String?
}


//// MARK: - PaymentAuthorizeOutputDTO
//struct PaymentAuthorizeOutputDTO: Codable {
//    var msg: Int?
//    var result: ResultAuthorizePayment?
//}
//
//// MARK: - Result
//struct ResultAuthorizePayment: Codable {
//    var id: Int?
//    var trInvoiceNumber, trResponseCode, trAuthCode, trAvsResultCode: String?
//    var trCvvResultCode, trCavvResultCode, trTransID, trRefTransID: String?
//    var trTransHash, trTestRequest, trAccountNumber, trAccountType: String?
//    var trMessages, trTransHashSha2: String?
//    var trSupplementalDataQualificationIndicator: Int?
//    var trNetworkTransID, trRefID, statusMessages, updatedAt: String?
//    var createdAt: String?
//
//    enum CodingKeys: String, CodingKey {
//        case id
//        case trInvoiceNumber = "tr_invoice_number"
//        case trResponseCode = "tr_responseCode"
//        case trAuthCode = "tr_authCode"
//        case trAvsResultCode = "tr_avsResultCode"
//        case trCvvResultCode = "tr_cvvResultCode"
//        case trCavvResultCode = "tr_cavvResultCode"
//        case trTransID = "tr_transId"
//        case trRefTransID = "tr_refTransID"
//        case trTransHash = "tr_transHash"
//        case trTestRequest = "tr_testRequest"
//        case trAccountNumber = "tr_accountNumber"
//        case trAccountType = "tr_accountType"
//        case trMessages = "tr_messages"
//        case trTransHashSha2 = "tr_transHashSha2"
//        case trSupplementalDataQualificationIndicator = "tr_SupplementalDataQualificationIndicator"
//        case trNetworkTransID = "tr_networkTransId"
//        case trRefID = "tr_refId"
//        case statusMessages = "status_messages"
//        case updatedAt, createdAt
//    }
//}

// MARK: - PaymentAuthorizeOutputDTO
struct PaymentAuthorizeOutputDTO: Codable {
    var msg: Int?
    var result: ResultAuthorizePayment?
}

// MARK: - Result
struct ResultAuthorizePayment: Codable {
    var transactionResponse: TransactionResponseAuthorize?
    var refID: String?
    var messages: MessagesAuthorize?

    enum CodingKeys: String, CodingKey {
        case transactionResponse
        case refID = "refId"
        case messages
    }
}

// MARK: - Messages
struct MessagesAuthorize: Codable {
    var resultCode: String?
    var message: [MessagesMessage]?
}

// MARK: - MessagesMessage
struct MessagesMessage: Codable {
    var code, text: String?
}



// MARK: - TransactionResponse
struct TransactionResponseAuthorize: Codable {
    var responseCode, authCode, avsResultCode, cvvResultCode: String?
    var cavvResultCode, transID, refTransID, transHash: String?
    var testRequest, accountNumber, accountType: String?
    var messages: [TransactionResponseMessage]?
    var transHashSha2: String?
    var supplementalDataQualificationIndicator: Int?
    var networkTransID: String?
    var errorsAuthorize: [ErrorAuthorizePayment]?

    enum CodingKeys: String, CodingKey {
        case responseCode, authCode, avsResultCode, cvvResultCode, cavvResultCode
        case transID = "transId"
        case refTransID, transHash, testRequest, accountNumber, accountType, messages, transHashSha2
        case supplementalDataQualificationIndicator = "SupplementalDataQualificationIndicator"
        case networkTransID = "networkTransId"
    }
}

// MARK: - TransactionResponseMessage
struct TransactionResponseMessage: Codable {
    var code, description: String?
}

// MARK: - Error
struct ErrorAuthorizePayment: Codable {
    var errorCode, errorText: String?
}


// MARK: - VoidPaymentAuthorizeInputDTO
struct VoidPaymentAuthorizeInputDTO: Codable {
    var createTransactionRequest: CreateTransactionRequests?
}

// MARK: - CreateTransactionRequest
struct CreateTransactionRequests: Codable {
    var merchantAuthentication: MerchantAuthentications?
    var refID: String?
    var transactionRequest: TransactionRequests?

    enum CodingKeys: String, CodingKey {
        case merchantAuthentication
        case refID = "refId"
        case transactionRequest
    }
}

// MARK: - MerchantAuthentication
struct MerchantAuthentications: Codable {
    var name, transactionKey: String?
}

// MARK: - TransactionRequest
struct TransactionRequests: Codable {
    var transactionType, refTransID: String?

    enum CodingKeys: String, CodingKey {
        case transactionType
        case refTransID = "refTransId"
    }
}


// MARK: - VoidPaymentAuthorizeOutputDTO
struct VoidPaymentAuthorizeOutputDTO: Codable {
    var msg: Int?
    var result: ResultVoidPayment?
}

// MARK: - Result
struct ResultVoidPayment: Codable {
    var transactionResponse: TransactionResponse?
    var refID: String?
    var messages: MessagesVoidPayment?

    enum CodingKeys: String, CodingKey {
        case transactionResponse
        case refID = "refId"
        case messages
    }
}

// MARK: - Messages
struct MessagesVoidPayment: Codable {
    var resultCode: String?
    var message: [Message]?
}

// MARK: - Message
struct Message: Codable {
    var code, text: String?
}

// MARK: - TransactionResponse
struct TransactionResponse: Codable {
    var responseCode, authCode, avsResultCode, cvvResultCode: String?
    var cavvResultCode, transID, refTransID, transHash: String?
    var testRequest, accountNumber, accountType: String?
    var errors: [ErrorsTransact]?
    var transHashSha2: String?
    var supplementalDataQualificationIndicator: Int?

    enum CodingKeys: String, CodingKey {
        case responseCode, authCode, avsResultCode, cvvResultCode, cavvResultCode
        case transID = "transId"
        case refTransID, transHash, testRequest, accountNumber, accountType, errors, transHashSha2
        case supplementalDataQualificationIndicator = "SupplementalDataQualificationIndicator"
    }
}

// MARK: - Error
struct ErrorsTransact: Codable {
    var errorCode, errorText: String?
}


// MARK: - PaymentApplePayInputDTO
struct PaymentApplePayInputDTO: Codable {
    var createTransactionRequest: CreateTransactionRequestApplePay?
}

// MARK: - CreateTransactionRequest
struct CreateTransactionRequestApplePay: Codable {
    var merchantAuthentication: MerchantAuthenticationApplePay?
    var refID: String?
    var transactionRequest: TransactionRequestApplePay?

    enum CodingKeys: String, CodingKey {
        case merchantAuthentication
        case refID = "refId"
        case transactionRequest
    }
}

// MARK: - MerchantAuthentication
struct MerchantAuthenticationApplePay: Codable {
    var name, transactionKey: String?
}

// MARK: - TransactionRequest
struct TransactionRequestApplePay: Codable {
    var transactionType, amount: String?
    var payment: PaymentApplePay?
}

// MARK: - Payment
struct PaymentApplePay: Codable {
    var opaqueData: OpaqueData?
}

// MARK: - OpaqueData
struct OpaqueData: Codable {
    var dataDescriptor, dataValue: String?
}


// MARK: - PaymentApplePayOutputDTO
struct PaymentApplePayOutputDTO: Codable {
    var msg: Int?
    var result: ResultApplePay?
}

// MARK: - Result
struct ResultApplePay: Codable {
    var transactionResponse: TransactionResponseApplePay?
    var refID: String?
    var messages: MessagesApplePay?

    enum CodingKeys: String, CodingKey {
        case transactionResponse
        case refID = "refId"
        case messages
    }
}

// MARK: - Messages
struct MessagesApplePay: Codable {
    var resultCode: String?
    var message: [MessageApplePay]?
}

// MARK: - Message
struct MessageApplePay: Codable {
    var code, text: String?
}

// MARK: - TransactionResponse
struct TransactionResponseApplePay: Codable {
    var responseCode, authCode, avsResultCode, cvvResultCode: String?
    var cavvResultCode, transID, refTransID, transHash: String?
    var testRequest, accountNumber, accountType: String?
    var errors: [ErrorApplePay]?
    var transHashSha2: String?
    var supplementalDataQualificationIndicator: Int?

    enum CodingKeys: String, CodingKey {
        case responseCode, authCode, avsResultCode, cvvResultCode, cavvResultCode
        case transID = "transId"
        case refTransID, transHash, testRequest, accountNumber, accountType, errors, transHashSha2
        case supplementalDataQualificationIndicator = "SupplementalDataQualificationIndicator"
    }
}

// MARK: - Error
struct ErrorApplePay: Codable {
    var errorCode, errorText: String?
}

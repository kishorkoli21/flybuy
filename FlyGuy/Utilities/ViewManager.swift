//
//  ViewManager.swift
//  FlyGuy
//
//  Created by Springup Labs on 25/04/23.
//

import UIKit

class ViewManager: NSObject {
    static let shared = ViewManager()
    
    var flightList = BookingDetailFareInfos()
    var isReturn : Bool = false
    var journeyDate : (String, String, String, String) = ("", "", "", "")
    var journeyRoute : (String, String) = ("", "")
    var loginDetails = LoginOutputDTO()
    var isLogin : Bool = false
    var selectedFlightDetails = Result()
    var isNavigatedFromLoginScreen : Bool = false
    var isCreateAccountFromTabBar : Bool = true
    var paxDetail = PaxDetail()
    var isDOB : Bool = false
    var pnrID : String = ""
    var fareSourceCode : String = ""
    var cancelledFlightList : [Cancellation]?
    var upcomingFlightList : [Cancellation]?
    var completedFlightList : [Cancellation]?
    var fromScreen : String = ""
    var refundAmount : String = ""
    var refundStatus : String = ""
    var selctedInBoundOutBoundFlightDetails : [FareItinerary]?
    var isFromCancel : Bool = false
    var isPassportMandatory : Bool = false
    var TotalTicketPrice : String = ""
    var isRevalidateErr : Bool = false
    var isBackInIpadDelay : Bool = false
    var isBackInIpadLost : Bool = false
    var isBackInIpadCancel : Bool = false
    var isFromLoginBtn : Bool = false
    var bookDataForIpad = BookingDetailsInputDTOIpad()
    var paymentAddressDataIpad = PaymentAddressInputDTOIpad()
    var isShowPaymentAddressForIpad : Bool = true
    var isShowBookingDetailsForIpad : Bool = true
    var paxCount : Int = 0
    var TransactionDetails : (String, String) = ("","")
    var paymentModel = PaymentDetailsStruct()
    var travellerNumber : (String, String, String) = ("", "", "")
    var isTravellerAdded : Bool = false
    
    class func sharedInstance() -> ViewManager {
        return ViewManager.shared
    }
    
    func topMostController() -> UIViewController
    {
        var topViewController: UIViewController?
        if let scene = UIApplication.shared.connectedScenes.first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene {
            if let window = scene.windows.first(where: { $0.isKeyWindow }) {
                topViewController = window.rootViewController
                while true {
                    if let presentedViewController = topViewController?.presentedViewController {
                        topViewController = presentedViewController
                    } else if let navigationController = topViewController as? UINavigationController {
                        topViewController = navigationController.topViewController
                    } else if let tabBarController = topViewController as? UITabBarController {
                        topViewController = tabBarController.selectedViewController
                    } else {
                        break
                    }
                }
            }
        }
        return topViewController!
    }
    
    func showToast(message:String) {
        ToastManager.shared.style.messageFont = UIFont.systemFont(ofSize: 18)
       // UIApplication.shared.keyWindow?.makeToast(message)
        DispatchQueue.main.async {
            if let keyWindow = UIApplication.shared.windows.first {
                keyWindow.makeToast(message)
            }
        }
       
    }
}

class TimePickerView: UIView {
   
    var doneClosure : ((String)->())?
    var baseView : UIView!
    var datePicker : UIDatePicker!
    var isIpad : Bool = false

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        self.alpha = 0;
        if Constants.deviceType == DeviceType.iPad.rawValue{
            isIpad = true
        }
        baseView = UIView(frame: CGRect(x: 0, y: self.frame.size.height, width: isIpad ? 300 : self.frame.size.width, height: 200))
        baseView.backgroundColor = .white
        self.addSubview(baseView)
        
        datePicker = UIDatePicker(frame:CGRect(x: 0, y: 20, width: baseView.frame.size.width, height: 200))
        datePicker.backgroundColor = UIColor.white
        datePicker.datePickerMode = .time
        //et date = startDate.addingTimeInterval(TimeInterval(5.0 * 60.0))
        baseView.addSubview(datePicker)
        
        let btnCancel = UIButton(frame: CGRect(x: 10, y:datePicker.frame.maxY + 10, width:  baseView.frame.size.width/2 - 15, height: 40))
        btnCancel.backgroundColor = UIColor().hexStringToUIColor(hex: AppColor.darkGreyColor)
        btnCancel.setTitle("Cancel", for: .normal)
        btnCancel.layer.cornerRadius = 10
        btnCancel.setTitleColor(.white, for: .normal)
        btnCancel.titleLabel?.font = UIFont(name: Fonts.SFProTextSemiBold, size: 18.0)
        btnCancel.addTarget(self, action: #selector(DatePickerView.btnCancelClicked(sender:)), for: .touchUpInside)
        baseView.addSubview(btnCancel)
        
        let btnDone = UIButton(frame: CGRect(x: btnCancel.frame.maxX + 10, y:btnCancel.frame.minY, width: btnCancel.frame.size.width, height: 40))
        btnDone.backgroundColor = .black
        btnDone.layer.cornerRadius = 10
        btnDone.setTitle("Done", for: .normal)
        btnDone.setTitleColor(.white, for: .normal)
        btnDone.titleLabel?.font = UIFont(name: Fonts.SFProTextSemiBold, size: 18.0)
        btnDone.addTarget(self, action: #selector(DatePickerView.btnDoneClicked(sender:)), for: .touchUpInside)
        baseView.addSubview(btnDone)
        
        UIView.animate(withDuration: 0.2) {
            self.alpha = 1;
            self.baseView.frame.origin.y = self.frame.size.height - self.baseView.frame.size.height
        }
    }
    
    @objc func btnDoneClicked(sender:UIButton)
    {
        let selDate: Date? = datePicker.date
        let dateFormat = DateFormatter()
//        dateFormat.dateFormat = "HH:MM a"
        dateFormat.dateFormat = "hh:mm a"

        var dateString: String? = nil
        if let aDate = selDate {
            dateString = dateFormat.string(from: aDate)
        }
        
        if doneClosure != nil {
            doneClosure!(dateString!)
        }
        hideView()
    }
    
    @objc func btnCancelClicked(sender:UIButton)
    {
        hideView()
    }
    
    func onDoneClicked(back : @escaping (String) -> Void)
    {
        doneClosure = back
    }
    
    func hideView()
    {
        UIView.animate(withDuration: 0.2, animations: {
            self.alpha = 0;
            self.baseView.frame.origin.y = self.frame.size.height
        }) { (completion) in
            self.removeFromSuperview()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
struct AnyCodable: Decodable {
    var value: Any
    
    struct CodingKeys: CodingKey {
        var stringValue: String
        var intValue: Int?
        init?(intValue: Int) {
            self.stringValue = "\(intValue)"
            self.intValue = intValue
        }
        init?(stringValue: String) { self.stringValue = stringValue }
    }
    
    init(value: Any) {
        self.value = value
    }
    
    init(from decoder: Decoder) throws {
        if let container = try? decoder.container(keyedBy: CodingKeys.self) {
            var result = [String: Any]()
            try container.allKeys.forEach { (key) throws in
                result[key.stringValue] = try container.decode(AnyCodable.self, forKey: key).value
            }
            value = result
        } else if var container = try? decoder.unkeyedContainer() {
            var result = [Any]()
            while !container.isAtEnd {
                result.append(try container.decode(AnyCodable.self).value)
            }
            value = result
        } else if let container = try? decoder.singleValueContainer() {
            if let intVal = try? container.decode(Int.self) {
                value = intVal
            } else if let doubleVal = try? container.decode(Double.self) {
                value = doubleVal
            } else if let boolVal = try? container.decode(Bool.self) {
                value = boolVal
            } else if let stringVal = try? container.decode(String.self) {
                value = stringVal
            } else {
                throw DecodingError.dataCorruptedError(in: container, debugDescription: "the container contains nothing serialisable")
            }
        } else {
            throw DecodingError.dataCorrupted(DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Could not serialise"))
        }
    }
}

extension AnyCodable: Encodable {
    func encode(to encoder: Encoder) throws {
        if let array = value as? [Any] {
            var container = encoder.unkeyedContainer()
            for value in array {
                let decodable = AnyCodable(value: value)
                try container.encode(decodable)
            }
        } else if let dictionary = value as? [String: Any] {
            var container = encoder.container(keyedBy: CodingKeys.self)
            for (key, value) in dictionary {
                let codingKey = CodingKeys(stringValue: key)!
                let decodable = AnyCodable(value: value)
                try container.encode(decodable, forKey: codingKey)
            }
        } else {
            var container = encoder.singleValueContainer()
            if let intVal = value as? Int {
                try container.encode(intVal)
            } else if let doubleVal = value as? Double {
                try container.encode(doubleVal)
            } else if let boolVal = value as? Bool {
                try container.encode(boolVal)
            } else if let stringVal = value as? String {
                try container.encode(stringVal)
            } else {
                throw EncodingError.invalidValue(value, EncodingError.Context.init(codingPath: [], debugDescription: "The value is not encodable"))
            }
            
        }
    }
}



class DatePickerView: UIView {
    
    var doneClosure : ((String)->())?
    var baseView : UIView!
    var time : String!
    var datePicker : UIDatePicker!
    var isIpad : Bool = false
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        self.alpha = 0;
        if Constants.deviceType == DeviceType.iPad.rawValue{
            isIpad = true
        }
        baseView = UIView(frame: CGRect(x: 0, y: self.frame.size.height, width: isIpad ? 300 : self.frame.size.width, height: 250))
        baseView.backgroundColor = .white
        self.addSubview(baseView)
        
        datePicker = UIDatePicker(frame:CGRect(x: 0, y: 20, width: baseView.frame.size.width, height: 200))
        datePicker.backgroundColor = UIColor.white
        datePicker.datePickerMode = .date
        if !ViewManager.shared.isDOB{
            //datePicker.minimumDate = Date()
            // Create a date component representing 48 hours
            var dateComponent = DateComponents()
            dateComponent.hour = 48
            let futureDate = Calendar.current.date(byAdding: dateComponent, to: Date())
            datePicker.minimumDate = futureDate
        }else{
            datePicker.maximumDate = Date()
        }
        baseView.addSubview(datePicker)
        
        let btnCancel = UIButton(frame: CGRect(x: 10, y:datePicker.frame.maxY + 10, width:  baseView.frame.size.width/2 - 15, height: 40))
        btnCancel.backgroundColor = UIColor().hexStringToUIColor(hex: AppColor.darkGreyColor)
        btnCancel.layer.cornerRadius = 10
        btnCancel.setTitle("Cancel", for: .normal)
        btnCancel.setTitleColor(.white, for: .normal)
        btnCancel.titleLabel?.font = UIFont(name: Fonts.SFProTextSemiBold, size: 18.0)
        btnCancel.addTarget(self, action: #selector(DatePickerView.btnCancelClicked(sender:)), for: .touchUpInside)
        baseView.addSubview(btnCancel)
       
        let btnDone = UIButton(frame: CGRect(x: btnCancel.frame.maxX + 10, y:btnCancel.frame.minY, width: btnCancel.frame.size.width, height: 40))
        btnDone.backgroundColor = .black
        btnDone.setTitle("Done", for: .normal)
        btnDone.layer.cornerRadius = 10
        btnDone.setTitleColor(.white, for: .normal)
        btnDone.titleLabel?.font = UIFont(name: Fonts.SFProTextSemiBold, size: 18.0)
        btnDone.addTarget(self, action: #selector(DatePickerView.btnDoneClicked(sender:)), for: .touchUpInside)
        baseView.addSubview(btnDone)
        
        UIView.animate(withDuration: 0.2) {
            self.alpha = 1;
            self.baseView.frame.origin.y = self.frame.size.height - self.baseView.frame.size.height
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func btnDoneClicked(sender:UIButton)
    {
        if time == "time"{
            let selDate: Date? = datePicker.date
            let dateFormat = DateFormatter()
            dateFormat.dateFormat = "HH:mm"
            var dateString: String? = nil
            if let aDate = selDate {
                dateString = dateFormat.string(from: aDate)
            }
            
            if doneClosure != nil {
                doneClosure!(dateString!)
            }
        }else{
                let selDate: Date? = datePicker.date
                let dateFormat = DateFormatter()
                dateFormat.dateFormat = "MM-dd-yyyy"
                var dateString: String? = nil
                if let aDate = selDate {
                    dateString = dateFormat.string(from: aDate)
                }
                
                if doneClosure != nil {
                    doneClosure!(dateString!)
                }
        }
       
        hideView()
    }
    
    @objc func btnCancelClicked(sender:UIButton)
    {
       hideView()
    }
 
    func onDoneClicked(back : @escaping (String) -> Void)
    {
        doneClosure = back
    }
    
    func hideView()
    {
        UIView.animate(withDuration: 0.2, animations: {
            self.alpha = 0;
            self.baseView.frame.origin.y = self.frame.size.height
        }) { (completion) in
            self.removeFromSuperview()
        }
    }

}

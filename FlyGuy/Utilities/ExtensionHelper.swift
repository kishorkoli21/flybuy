//
//  ExtensionHelper.swift
//  FlyGuy
//
//  Created by Mac on 15/03/23.
//

import Foundation
import UIKit

protocol Traceable {
    var cornerRadius: CGFloat { get set }
    var borderColor: UIColor? { get set }
    var borderWidth: CGFloat { get set }
}

extension UIView: Traceable {

    @IBInspectable var cornerRadius: CGFloat {
        get { return layer.cornerRadius }
        set {
            layer.masksToBounds = true
            layer.cornerRadius = newValue
        }
    }

    @IBInspectable var borderColor: UIColor? {
        get {
            guard let cgColor = layer.borderColor else { return nil }
            return  UIColor(cgColor: cgColor)
        }
        set { layer.borderColor = newValue?.cgColor }
    }

    @IBInspectable var borderWidth: CGFloat {
        get { return layer.borderWidth }
        set { layer.borderWidth = newValue }
    }
    
    func addShadowForCell(){
        layer.shadowColor = UIColor().hexStringToUIColor(hex: "#00000029").cgColor
        //layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 2.0)
        layer.shadowRadius = 3
        layer.shadowOpacity = 0.4
        layer.masksToBounds = false
        //layer.cornerRadius = 8
    }
    
    func addShadowForiPadCell(){
        layer.shadowColor = UIColor().hexStringToUIColor(hex: "#000000").withAlphaComponent(0.8).cgColor
        //layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 10.0)
        layer.shadowRadius = 8
        layer.shadowOpacity = 0.2
        layer.masksToBounds = false
        //layer.cornerRadius = 8
    }
    
    func removeShadowForiPadCell(){
        layer.shadowColor = UIColor().hexStringToUIColor(hex: "#000000").withAlphaComponent(0.8).cgColor
        //layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowRadius = 8
        layer.shadowOpacity = 0
        layer.masksToBounds = false
        //layer.cornerRadius = 8
    }
    
    func addShadow(){
       // layer.shadowColor = UIColor().hexStringToUIColor(hex: "#00000029").cgColor
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        layer.shadowRadius = 3
        layer.shadowOpacity = 0.6
        layer.masksToBounds = false
        //layer.cornerRadius = 8
    }
    
}

//MARK: - UIColor Extensions

extension UIColor {
    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}

extension UIViewController:UIGestureRecognizerDelegate {
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}

extension UIImageView {
  func setImageColor(color: UIColor) {
    let templateImage = self.image?.withRenderingMode(.alwaysTemplate)
    self.image = templateImage
    self.tintColor = color
  }
}


extension UILabel {
    func underline() {
        if let textString = self.text {
          let attributedString = NSMutableAttributedString(string: textString)
            attributedString.addAttribute(NSAttributedString.Key.underlineStyle,
                                          value: NSUnderlineStyle.single.rawValue,
                                          range: NSRange(location: 0, length: attributedString.length))
          attributedText = attributedString
        }
    }
}

//MARK: - Date Extensions
extension Date {
    static func getCurrentDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        return dateFormatter.string(from: Date())
    }
    
    static func getCurrentTime() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"
        return dateFormatter.string(from: Date())
    }
}

extension String
{
    func trimString()->String
    {
        return self.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines)
    }
    
    func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
    
    var floatValue: Float {
           return (self as NSString).floatValue
    }
}


extension String {
    var match: Bool {
        return range(of:"^[A-Za-z]{2}\\d{3}$", options:.regularExpression) != nil
    }
}

extension UIView
{
    func enableAutoLayout(){
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func topMargin(pixels:CGFloat){
        let constraints = NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: self.superview, attribute: .top, multiplier: 1.0, constant: pixels)
        self.superview?.addConstraint(constraints)
    }
    
    func bottomMargin(pixels:CGFloat){
        let constraints = NSLayoutConstraint(item: self, attribute:.bottom, relatedBy: .equal, toItem: self.superview, attribute: .bottom, multiplier: 1.0, constant: -pixels)
        self.superview?.addConstraint(constraints)
    }
    
    func leadingMargin(pixels:CGFloat){
        let constraints = NSLayoutConstraint(item: self, attribute:.leading, relatedBy: .equal, toItem: self.superview, attribute: .leading, multiplier: 1.0, constant: pixels)
        self.superview?.addConstraint(constraints)
    }
    
    func trailingMargin(pixels:CGFloat){
        let constraints = NSLayoutConstraint(item: self, attribute:.trailing, relatedBy: .equal, toItem: self.superview, attribute: .trailing, multiplier: 1.0, constant: -pixels)
        self.superview?.addConstraint(constraints)
    }
    
    func fixedWidth(pixels:CGFloat){
        let constraints = NSLayoutConstraint(item: self, attribute:.width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1.0, constant: pixels)
        self.superview?.addConstraint(constraints)
    }
    
    func fixedHeight(pixels:CGFloat){
        let constraints = NSLayoutConstraint(item: self, attribute:.height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1.0, constant: pixels)
        self.superview?.addConstraint(constraints)
    }
    
    func addToLeftToView(view:UIView,pixels:CGFloat){
        let constraints = NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1.0, constant: pixels)
        self.superview?.addConstraint(constraints)
    }
    
    func addToRightToView(view:UIView,pixels:CGFloat){
        let constraints = NSLayoutConstraint(item: self, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1.0, constant: pixels)
        self.superview?.addConstraint(constraints)
    }
   
    func belowToView(view:UIView,pixels:CGFloat){
        let constraints = NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1.0, constant: pixels)
        self.superview?.addConstraint(constraints)
    }
    
    func aboveToView(view:UIView,pixels:CGFloat){
        let constraints = NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1.0, constant: pixels)
        self.superview?.addConstraint(constraints)
    }
    
    func centerX()
    {
        let constraints = NSLayoutConstraint(item: self, attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: .equal, toItem: self.superview, attribute: NSLayoutConstraint.Attribute.centerX, multiplier: 1.0, constant: 0.0)
        self.superview?.addConstraint(constraints)
    }
    
    func centerX(toView:UIView,pixels:CGFloat)
    {
        let constraints = NSLayoutConstraint(item: self, attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: .equal, toItem: toView, attribute: NSLayoutConstraint.Attribute.centerX, multiplier: 1.0, constant: pixels)
        self.superview?.addConstraint(constraints)
    }
    
    func centerY()
    {
        let constraints = NSLayoutConstraint(item: self, attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: .equal, toItem: self.superview, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 1.0, constant: 0.0)
        self.superview?.addConstraint(constraints)
    }
    
    func centerY(toView:UIView,pixels:CGFloat)
    {
        let constraints = NSLayoutConstraint(item: self, attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: .equal, toItem: toView, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 1.0, constant: pixels)
        self.superview?.addConstraint(constraints)
    }
}


extension UIDevice {
    
    /**
     Returns device ip address. Nil if connected via celluar.
     */
    func getIP() -> String? {
        
        var address: String?
        var ifaddr: UnsafeMutablePointer<ifaddrs>?
        
        if getifaddrs(&ifaddr) == 0 {
            
            var ptr = ifaddr
            while ptr != nil {
                defer { ptr = ptr?.pointee.ifa_next } // memory has been renamed to pointee in swift 3 so changed memory to pointee
                
                guard let interface = ptr?.pointee else {
                    return nil
                }
                let addrFamily = interface.ifa_addr.pointee.sa_family
                if addrFamily == UInt8(AF_INET) || addrFamily == UInt8(AF_INET6) {
                    
                    guard let ifa_name = interface.ifa_name else {
                        return nil
                    }
                    let name: String = String(cString: ifa_name)
                    
                    if name == "en0" {  // String.fromCString() is deprecated in Swift 3. So use the following code inorder to get the exact IP Address.
                        var hostname = [CChar](repeating: 0, count: Int(NI_MAXHOST))
                        getnameinfo(interface.ifa_addr, socklen_t((interface.ifa_addr.pointee.sa_len)), &hostname, socklen_t(hostname.count), nil, socklen_t(0), NI_NUMERICHOST)
                        address = String(cString: hostname)
                    }
                    
                }
            }
            freeifaddrs(ifaddr)
        }
        
        return address
    }
    
}

//
//  ActivityIndicator.swift
//  Learning App
//
//  Created by Paptronics_Mac on 21/04/22.
//

import Foundation
import UIKit

var activityView  : UIView?
var ai = UIActivityIndicatorView()

extension UIViewController{
    
    func showSpinner(){
        if activityView != nil {
                    stopSpinner()
                }
        activityView = UIView(frame: self.view.bounds)
        activityView?.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        ai = UIActivityIndicatorView(style: .large)
        ai.center = activityView!.center
        ai.startAnimating()
        ai.color = UIColor().hexStringToUIColor(hex: AppColor.loaderBlue)
        activityView?.addSubview(ai)
        self.view.addSubview(activityView!)
//        activityView = UIActivityIndicatorView(frame: UIScreen.main.bounds)
//        activityView?.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
//        activityView?.style = .large
//        activityView?.color = UIColor().hexStringToUIColor(hex: AppColor.loaderBlue)
//        VIEWMANAGER.topMostController().view.addSubview(activityView!)
//        activityView?.startAnimating()
    }
    
    func stopSpinner()
    {
        if activityView != nil {
            DispatchQueue.main.async {
                ai.stopAnimating()
                activityView?.removeFromSuperview()
                activityView = nil
            }
        }
    }

}



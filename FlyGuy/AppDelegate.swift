//
//  AppDelegate.swift
//  FlyGuy
//
//  Created by Mac on 14/03/23.
//

import UIKit
import IQKeyboardManagerSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        IQKeyboardManager.shared.enable = true

//        UNUserNotificationCenter.current().delegate = self
//        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
//            if granted {
//                print("User gave permissions for local notifications")
//            }
//        }
        
        return true
    }
    
    // MARK: UISceneSession Lifecycle
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    
}


@available(iOS 10, *)
extension AppDelegate : UNUserNotificationCenterDelegate {
    
    // Receive displayed notifications for iOS 10 devices.
//    func userNotificationCenter(_ center: UNUserNotificationCenter,
//                                willPresent notification: UNNotification,
//                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
//
//        completionHandler([.badge, .alert, .sound])
//
//        let userInfo = notification.request.content.userInfo
//        print("user info is in willPresent",userInfo)
//        let userInfoDict = userInfo as NSDictionary
//
//        let issueName = userInfoDict.value(forKey: Constants.issueName) as? String ?? ""
//        let flightNumber = userInfoDict.value(forKey: Constants.flightNumber) as? String ?? ""
//        let lateness = userInfoDict.value(forKey: Constants.lateness) as? String ?? ""
//
//        Constants.notificationIssueNameValue = issueName
//        Constants.notificationFlightNumberValue = flightNumber
//        Constants.notificationlateessValue = lateness
//        Constants.isFromNotification = true
//
//        print("issueName is in notification",issueName)
//        print("flightNumber is in notification",flightNumber)
//        print("lateness is in notification",lateness)
//
//        if Constants.deviceType == DeviceType.iPhone.rawValue{
//            moveToTabBar()
//        }else{
//            moveToMainContaineripadVC()
//        }
//
//    }
    
//    func userNotificationCenter(_ center: UNUserNotificationCenter,
//                                didReceive response: UNNotificationResponse,
//                                withCompletionHandler completionHandler: @escaping () -> Void) {
//
//        let userInfo = response.notification.request.content.userInfo
//        let userInfoDict = userInfo as NSDictionary
//
//        let issueName = userInfoDict.value(forKey: Constants.issueName) as? String ?? ""
//        let flightNumber = userInfoDict.value(forKey: Constants.flightNumber) as? String ?? ""
//        let lateness = userInfoDict.value(forKey: Constants.lateness) as? String ?? ""
//
//        print("issueName is in notification",issueName)
//        print("flightNumber is in notification",flightNumber)
//        print("lateness is in notification",lateness)
//
//        Constants.notificationIssueNameValue = issueName
//        Constants.notificationFlightNumberValue = flightNumber
//        Constants.notificationlateessValue = lateness
//        Constants.isFromNotification = true
//
//        if Constants.deviceType == DeviceType.iPhone.rawValue{
//            moveToTabBar()
//        }else{
//            moveToMainContaineripadVC()
//        }
//
//        completionHandler()
//
//    }
    
    func moveToTabBar(){
        let storyBoard : UIStoryboard = UIStoryboard(name: Storyboards.HomeStoryboard, bundle:nil)
        let tabBarViewController = storyBoard.instantiateViewController(withIdentifier: Constants.tabBarIdentifier) as! UITabBarController
        let navigationController = UINavigationController(rootViewController: tabBarViewController)
        if let window = UIApplication.shared.delegate?.window {
               window?.rootViewController = navigationController
        }
    }
    
    func moveToMainContaineripadVC(){
        let storyBoard : UIStoryboard = UIStoryboard(name: Storyboards.MainiPadContanerStoryboard, bundle:nil)
        let MainContaineriPadVC = storyBoard.instantiateViewController(withIdentifier: ViewControllers.MainiPadContainerViewController) as! MainiPadContainerViewController
        let navigationController = UINavigationController(rootViewController: MainContaineriPadVC)
        if let window = UIApplication.shared.delegate?.window {
               window?.rootViewController = navigationController
        }
    }
    
}

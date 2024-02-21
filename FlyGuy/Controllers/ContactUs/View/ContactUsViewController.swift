//
//  ContactUsViewController.swift
//  FlyGuy
//
//  Created by Mac on 20/03/23.
//

import UIKit
import MessageUI

class ContactUsViewController: BaseViewController, MFMailComposeViewControllerDelegate {

    @IBOutlet weak var sideMenuContactUsContainerView: UIView!
    @IBOutlet weak var contactUsTextLabel: UILabel!
    @IBOutlet weak var contactUsDescLabel: UILabel!
    @IBOutlet weak var mediaKitButton: UIButton!
    @IBOutlet weak var mailOneLabel: UILabel!
    @IBOutlet weak var mailTwoLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.statusBarBackgroundColor(colorHex: AppColor.statusBarColor)
    }
    
    //MARK: Send Email
    func sendEmail() {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients([Messages.mailRecipient1])
            mail.setSubject("")
            mail.setMessageBody("", isHTML: false)
            present(mail, animated: true)
        } else {
            // show failure alert
            //self.view.makeToast("Can't send email")
        }
    }
    
    //MARK: - MFMail compose method
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        
        switch result {
        case .cancelled:
            print("Mail cancelled")
        case .saved:
            print("Mail saved")
        case .sent:
            print("Mail sent")
        case .failed:
            print("Mail sent failure: \(error?.localizedDescription ?? "")")
        default:
            break
        }
        
        controller.dismiss(animated: true)
    }
    
    //MARK: - Open Whatsapp method
    
    private func openWhatsApp() {
           let phoneNumber = Messages.whatsAppNumber
           
           if let whatsappURL = URL(string: "https://wa.me/\(phoneNumber)") {
               if UIApplication.shared.canOpenURL(whatsappURL) {
                   UIApplication.shared.open(whatsappURL, options: [:], completionHandler: nil)
               } else {
                   let alertController = UIAlertController(title: "Alert!", message: "WhatsApp is not installed on the device", preferredStyle: .alert)
                   let OKAction = UIAlertAction(title: "OK", style: .default) {
                       (action: UIAlertAction!) in
                       print("Ok button tapped");
                   }
                   alertController.addAction(OKAction)
                   self.present(alertController, animated: true, completion: nil)
               }
           }
       }
    
    //MARK: - Button Action method
    
    @IBAction func backButtonClicked(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func mediaKitButtonClicked(_ sender: UIButton) {
        openWhatsApp()
    }
    
    @IBAction func btnGmailClicked(_ sender: Any) {
        sendEmail()
    }
    
}

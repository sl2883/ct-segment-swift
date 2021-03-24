//
//  ViewController.swift
//  CT3Test
//
//  Created by Sunny Ladkani on 3/22/21.
//

import UIKit
import CleverTapSDK
//
import Segment_CleverTap

class ViewController: UIViewController, CleverTapDisplayUnitDelegate {
    
    var loginState: Int = 1
    var profileState: Int = 1
    var viewedState: Int = 1
    var purchasedState: Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        CleverTap.sharedInstance()?.setDisplayUnitDelegate(self)
    }

    func displayUnitsUpdated(_ displayUnits: [CleverTapDisplayUnit]) {
           // you will get display units here
        var units:[CleverTapDisplayUnit] = displayUnits;
        
            // Create Notification Content
          let notificationContent = UNMutableNotificationContent()

          // Configure Notification Content
          notificationContent.title = "Flat Rs.50 cashback with Paytm UPI"
          //notificationContent.subtitle = "Local Notifications"
          notificationContent.body = "Make your first Paytm UPI payment to get Rs. 50 cashback"
          let notificationTrigger = UNTimeIntervalNotificationTrigger(timeInterval: 1.0, repeats: false)

          // Create Notification Request
          let notificationRequest = UNNotificationRequest(identifier: "cocoacasts_local_notification", content: notificationContent, trigger: notificationTrigger)

          // Add Request to User Notification Center
          UNUserNotificationCenter.current().add(notificationRequest) { (error) in
              if let error = error {
                  print("Unable to Add Notification Request (\(error), \(error.localizedDescription))")
              }
          }
        
    }

    
    private func login(num: Int) {
        
        let name = "Sunny iOS Test3 A"
        
        let profile: Dictionary<String, Any> = [
            "Name": name + String(num),
            "Identity": String(num),
            "MSG-email": true,
            "MSG-push": true,                       // Enable push notifications
            "MSG-sms": false,                       // Disable SMS notifications
            "MSG-dndPhone": true,                  // Opt out phone number from SMS
            "MSG-dndEmail": false,
        ]

        Analytics.shared().identify(String(num), traits: ["name": name])
        CleverTap.sharedInstance()?.onUserLogin(profile)
    }
    
    private func profile(num: Int) {
        let profile: Dictionary<String, Any> = [
            "Email": "sunnyiostest3a" + String(num) + "@gmail.com",
            "Random": String(Int.random(in: 1..<100))
        ]

        CleverTap.sharedInstance()?.profilePush(profile)
    }
    
    private func dateFormater() -> String{
        let formatter = DateFormatter()
        // initially set the format based on your datepicker date / server String
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"

        let myString = formatter.string(from: Date()) // string purpose I add here
        // convert your string to date
        let yourDate = formatter.date(from: myString)
        //then again set the date format whhich type of output you need
        formatter.dateFormat = "dd-MMM-yyyy"
        // again convert your date to string
        let myStringafd = formatter.string(from: yourDate!)
        
        return myStringafd
    }
    
    private func productViewed(num: Int) {
        let email = "sunnyiostest3a" + String(num) + "@gmail.com"
        let product_name = "Watch " + String(num)
        
        let props:Dictionary<String, Any> = [
            "Email": email,
            "Product name": product_name,
            "Category": "Mens Accessories",
            "Price": 59.99,
            "Date": NSDate()
        ]
        
        let newDate:NSDate = NSDate()
        Analytics.shared().track("Product viewed", properties: ["Email": email,
                                                                "Product name": product_name,
                                                                "Category": "Mens Accessories",
                                                                "Price": 59.99,
                                                                "Date": dateFormater()])
//
        CleverTap.sharedInstance()?.recordEvent("Product viewed", withProps: props)
    }
    
    private func productPurchased(num: Int) {
        let email = "sunnyiostest3a" + String(num) + "@gmail.com"
        let product_name = "Watch " + String(num)
        
        let props:Dictionary<String, Any> = [
            "Email": email,
            "Product name": product_name,
            "Category": "Mens Accessories",
            "Price": 59.99,
            "Date": NSDate()
        ]
        
        let newDate:NSDate = NSDate()
        Analytics.shared().track("Product purchased", properties: ["Email": email,
                                                                "Product name": product_name,
                                                                "Category": "Mens Accessories",
                                                                "Price": 59.99,
                                                                "Date": dateFormater()])
        CleverTap.sharedInstance()?.recordEvent("Product purchased", withProps: props)
    }
    
    @IBAction func loginClicked(sender: UIButton) {
        print("Login: ", loginState)
        login(num: loginState)
    }
    
    @IBAction func profileClicked(sender: UIButton) {
        print("Profle: ", profileState)
        profile(num: profileState)
    }
    
    @IBAction func viewedClicked(sender: UIButton) {
        print("Viewed: ", viewedState)
        productViewed(num: viewedState)
        
    }
    
    @IBAction func purchasedClicked(sender: UIButton) {
        print("Purchased: ", purchasedState)
        productPurchased(num: purchasedState)
    }
    
    @IBAction func clearCacheClicked(sender: UIButton) {
        UserDefaults.standard.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
    }
    
    @IBAction func printCacheClicked(sender: UIButton) {
        print(UserDefaults.standard.dictionaryRepresentation())
    }
    
    @IBAction func loginIndexChanged(sender: UISegmentedControl) {
        loginState = sender.selectedSegmentIndex + 1
    }
    
    @IBAction func profileIndexChanged(sender: UISegmentedControl) {
        profileState = sender.selectedSegmentIndex + 1
    }
    
    @IBAction func viewedIndexChanged(sender: UISegmentedControl) {
        viewedState = sender.selectedSegmentIndex + 1
    }
    
    @IBAction func purchasedIndexChanged(sender: UISegmentedControl) {
        purchasedState = sender.selectedSegmentIndex + 1
    }

}


//
//  ViewController.swift
//  NewNotifications
//
//  Created by Matt Tripodi on 7/9/17.
//  Copyright © 2017 Matt Tripodi. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController {

	override func viewDidLoad() {
		super.viewDidLoad()
		
		// 1. REQUEST PERMISSION
		UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound], completionHandler: { (granted, error) in
		
			if granted {
				print("Notification access granted")
			} else {
				print(error?.localizedDescription)
			}
		})
	}
	
	@IBAction func notifyButtonTapped(sender: UIButton) {
		scheduleNotification(inSeconds: 5, completion:  { (success) in
			if success {
				print("Successfully scheduled notification")
			} else {
				print("Error scheduling notification")
			}
		})
	}
	
	func scheduleNotification(inSeconds: TimeInterval, completion: @escaping (_ Success: Bool) -> ()) {
		
		// Add an attachment 
		let myImage = "rick_grimes"
		guard let imageURL = Bundle.main.url(forResource: myImage, withExtension: "gif") else {
			completion(false)
			return
		}
		
		var attachment: UNNotificationAttachment
		
		attachment = try! UNNotificationAttachment(identifier: "myNotification", url: imageURL, options: .none)
		
		let notif = UNMutableNotificationContent()
		
		// ONLY FOR EXTENTION 
		notif.categoryIdentifier = "myNotificationCategory"
		
		notif.title = "New Notification"
		notif.subtitle = "These are great!"
		notif.body = "The new notification options in iOS 10 are what I've always dreamed of!"
		
		notif.attachments = [attachment]
		
		let notifTrigger = UNTimeIntervalNotificationTrigger(timeInterval: inSeconds, repeats: false)
		
		let request = UNNotificationRequest(identifier: "myNotification", content: notif, trigger: notifTrigger)
		
		UNUserNotificationCenter.current().add(request, withCompletionHandler: { error in
			if error != nil {
				print(error)
				completion(false)
			} else {
				completion(true)
			}
		
		})
	}
}


//
//  NotificationViewController.swift
//  PushTemplateExtension
//
//  Created by Tahreem on 22/10/21.
//

import UIKit
import UserNotifications
import UserNotificationsUI
import MORichNotification

class NotificationViewController: UIViewController, UNNotificationContentExtension {

    @IBOutlet var label: UILabel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any required interface initialization here.
        // Set App Group ID
                MORichNotification.setAppGroupID("group.com.tahreem.DemoMoengageTestAppGroup")
        
    }
    
    func didReceive(_ notification: UNNotification) {
        self.label?.text = notification.request.content.body
        // Method to add template to UI
                MOPushTemplateHandler.sharedInstance().addPushTemplate(to: self, with: notification)
    }

}

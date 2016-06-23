//
//  StartViewController.swift
//  QuickBloxIntegrationGiude
//
//  Created by Alexander Matrosov on 6/23/16.
//  Copyright © 2016 Alexander Matrosov. All rights reserved.
//

import Foundation

class StartViewController : UIViewController
{
  // MARK: Main Actions
  @IBAction func onPressedLoginAsFirstUser(sender: AnyObject)
  {
    QIGServiceLayer.sharedInstance.chatManager.authorizeUser("matrosovtest", password: "abc12345678", userName: "Alex Test") { (error) in
      self.performSegueWithIdentifier("QIGSegueShowNewChat", sender: nil)
    }
  }
  
  @IBAction func onPressedLoginAsSecondUser(sender: AnyObject)
  {
    QIGServiceLayer.sharedInstance.chatManager.authorizeUser("matrosov.entertainment", password: "abc12345678", userName: "Alex Entertainment") { (error) in
      
    }
  }
}

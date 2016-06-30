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
  struct Constants {
    
    struct Segue {
      static let segueShowChats = "QIGSegueShowSelectUserToChat"
    }
    
    struct UserCredentional {
      static let login1 = "matrosovtest"
      static let password1 = "abc12345678"
      static let userName1 = "Alex Test"
      
      static let login2 = "matrosov.entertainment"
      static let password2 = "abc12345678"
      static let userName2 = "Alex Entertainment"
      
      static let login3 = "thirduser"
      static let password3 = "abc12345678"
      static let userName3 = "3rd user"
    }
  }
  
  // MARK: Main Actions
  @IBAction func onPressedLoginAsFirstUser(sender: AnyObject)
  {
    QIGServiceLayer.sharedInstance.chatManager.authorizeUser(Constants.UserCredentional.login1,
                                                             password: Constants.UserCredentional.password1,
                                                             userName: Constants.UserCredentional.userName1) { (error) in
                                                              
      self.performSegueWithIdentifier(Constants.Segue.segueShowChats, sender: nil)
    }
  }
  
  @IBAction func onPressedLoginAsSecondUser(sender: AnyObject)
  {
    QIGServiceLayer.sharedInstance.chatManager.authorizeUser(Constants.UserCredentional.login2,
                                                             password: Constants.UserCredentional.password2,
                                                             userName: Constants.UserCredentional.userName2) { (error) in
                                                              
      self.performSegueWithIdentifier(Constants.Segue.segueShowChats, sender: nil)
    }
  }
  
  @IBAction func onPressedLoginAsThirdUser(sender: AnyObject)
  {
    QIGServiceLayer.sharedInstance.chatManager.authorizeUser(Constants.UserCredentional.login3,
                                                             password: Constants.UserCredentional.password3,
                                                             userName: Constants.UserCredentional.userName3) { (error) in
                                                              
      self.performSegueWithIdentifier(Constants.Segue.segueShowChats, sender: nil)
    }
  }
}

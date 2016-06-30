//
//  QIGUsersManager.swift
//  QuickBloxIntegrationGiude
//
//  Created by Alexander Matrosov on 6/23/16.
//  Copyright © 2016 Alexander Matrosov. All rights reserved.
//

import Foundation

class QIGUsersManager
{
  struct Constants {
     static let QuickBloxUserId = "QuickBloxUserId"
  }
  
  private var userDefaults: NSUserDefaults
  
  init()
  {
    userDefaults = NSUserDefaults.standardUserDefaults()
  }
  
  func saveQuickBloxUserId(userId:UInt?)
  {
    var objectToStore: NSNumber? = nil
    if let unwrappedUserId = userId {
      objectToStore = NSNumber(unsignedLong: unwrappedUserId)
    }
    userDefaults.setObject(objectToStore, forKey: Constants.QuickBloxUserId)
    userDefaults.synchronize()
  }
  
  func quickBloxUserId() -> UInt
  {
    let userId = userDefaults.objectForKey(Constants.QuickBloxUserId)
    
    return userId as! UInt
  }
}
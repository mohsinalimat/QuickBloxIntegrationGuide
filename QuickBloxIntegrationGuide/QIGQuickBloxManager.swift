//
//  QBSettings.swift
//  QuickBloxIntegrationGiude
//
//  Created by Alexander Matrosov on 6/21/16.
//  Copyright © 2016 Alexander Matrosov. All rights reserved.
//

import Foundation

protocol QIGChatManagerProtocol
{
  func applyChatSettings()
  func authorizeUser(login: String, password: String, userName: String, completion:((error:NSError?) -> Void)?)
}

class QIGQuickBloxManager: QIGChatManagerProtocol
{
  // QuickBlox Integration Guide. Step 2. Set auth keys and secret for using QuickBlox.
  func applyChatSettings()
  {
    QBSettings.setApplicationID(QIGConstants.QuickBloxAuthSettings.kQBApplicationID)
    QBSettings.setAuthKey(QIGConstants.QuickBloxAuthSettings.kQBAuthKey)
    QBSettings.setAuthSecret(QIGConstants.QuickBloxAuthSettings.kQBAuthSecret)
    QBSettings.setAccountKey(QIGConstants.QuickBloxAuthSettings.kQBAccountKey)
    QBSettings.setCarbonsEnabled(true)
    QBSettings.setLogLevel(QBLogLevel.Nothing)
    QBSettings.enableXMPPLogging()
    QBSettings.setChatDNSLookupCacheEnabled(true);
  }
  
  // QuickBlox Integration Guide. Step 3. Authorize QuickBlox user.
  func authorizeUser(login: String, password: String, userName: String, completion:((error:NSError?) -> Void)? = nil)
  {
    let userToLogIn = QBUUser()
    userToLogIn.login = login
    userToLogIn.password = password
    userToLogIn.fullName = userName
    
    let successClosure = {
      if let currentUser = QMServicesManager.instance().currentUser() {
        QIGServiceLayer.sharedInstance.usersManager.saveQuickBloxUserId(currentUser.ID)
      }
      completion?(error: nil)
    }
    
    let errorClosure = { (error: NSError) -> Void in
      completion?(error: error)
    }
    
    dispatch_async(dispatch_get_main_queue()) {
      QMServicesManager.instance().logInWithUser(userToLogIn) { (success, errorMessage) in
        if !success {
          print("Failed to log in the chat user with error:\(errorMessage). Trying to register")
          QMServicesManager.instance().authService.signUpAndLoginWithUser(userToLogIn, completion: { (responce, regUser) in
            if let error = responce.error?.error {
              errorClosure(error)
            } else {
              successClosure()
            }
          })
        } else {
          successClosure()
        }
      }
    };
  }
}


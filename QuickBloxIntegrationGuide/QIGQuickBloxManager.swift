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
  func downloadCurrentEnvironmentUsers(successBlock:(([QBUUser]?) -> Void)?, errorBlock:((NSError) -> Void)?)
  func createPrivateChat(name: String?, users:[QBUUser], completion: ((response: QBResponse?, createdDialog: QBChatDialog?) -> Void)?)
}

class QIGQuickBloxManager: QIGChatManagerProtocol
{
  struct Constants {
    static let enviroment = "dev"
  }
  
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
  
  // QuickBlox Integration Guide. Step 4. Get QuickBlox users list.
  func downloadCurrentEnvironmentUsers(successBlock:(([QBUUser]?) -> Void)?, errorBlock:((NSError) -> Void)?)
  {
    QMServicesManager.instance().usersService.searchUsersWithTags([Constants.enviroment]).continueWithBlock {
      (task : BFTask!) -> AnyObject! in
      
      if let error = task.error {
        errorBlock?(error)
        return nil
      }
      
      let users = QMServicesManager.instance().usersService.usersMemoryStorage.unsortedUsers()
      
      let filteredUsers = self.filteredUsers(users)
      
      successBlock?(filteredUsers)
      
      return nil
    }
  }
  
  func filteredUsers(users: [QBUUser]) -> [QBUUser]
  {
    let filteredUsers = users.filter({($0 as QBUUser).ID != QIGServiceLayer.sharedInstance.usersManager.quickBloxUserId()})
    
    return filteredUsers
  }
  
  // QuickBlox Integration Guide. Step 5. Create QuickBlox private chat.
  func createPrivateChat(name: String?, users:[QBUUser], completion: ((response: QBResponse?, createdDialog: QBChatDialog?) -> Void)?)
  {
    QMServicesManager.instance().chatService.createPrivateChatDialogWithOpponent(users.first!, completion: { (response: QBResponse?, chatDialog: QBChatDialog?) -> Void in
      
      completion?(response: response, createdDialog: chatDialog)
    })
  }
}


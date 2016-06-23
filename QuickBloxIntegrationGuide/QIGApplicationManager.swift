//
//  QIGApplicationManager.swift
//  QuickBloxIntegrationGiude
//
//  Created by Alexander Matrosov on 6/23/16.
//  Copyright © 2016 Alexander Matrosov. All rights reserved.
//

import Foundation

class QIGApplicationManager : NSObject
{
  
}

extension QIGApplicationManager: UIApplicationDelegate
{
  func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool
  {
    QIGServiceLayer.sharedInstance.chatManager.applyChatSettings()
    return true
  }
  
  func applicationWillTerminate(application: UIApplication)
  {
  }
  
  func applicationDidBecomeActive(application: UIApplication)
  {
  }
  
  func application(application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData)
  {
  }
  
  func application(application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: NSError)
  {
  }
  
  func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject])
  {
  }
}
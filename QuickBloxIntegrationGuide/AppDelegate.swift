//
//  AppDelegate.swift
//  QuickBloxIntegrationGiude
//
//  Created by Alexander Matrosov on 6/21/16.
//  Copyright © 2016 Alexander Matrosov. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?
  lazy var applicationManager: UIApplicationDelegate = {
    let applicationManager = QIGApplicationManager()
    return applicationManager
  }()

  func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool
  {
    return self.applicationManager.application?(application, didFinishLaunchingWithOptions: launchOptions) ?? false
  }

  func applicationWillResignActive(application: UIApplication)
  {
  }

  func applicationDidEnterBackground(application: UIApplication)
  {
  }

  func applicationWillEnterForeground(application: UIApplication)
  {
  }

  func applicationDidBecomeActive(application: UIApplication)
  {
  }

  func applicationWillTerminate(application: UIApplication)
  {
  }
}


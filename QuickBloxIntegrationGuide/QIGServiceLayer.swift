//
//  QIGServiceLayer.swift
//  QuickBloxIntegrationGiude
//
//  Created by Alexander Matrosov on 6/23/16.
//  Copyright © 2016 Alexander Matrosov. All rights reserved.
//

import Foundation

class QIGServiceLayer
{
  static let sharedInstance = QIGServiceLayer()
  
  private(set) var usersManager: QIGUsersManager!
  private(set) var chatManager: QIGChatManagerProtocol!
  
  private init()
  {
    usersManager = QIGUsersManager()
    chatManager = QIGQuickBloxManager()
  }
}
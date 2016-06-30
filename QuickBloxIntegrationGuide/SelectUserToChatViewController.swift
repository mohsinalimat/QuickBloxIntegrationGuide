//
//  DialogsViewController.swift
//  QuickBloxIntegrationGuide
//
//  Created by Alexander Matrosov on 6/30/16.
//  Copyright © 2016 Alexander Matrosov. All rights reserved.
//

import Foundation

class SelectUserToChatViewController : UIViewController
{
  struct Consts {
    struct CellIdentifier {
      static let userCellIdentifier = "userCell"
    }
    
    struct Chat {
      static let chatName = "Test"
    }
  }
  
  @IBOutlet weak var usersTableView: UITableView!
  @IBOutlet weak var unreadMessages: UILabel!
  
  var users : [QBUUser] = []
  
  override func viewDidLoad()
  {
    super.viewDidLoad()
    
    self.navigationItem.setHidesBackButton(true, animated: false)
    
    self.updateUserList()
  }
  
  override func viewWillAppear(animated: Bool)
  {
    super.viewWillAppear(animated)
    updateUnreadMessagesCount()
  }
  
  func updateUnreadMessagesCount()
  {
    QMServicesManager.instance().chatService.allDialogsWithPageLimit(UInt.max, extendedRequest: ["type":String(QBChatDialogType.Private.rawValue)], iterationBlock: { (response, dialogObjects, userIDs, stop) in
      
      guard let unwrappedDialogObjects = dialogObjects else {
        return
      }
      
      var totalUnreadMessageCount : UInt = 0
      
      for dialog in unwrappedDialogObjects {
        totalUnreadMessageCount = totalUnreadMessageCount + dialog.unreadMessagesCount
      }
      
      self.unreadMessages.text = "Unread messages count: \(totalUnreadMessageCount)"
    })
  }
  
  func updateUserList()
  {
    QIGServiceLayer.sharedInstance.chatManager.downloadCurrentEnvironmentUsers({ (foundUsers: [QBUUser]?) -> Void in
      
      guard let unwrappedUsers = foundUsers else {
        return
      }
      
      self.users = unwrappedUsers
      
      self.usersTableView.reloadData()
      
    }) { (error: NSError!) -> Void in
      print("Error while fetching users.")
    }
  }
  
  // MARK: UITableViewDataSource
  func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return users.count;
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
  {
    let cell = tableView.dequeueReusableCellWithIdentifier(Consts.CellIdentifier.userCellIdentifier, forIndexPath: indexPath)
    
    let user = self.users[indexPath.row]
    
    cell.textLabel?.text = user.fullName
    
    return cell
  }
  
  // MARK: UITableViewDelegate
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
  {
    QIGServiceLayer.sharedInstance.chatManager.createPrivateChat(Consts.Chat.chatName, user: self.users[indexPath.row]) { (response, createdDialog) in
      self.openNewDialog(createdDialog)
    }
  }
  
   // QuickBlox Integration Guide. Step 6. Open QuickBlox private chat.
  func openNewDialog(dialog: QBChatDialog!)
  {
    let chatVC = ChatViewController()
    chatVC.dialog = dialog
    
    self.navigationController?.pushViewController(chatVC, animated: true)
  }
  
  @IBAction func logout(sender: AnyObject)
  {
    if !QBChat.instance().isConnected() {
      return
    }
    
    QMServicesManager.instance().logoutWithCompletion {
      self.navigationController?.popToRootViewControllerAnimated(true)
    }
  }
}
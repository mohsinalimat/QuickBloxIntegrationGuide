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
  
  var users : [QBUUser] = []
  
  override func viewDidLoad()
  {
    super.viewDidLoad()
    
    self.updateUserList()
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
    QIGServiceLayer.sharedInstance.chatManager.createPrivateChat(Consts.Chat.chatName, users: self.users) { (response, createdDialog) in
      self.openNewDialog(createdDialog)
    }
  }
  
  func openNewDialog(dialog: QBChatDialog!)
  {
    let chatVC = ChatViewController()
    chatVC.dialog = dialog
    
    self.navigationController?.pushViewController(chatVC, animated: true)
  }
}
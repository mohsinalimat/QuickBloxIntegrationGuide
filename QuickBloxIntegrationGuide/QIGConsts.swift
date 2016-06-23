//
//  QIGConsts.swift
//  QuickBloxIntegrationGiude
//
//  Created by Alexander Matrosov on 6/21/16.
//  Copyright © 2016 Alexander Matrosov. All rights reserved.
//

import Foundation

struct QIGConstants {
  
  // QuickBlox Integration Guide. Step 1. Declare auth keys and secret
  // Where to get keys and secret (replace YOUR_APP_ID in provide link with yours):
  // https://admin.quickblox.com/apps/YOUR_APP_ID/edit
  // Original guide: http://quickblox.com/developers/5_Minute_Guide
  
  struct QuickBloxAuthSettings {
    static let kQBApplicationID:UInt = 42433
    static let kQBAuthKey = "9Q2YPaOCBMGCBaV"
    static let kQBAuthSecret = "FuM6G73rpv-K8SQ"
    static let kQBAccountKey = "wAHCHexnV2qdgSeazMeU"
  }
}
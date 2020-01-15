//
//  RegisterItem.swift
//  Errand
//
//  Created by Jim on 2020/1/15.
//  Copyright © 2020 Jim. All rights reserved.
//

import Foundation

enum FbMessage: String {
  
  case emptyToken = "Empty Token"
  
  case fbloginError = "FB Login Err"
}

enum RegistMessage: String {
  
  case emptyAccount = "EmptyAccount"
  
  case emptyPassword = "EmptyPassword"
  
  case emptyConfirm = "EmptyConfirm"
  
  case emptyNickname = "Empty Nickname"
  
  case illegalAccount = "IllegalAccount"
  
  case confirmWrong = "ConfirmWrong"
  
  case registFailed = "Regist Fail"
  
  case registSuccess = "Regist Success"
  
}

struct AccountInfo {
  
  let email: String
  
  let password: String
  
  let gender: Int
  
  let nickName: String
  
  let friends: [String]
  
  var toDict: [String: Any] {
    
    return [  "email": email,
              
            "password": password,
            
            "nickname": nickName,
            
            "gender": gender,
            
            "friends": friends
          ]
  }
}

struct FbData {
  
  var name: String
  
  var image: URL
}

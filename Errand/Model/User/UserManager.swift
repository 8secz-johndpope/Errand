//
//  UserManager.swift
//  Errand
//
//  Created by Jim on 2020/1/15.
//  Copyright © 2020 Jim. All rights reserved.
//

import Foundation
import FBSDKLoginKit
import Firebase
import FirebaseAuth

class UserManager {
  
  static let shared = UserManager()
  
  let dbF = Firestore.firestore()
  
  var FBData: FbData?
  
  private init() { }
  
  func registAccount(account: String, password: String, gender: Int, nickName: String, controller: UIViewController) {
    
    Auth.auth().createUser(withEmail: account, password: password) { (_, error) in
      
      if error != nil {
        
        LKProgressHUD.showFailure(text: RegistMessage.registFailed.rawValue, view: controller)
        
      } else {
        
        let friends: [String] = []
        
        let userId = Auth.auth().currentUser?.uid
        
        let info = AccountInfo(email: account, password: password, gender: gender, nickName: nickName, friends: friends)
        
        self.dbF.collection("Users").document(account).setData(info.toDict) { error in
          
          if error != nil {
            
            LKProgressHUD.showFailure(text: RegistMessage.registFailed.rawValue, view: controller)
            
          } else {
            
            LKProgressHUD.showSuccess(text: RegistMessage.registSuccess.rawValue, view: controller)
            
            UserDefaults.standard.set(account, forKey: "account")
            
            UserDefaults.standard.set(password, forKey: "password")
            
            UserDefaults.standard.set(true, forKey: "login")
            
            UserDefaults.standard.set(userId, forKey: "userid")
            
            guard let userInfoVc = controller.storyboard?.instantiateViewController(identifier: "userinfo") as? UserInfoViewController else { return }
            
            controller.modalPresentationStyle = .overCurrentContext
            
            controller.present(userInfoVc, animated: true, completion: nil)
            
          }
        }
      }
    }
  }
  
  func fbLogin(controller: UIViewController) {
    
    let manager = LoginManager()
    
    manager.logIn(permissions: ["email"], from: controller) { (result, _) in
      
      guard let response = result else {
        
        LKProgressHUD.showFailure(text: FbMessage.fbloginError.rawValue, view: controller)
        
        return }
      
      guard let accessToken = response.token?.tokenString else {
        
        LKProgressHUD.showFailure(text: FbMessage.emptyToken.rawValue, view: controller)
        
        return
        
      }
      
      self.loadFBProfile(controller: controller)
      
      
      
      guard let mapPage = UIStoryboard(name: "Content", bundle: nil).instantiateViewController(identifier: "map") as? MapViewController else { return }
      
      controller.present(mapPage, animated: true, completion: nil)
    
    }
  }
  
  func loadFBProfile(controller: UIViewController) {
    
    Profile.loadCurrentProfile { (profile, error) in
      
      if error != nil {
        
        LKProgressHUD.showFailure(text: FbMessage.fbloginError.rawValue, view: controller)
        
        return
        
      } else {
        
        guard let profile = profile,
          let profileName = profile.name,
          let profilePicture = profile.imageURL(forMode: .normal, size: CGSize(width: 300, height: 300)) else {
            
            LKProgressHUD.showFailure(text: FbMessage.fbloginError.rawValue, view: controller)
            
            return }
        
        self.FBData = FbData(name: profileName, image: profilePicture)
        
      }
    }
  }
  
  func loginFireBaseWithFB(accesstoken: String) {
    
    let credit = FacebookAuthProvider.credential(withAccessToken: accesstoken)
    
    Auth.auth().signIn(with: credit) { (user, error) in
      <#code#>
    }
  }
  
}

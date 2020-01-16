//
//  ViewController.swift
//  Errand
//
//  Created by Jim on 2020/1/15.
//  Copyright © 2020 Jim. All rights reserved.
//

import UIKit
import FirebaseAuth
import FBSDKLoginKit

class ViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setUpBtn()
    
  }
  
  @IBOutlet weak var fbLoginBtn: UIButton!
  
  @IBOutlet weak var visitorRegisterBtn: UIButton!
  
  @IBAction func fbLoginAct(_ sender: Any) {
    
    UserManager.shared.fbLogin(controller: self) { result in
      
      switch result {
        
      case .success(let accessToken):
        
        UserManager.shared.loginFireBaseWithFB(accesstoken: accessToken, controller: self) { result in
          
          switch result {
            
          case .success(let okk):
            
            print(okk)
            
            UserManager.shared.loadFBProfile(controller: self) { result in
              
              switch result {
                
              case .success:
                
                guard let userInfoVc = self.storyboard?.instantiateViewController(identifier: "userinfo") as? UserInfoViewController else { return }
                
                self.present(userInfoVc, animated: true, completion: nil)
                
              case .failure(let error):
                
                LKProgressHUD.showFailure(text: error.localizedDescription, controller: self)
              }
            }
            
            LKProgressHUD.showSuccess(text: okk, controller: self)
            
          case .failure(let error):
            
            print(error.localizedDescription)
            
          }
        }
        
      case .failure(let error):
        
        LKProgressHUD.showFailure(text: error.localizedDescription, controller: self)
        
      }
    }
    
  }
  
  @IBAction func visitorRegisterAct(_ sender: Any) {
    
    performSegue(withIdentifier: "register", sender: nil)
    
  }
  
  func setUpBtn() {
    
    fbLoginBtn.layer.cornerRadius = 20
    
    visitorRegisterBtn.layer.cornerRadius = 20
    
  }
  
}

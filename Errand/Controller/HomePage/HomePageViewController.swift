//
//  ViewController.swift
//  Errand
//
//  Created by Jim on 2020/1/15.
//  Copyright © 2020 Jim. All rights reserved.
//

import UIKit
import GoogleSignIn
import FirebaseAuth
import FBSDKLoginKit

class ViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setUpBtn()
    
    NotificationCenter.default.addObserver(self, selector: #selector(goToUserInfo), name: Notification.Name("userInfo"), object: nil)
  }
  
  @IBOutlet weak var fbLoginBtn: UIButton!
  
  @IBOutlet weak var visitorRegisterBtn: UIButton!
  
  @IBOutlet weak var googleLoginBtn: UIButton!
  
  @IBAction func googleLoginAct(_ sender: Any) {
    
    GIDSignIn.sharedInstance()?.signIn()
    
  }
  
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
    
    googleLoginBtn.layer.cornerRadius = 20
    
    GIDSignIn.sharedInstance()?.presentingViewController = self
  }
  
  @objc func goToUserInfo () {
    
    guard let userInfoVc = self.storyboard?.instantiateViewController(identifier: "userinfo") as? UserInfoViewController else { return }
    
    self.present(userInfoVc, animated: true, completion: nil)
  }
}

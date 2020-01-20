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
  
  @IBOutlet weak var appleLogo: UIImageView!
  
  @IBOutlet weak var appleLoginBtn: UIButton!
  
  @IBAction func appleLoginAct(_ sender: Any) {
  }
  
  @IBAction func googleLoginAct(_ sender: Any) {
    
    GIDSignIn.sharedInstance()?.signIn()
    
  }
  
  @IBAction func fbLoginAct(_ sender: Any) {
    
    UserManager.shared.fbLogin(controller: self) { result in
      
      switch result {
        
      case .success(let accessToken):
        
        UserManager.shared.loginFireBaseWithFB(accesstoken: accessToken, controller: self) { result in
          
          switch result {
            
          case .success:
            
            UserManager.shared.loadFBProfile(controller: self) { result in
              
              switch result {
                
              case .success:
                
                guard let userInfoVc = self.storyboard?.instantiateViewController(identifier: "userinfo") as? UserInfoViewController else { return }
                
                self.present(userInfoVc, animated: true, completion: nil)
                
              case .failure(let error):
                
                LKProgressHUD.showFailure(text: error.localizedDescription, controller: self)
              }
            }
            
            LKProgressHUD.showSuccess(text: "Success", controller: self)
            
          case .failure(let error):
            
             LKProgressHUD.showFailure(text: error.localizedDescription, controller: self)
            
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
    
    fbLoginBtn.titleLabel?.font = UIFont(name: "Helvetica-Bold", size: 24)
    
    visitorRegisterBtn.layer.cornerRadius = 20
    
    visitorRegisterBtn.titleLabel?.font = UIFont(name: "Helvetica-Bold", size: 24)
    
    googleLoginBtn.layer.cornerRadius = 20
    
    googleLoginBtn.titleLabel?.font = UIFont(name: "Helvetica-Bold", size: 24)
    
    appleLoginBtn.layer.cornerRadius = 20
    
    appleLoginBtn.titleLabel?.font = UIFont(name: "Helvetica-Bold", size: 24)
    
    appleLoginBtn.layer.borderWidth = 1.0
    
    appleLoginBtn.layer.borderColor = UIColor.black.cgColor
    
    GIDSignIn.sharedInstance()?.presentingViewController = self
  }
  
  @objc func goToUserInfo () {
    
    guard let userInfoVc = self.storyboard?.instantiateViewController(identifier: "userinfo") as? UserInfoViewController else { return }
    
    self.present(userInfoVc, animated: true, completion: nil)
  }
}

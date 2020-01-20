//
//  RegistViewController.swift
//  Errand
//
//  Created by Jim on 2020/1/15.
//  Copyright © 2020 Jim. All rights reserved.
//

import UIKit
import Firebase
import IQKeyboardManager

class RegistViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setUpView()
    // Do any additional setup after loading the view.
    accountText.text = "1@gmail.com"
    
    passwordText.text = "123456"
    
    confirmText.text = "123456"
    
  }
  
  let dbF = Firestore.firestore()
  
  var gender = 1
  
  @IBOutlet weak var cheatView: UIView!
  
  @IBOutlet weak var accountLabel: UILabel!
  
  @IBOutlet weak var passwordLabel: UILabel!
  
  @IBOutlet weak var confirmLabel: UILabel!
  
  @IBOutlet weak var nickNameLabel: UILabel!
  
  @IBOutlet weak var registerBtn: UIButton!
  
  @IBOutlet weak var nickNameText: UITextField!
  
  @IBOutlet weak var accountText: UITextField!
  
  @IBOutlet weak var passwordText: UITextField!
  
  @IBOutlet weak var confirmText: UITextField!
  
  @IBAction func genderSegmentAct(_ sender: UISegmentedControl) {
    
    switch sender.selectedSegmentIndex {
    case 0:
      
      self.gender = 1
      
    case 1:
      
      self.gender = 0
      
    default:
      
      self.gender = 0
      
    }
    
  }
  
  @IBAction func registAct(_ sender: Any) {
    
    guard let account = accountText.text,
      
      accountText.text != "" else {
        
        LKProgressHUD.showFailure(text: RegistMessage.emptyAccount.rawValue, controller: self)
        
        return }
    
    guard let password = passwordText.text,
      
      passwordText.text != "" else {
        
        LKProgressHUD.showFailure(text: RegistMessage.emptyPassword.rawValue, controller: self)
        
        return }
    
    guard let confirm = confirmText.text,
      
      confirmText.text != "" else {
        
        LKProgressHUD.showFailure(text: RegistMessage.emptyConfirm.rawValue, controller: self)
        
        return }
    
    guard let nickName = nickNameText.text,
      
      nickNameText.text != "" else {
        
        LKProgressHUD.showFailure(text: RegistMessage.emptyNickname.rawValue, controller: self)
        
        return }
    
    if password != confirm {
      
      LKProgressHUD.showFailure(text: RegistMessage.confirmWrong.rawValue, controller: self)
      
    } else {
      
      LKProgressHUD.show(controller: self)
      
      UserManager.shared.registAccount(nickName: nickName, account: account, password: password, gender: self.gender) { result in
        
        switch result {
          
        case .success:
          
          UserManager.shared.createDataBase(classification: "Users", gender: self.gender, nickName: nickName, email: account) { result in
            
            switch result {
              
            case .success:
              
              guard let userInfoVc = UIStoryboard(name: "Content", bundle: nil).instantiateViewController(identifier: "googleMap") as? GoogleMapViewController else { return }
              
              LKProgressHUD.dismiss()
              
              self.present(userInfoVc, animated: true, completion: nil)
              
            case .failure(let error):
              
               LKProgressHUD.showFailure(text: error.localizedDescription, controller: self)
            }
          }
          
        case .failure(let error):
          
          LKProgressHUD.showFailure(text: error.localizedDescription, controller: self)
        }
      }
      
    }
  }
  
  @IBAction func goBackAct(_ sender: Any) {
    
    self.dismiss(animated: true, completion: nil)
    
  }
  
  func setUpView() {
    
    registerBtn.layer.cornerRadius = 20
    
    cheatView.layer.cornerRadius = 20
    
  }
  
}

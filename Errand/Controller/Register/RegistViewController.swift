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
  
  @IBOutlet weak var accountText: UITextField!
  
  @IBOutlet weak var passwordText: UITextField!
  
  @IBOutlet weak var confirmText: UITextField!
  
  @IBOutlet weak var nickNameText: UITextField!
  
  @IBAction func genderSegmentAct(_ sender: UISegmentedControl) {
    
    switch sender.selectedSegmentIndex {
    case 0:
      
      self.gender = 1
      
    default:
      
      self.gender = 0
      
    }
    
  }
  
  @IBAction func registAct(_ sender: Any) {
    
    guard let account = accountText.text,
      
      accountText.text != "" else {
        
        LKProgressHUD.showFailure(text: RegistMessage.emptyAccount.rawValue, view: self)
        
        return }
    
    guard let password = passwordText.text,
      
      passwordText.text != "" else {
        
        LKProgressHUD.showFailure(text: RegistMessage.emptyPassword.rawValue, view: self)
        
        return }
    
    guard let confirm = confirmText.text,
      
      confirmText.text != "" else {
        
        LKProgressHUD.showFailure(text: RegistMessage.emptyConfirm.rawValue, view: self)
        
        return }
    
    guard let nickName = nickNameText.text,
    
    nickNameText.text != "" else {
      
      LKProgressHUD.showFailure(text: RegistMessage.emptyNickname.rawValue, view: self)
      
      return }
    
    if password != confirm {
      
      LKProgressHUD.showFailure(text: RegistMessage.confirmWrong.rawValue, view: self)
      
    } else {
      
      LKProgressHUD.show(view: self)
      
      UserManager.shared.registAccount(account: account, password: password, gender: self.gender, nickName: nickName, controller: self)
      
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

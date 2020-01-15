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
  }
  
  @IBOutlet weak var CheatView: UIView!
  
  @IBOutlet weak var accountLabel: UILabel!
  
  @IBOutlet weak var passwordLabel: UILabel!
  
  @IBOutlet weak var confirmLabel: UILabel!
  
  @IBOutlet weak var registerBtn: UIButton!
  
  @IBOutlet weak var accountText: UITextField!
  
  @IBOutlet weak var passwordText: UITextField!
  
  @IBOutlet weak var confirmText: UITextField!
  
  @IBAction func registAct(_ sender: Any) {

    guard let account = accountText.text,
      
      accountText.text != "" else {
        
        LKProgressHUD.showFailure(text: RegistMessage.EmptyAccount.rawValue, view: self)
        
        return }
    
    guard let password = passwordText.text,
      
      passwordText.text != "" else {
        
        LKProgressHUD.showFailure(text: RegistMessage.EmptyPassword.rawValue, view: self)
        
        return }
    
    guard let confirm = confirmText.text,
      
      confirmText.text != "" else {
        
        LKProgressHUD.showFailure(text: RegistMessage.EmptyConfirm.rawValue, view: self)
        
        return }
    
    if password == confirm {
      
      LKProgressHUD.showFailure(text: RegistMessage.ConfirmWrong.rawValue, view: self)
      
    } else {
      
      registAccount(account: account, password: password)
      
    }
  }
  
  @IBAction func goBackAct(_ sender: Any) {
    
    self.dismiss(animated: true, completion: nil)
    
  }
  
  func setUpView() {
    
    registerBtn.layer.cornerRadius = 20
    
    CheatView.layer.cornerRadius = 20
    
  }
  
  func registAccount(account: String, password: String) {
    
  }
  
}

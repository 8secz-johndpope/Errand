//
//  ViewController.swift
//  Errand
//
//  Created by Jim on 2020/1/15.
//  Copyright © 2020 Jim. All rights reserved.
//

import UIKit
import FBSDKLoginKit

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()

    setUpBtn()

    print("View")
    
  }

  @IBOutlet weak var fbLoginBtn: UIButton!

  @IBOutlet weak var visitorRegisterBtn: UIButton!

  @IBAction func fbLoginAct(_ sender: Any) {
    
    UserManager.shared.fbLogin(controller: self)
      
    }

  @IBAction func visitorRegisterAct(_ sender: Any) {

    performSegue(withIdentifier: "register", sender: nil)

  }

  func setUpBtn() {

    fbLoginBtn.layer.cornerRadius = 20

    visitorRegisterBtn.layer.cornerRadius = 20

  }

}

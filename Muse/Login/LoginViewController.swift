//
//  LoginViewController.swift
//  Muse
//
//  Created by Nicholas Rizzo on 5/26/18.
//  Copyright © 2018 Nicholas Rizzo. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

  weak var coreDataStack: CoreDataStack!
  
  @IBOutlet weak var loginButton: UIButton!
  @IBOutlet weak var createAccountButton: UIButton!
  @IBOutlet weak var skipSignInButton: UIButton!
  @IBOutlet weak var forgotPasswordButton: UIButton!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
  }

  @IBAction private func login() {
    print("login")
    showMuseList()
  }
  
  @IBAction private func createAccount() {
    print("create account")
    showMuseList()
  }
  
  @IBAction private func skipSignIn() {
    print("skip sign in")
    showMuseList()
  }
  
  @IBAction private func forgotPassword() {
    print("Forgot Password")
  }
  
  private func showMuseList() {
    performSegue(withIdentifier: Segues.museList, sender: nil)
  }
  

}


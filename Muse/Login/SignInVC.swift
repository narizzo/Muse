//
//  SignInVC.swift
//  Muse
//
//  Created by Nicholas Rizzo on 5/26/18.
//  Copyright © 2018 Nicholas Rizzo. All rights reserved.
//

import UIKit

class SignInVC: UIViewController {

  weak var coreDataStack: CoreDataStack!
  private var museLabel = UILabel()
  private var usernameField = UITextField()
  private var passwordField = UITextField()
  private var signInButton = UIButton()
  private var createAccountButton = UIButton()
  private var skipSignInButton = UIButton()
  private var forgotPasswordButton = UIButton()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.backgroundColor = UIColor.white
    
    turnOffMasksForUIObjects()
    addSubviews()
    
    NSLayoutConstraint.activate([
      museLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 60),
      museLabel.heightAnchor.constraint(equalToConstant: 64),
      museLabel.widthAnchor.constraint(equalToConstant: 200),
      museLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      
      usernameField.topAnchor.constraint(equalTo: museLabel.bottomAnchor, constant: 50),
      usernameField.heightAnchor.constraint(equalToConstant: 44),
      usernameField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 4/5),
      usernameField.centerXAnchor.constraint(equalTo: museLabel.centerXAnchor),
      
      passwordField.topAnchor.constraint(equalTo: usernameField.bottomAnchor, constant: 12),
      passwordField.heightAnchor.constraint(equalToConstant: 44),
      passwordField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 4/5),
      passwordField.centerXAnchor.constraint(equalTo: usernameField.centerXAnchor),
      
      signInButton.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 30),
      signInButton.heightAnchor.constraint(equalToConstant: 64),
      signInButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 3/5),
      signInButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      
    ])
    
    museLabel.text = "Muse"
    museLabel.textAlignment = .center
    museLabel.font = museLabel.font.withSize(64)
    
    usernameField.attributedPlaceholder = NSAttributedString(string: "Username", attributes: [NSAttributedStringKey.foregroundColor: Theme.colors.lightGray])
    usernameField.backgroundColor = UIColor.orange
    usernameField.returnKeyType = .next
    usernameField.textColor = UIColor.black
    usernameField.font = usernameField.font?.withSize(30)
    
    passwordField.attributedPlaceholder = NSAttributedString(string: "Username", attributes: [NSAttributedStringKey.foregroundColor: Theme.colors.lightGray])
    passwordField.backgroundColor = UIColor.orange
    passwordField.returnKeyType = .next
    passwordField.textColor = UIColor.black
    passwordField.font = usernameField.font?.withSize(30)
    
    signInButton.setTitle("Sign In", for: .normal)
    signInButton.titleLabel?.textAlignment = .center
    signInButton.titleLabel?.font = signInButton.titleLabel?.font.withSize(35)
    signInButton.setTitleColor(UIColor.black, for: .normal)
    signInButton.backgroundColor = UIColor.orange
    
  }
  
  private func turnOffMasksForUIObjects() {
    museLabel.translatesAutoresizingMaskIntoConstraints = false
    usernameField.translatesAutoresizingMaskIntoConstraints = false
    passwordField.translatesAutoresizingMaskIntoConstraints = false
    signInButton.translatesAutoresizingMaskIntoConstraints = false
    createAccountButton.translatesAutoresizingMaskIntoConstraints = false
    skipSignInButton.translatesAutoresizingMaskIntoConstraints = false
    forgotPasswordButton.translatesAutoresizingMaskIntoConstraints = false
  }
  
  private func addSubviews() {
    self.view.addSubview(museLabel)
    self.view.addSubview(usernameField)
    self.view.addSubview(passwordField)
    self.view.addSubview(signInButton)
    self.view.addSubview(createAccountButton)
    self.view.addSubview(skipSignInButton)
    self.view.addSubview(forgotPasswordButton)
  }

  private func signIn() {
    print("login")
    showMuseList()
  }
  
  private func createAccount() {
    print("create account")
    showMuseList()
  }
  
  private func skipSignIn() {
    print("skip sign in")
    showMuseList()
  }
  
  private func forgotPassword() {
    print("Forgot Password")
  }
  
  private func showMuseList() {
    performSegue(withIdentifier: Segues.deckList, sender: nil)
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == Segues.deckList {
      if let destination = segue.destination as? DeckTableViewController {
        destination.coreDataStack = self.coreDataStack
      }
    }
  }
  

}


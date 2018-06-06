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
  private var forgotCredentialsButton = UIButton()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.backgroundColor = UIColor.white
    
    turnOffMasksForUIObjects()
    addSubviews()
    activateConstraints()
    
    setupMuseLabel()
    setupUsernameField()
    setupPasswordField()
    setupSignInButton()
    setupCreateAccountButton()
    setupSkipSignInButton()
    setupForgotCredentialsButton()
  }
  
  private func setupMuseLabel() {
    museLabel.text = "Muse"
    museLabel.textAlignment = .center
    museLabel.font = museLabel.font.withSize(64)
  }
  
  private func setupUsernameField() {
    usernameField.attributedPlaceholder = NSAttributedString(string: "Username", attributes: [NSAttributedStringKey.foregroundColor: Theme.colors.lightGray])
    usernameField.backgroundColor = UIColor.orange
    usernameField.returnKeyType = .next
    usernameField.textColor = UIColor.black
    usernameField.font = usernameField.font?.withSize(30)
  }
  
  private func setupPasswordField() {
    passwordField.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSAttributedStringKey.foregroundColor: Theme.colors.lightGray])
    passwordField.isSecureTextEntry = true
    passwordField.backgroundColor = UIColor.orange
    passwordField.returnKeyType = .done
    passwordField.textColor = UIColor.black
    passwordField.font = usernameField.font?.withSize(30)
  }
  
  private func setupSignInButton() {
    signInButton.setTitle("Sign In", for: .normal)
    signInButton.titleLabel?.textAlignment = .center
    signInButton.titleLabel?.font = signInButton.titleLabel?.font.withSize(35)
    signInButton.setTitleColor(UIColor.black, for: .normal)
    signInButton.backgroundColor = UIColor.orange
    
    signInButton.addTarget(self, action: #selector(signIn), for: .touchUpInside)
  }
  
  private func setupCreateAccountButton() {
    createAccountButton.setTitle("Create Account", for: .normal)
    createAccountButton.titleLabel?.textAlignment = .center
    createAccountButton.titleLabel?.font = signInButton.titleLabel?.font.withSize(35)
    createAccountButton.titleLabel?.adjustsFontSizeToFitWidth = true
    createAccountButton.setTitleColor(UIColor.black, for: .normal)
    createAccountButton.backgroundColor = UIColor.orange
    
    createAccountButton.addTarget(self, action: #selector(createAccount), for: .touchUpInside)
  }
  
  private func setupSkipSignInButton() {
    skipSignInButton.setTitle("Skip Sign In", for: .normal)
    skipSignInButton.titleLabel?.textAlignment = .center
    skipSignInButton.titleLabel?.font = signInButton.titleLabel?.font.withSize(35)
    skipSignInButton.titleLabel?.adjustsFontSizeToFitWidth = true
    skipSignInButton.setTitleColor(UIColor.black, for: .normal)
    skipSignInButton.backgroundColor = UIColor.orange
    
    skipSignInButton.addTarget(self, action: #selector(skipSignIn), for: .touchUpInside)
  }
  
  private func setupForgotCredentialsButton() {
    forgotCredentialsButton.setTitle("Forgot Username or Password", for: .normal)
    forgotCredentialsButton.titleLabel?.textAlignment = .center
    forgotCredentialsButton.titleLabel?.font = signInButton.titleLabel?.font.withSize(35)
    forgotCredentialsButton.titleLabel?.adjustsFontSizeToFitWidth = true
    forgotCredentialsButton.setTitleColor(UIColor.black, for: .normal)
    forgotCredentialsButton.backgroundColor = UIColor.orange
    
    forgotCredentialsButton.addTarget(self, action: #selector(forgotCredentials), for: .touchUpInside)
  }
  
  private func turnOffMasksForUIObjects() {
    museLabel.translatesAutoresizingMaskIntoConstraints = false
    usernameField.translatesAutoresizingMaskIntoConstraints = false
    passwordField.translatesAutoresizingMaskIntoConstraints = false
    signInButton.translatesAutoresizingMaskIntoConstraints = false
    createAccountButton.translatesAutoresizingMaskIntoConstraints = false
    skipSignInButton.translatesAutoresizingMaskIntoConstraints = false
    forgotCredentialsButton.translatesAutoresizingMaskIntoConstraints = false
  }
  
  private func addSubviews() {
    self.view.addSubview(museLabel)
    self.view.addSubview(usernameField)
    self.view.addSubview(passwordField)
    self.view.addSubview(signInButton)
    self.view.addSubview(createAccountButton)
    self.view.addSubview(skipSignInButton)
    self.view.addSubview(forgotCredentialsButton)
  }
  
  private func activateConstraints() {
    NSLayoutConstraint.activate([
      self.museLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 60),
      self.museLabel.heightAnchor.constraint(equalToConstant: 64),
      self.museLabel.widthAnchor.constraint(equalToConstant: 200),
      self.museLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
      
      self.usernameField.topAnchor.constraint(equalTo: self.museLabel.bottomAnchor, constant: 50),
      self.usernameField.heightAnchor.constraint(equalToConstant: 44),
      self.usernameField.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 4/5),
      self.usernameField.centerXAnchor.constraint(equalTo: self.museLabel.centerXAnchor),
      
      self.passwordField.topAnchor.constraint(equalTo: self.usernameField.bottomAnchor, constant: 12),
      self.passwordField.heightAnchor.constraint(equalToConstant: 44),
      self.passwordField.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 4/5),
      self.passwordField.centerXAnchor.constraint(equalTo: self.usernameField.centerXAnchor),
      
      self.signInButton.topAnchor.constraint(equalTo: self.passwordField.bottomAnchor, constant: 30),
      self.signInButton.heightAnchor.constraint(equalToConstant: 64),
      self.signInButton.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 3/5),
      self.signInButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
      
      self.createAccountButton.topAnchor.constraint(equalTo: self.signInButton.bottomAnchor, constant: 12),
      self.createAccountButton.heightAnchor.constraint(equalToConstant: 64),
      self.createAccountButton.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 3/5),
      self.createAccountButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
      
      self.skipSignInButton.topAnchor.constraint(equalTo: self.createAccountButton.bottomAnchor, constant: 30),
      self.skipSignInButton.heightAnchor.constraint(equalToConstant: 60),
      self.skipSignInButton.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 1/2),
      self.skipSignInButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
      
      self.forgotCredentialsButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
      self.forgotCredentialsButton.heightAnchor.constraint(equalToConstant: 60),
      self.forgotCredentialsButton.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 4/5),
      self.forgotCredentialsButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
      ])
  }
  
  
  @objc private func signIn() {
    showDeckTableVC()
  }
  
  @objc private func createAccount() {
    showDeckTableVC()
  }
  
  @objc private func skipSignIn() {
    showDeckTableVC()
  }
  
  @objc private func forgotCredentials() {
    print("forgot Credentials")
  }
  
  private func showDeckTableVC() {
    let deckTableVC = DeckTableViewController()
    let navController = UINavigationController(rootViewController: deckTableVC)
    prepareToPresent(deckTableVC)
    present(navController, animated: true, completion: nil)
  }
  
  private func prepareToPresent(_ vc: UIViewController) {
    if let vc = vc as? DeckTableViewController {
      vc.coreDataStack = self.coreDataStack
    }
  }
  
}


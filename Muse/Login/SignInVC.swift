//
//  SignInVC.swift
//  Muse
//
//  Created by Nicholas Rizzo on 5/26/18.
//  Copyright © 2018 Nicholas Rizzo. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class SignInVC: UIViewController {
  
  weak var coreDataStack: CoreDataStack!
  
  private var museLabel = UILabel()
  private var signInErrorLabel = UILabel()
  
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
  
    setupUI()
  }
  
  // MARK: - UI Masks
  private func turnOffMasksForUIObjects() {
    museLabel.translatesAutoresizingMaskIntoConstraints = false
    signInErrorLabel.translatesAutoresizingMaskIntoConstraints = false
    usernameField.translatesAutoresizingMaskIntoConstraints = false
    passwordField.translatesAutoresizingMaskIntoConstraints = false
    signInButton.translatesAutoresizingMaskIntoConstraints = false
    createAccountButton.translatesAutoresizingMaskIntoConstraints = false
    skipSignInButton.translatesAutoresizingMaskIntoConstraints = false
    forgotCredentialsButton.translatesAutoresizingMaskIntoConstraints = false
  }
  
  // MARK: - Setup UI
  private func setupUI() {
    setupMuseLabel()
    setupSignInErrorLabel()
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
  
  private func setupSignInErrorLabel() {
    signInErrorLabel.adjustsFontSizeToFitWidth = true
    signInErrorLabel.textColor = UIColor.red
    signInErrorLabel.font = signInErrorLabel.font.withSize(20)
    signInErrorLabel.isHidden = true
  }
  
  private func setupUsernameField() {
    usernameField.attributedPlaceholder = NSAttributedString(string: "username", attributes: [NSAttributedStringKey.foregroundColor: Theme.colors.lightGray])
    
    /* will get back to this... custom inset for text and placeholder text -> make custom textField */
    //usernameField.textRect(forBounds: UIEdgeInsetsInsetRect(usernameField.bounds, UIEdgeInsetsMake(0, 15, 0, 15)))
    //usernameField.placeholderRect(forBounds: UIEdgeInsetsInsetRect(usernameField.bounds, UIEdgeInsetsMake(0, 15, 0, 15)))
    
    usernameField.backgroundColor = UIColor.orange
    usernameField.returnKeyType = .next
    usernameField.textColor = UIColor.black
    usernameField.font = usernameField.font?.withSize(23)
  }
  
  private func setupPasswordField() {
    passwordField.attributedPlaceholder = NSAttributedString(string: "password", attributes: [NSAttributedStringKey.foregroundColor: Theme.colors.lightGray])
    passwordField.isSecureTextEntry = true
    passwordField.backgroundColor = UIColor.orange
    passwordField.returnKeyType = .done
    passwordField.textColor = UIColor.black
    passwordField.font = usernameField.font?.withSize(23)
  }
  
  private func setupSignInButton() {
    //signInButton.isEnabled = false
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
  
  // MARK: - Subviews
  private func addSubviews() {
    self.view.addSubview(museLabel)
    self.view.addSubview(signInErrorLabel)
    self.view.addSubview(usernameField)
    self.view.addSubview(passwordField)
    self.view.addSubview(signInButton)
    self.view.addSubview(createAccountButton)
    self.view.addSubview(skipSignInButton)
    self.view.addSubview(forgotCredentialsButton)
  }
  
  // MARK: - Constraints
  private func activateConstraints() {
    NSLayoutConstraint.activate([
      self.museLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 60),
      self.museLabel.heightAnchor.constraint(equalToConstant: 64),
      self.museLabel.widthAnchor.constraint(equalToConstant: 200),
      self.museLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
      
      self.signInErrorLabel.topAnchor.constraint(equalTo: self.museLabel.bottomAnchor, constant: 38),
      self.signInErrorLabel.heightAnchor.constraint(equalToConstant: 40),
      self.signInErrorLabel.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 4/5),
      self.signInErrorLabel.centerXAnchor.constraint(equalTo: self.museLabel.centerXAnchor),
      
      self.usernameField.topAnchor.constraint(equalTo: self.signInErrorLabel.bottomAnchor, constant: 8),
      self.usernameField.heightAnchor.constraint(equalToConstant: 44),
      self.usernameField.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 4/5),
      self.usernameField.centerXAnchor.constraint(equalTo: self.signInErrorLabel.centerXAnchor),
      
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
  
  
  // MARK: - Button Calls
  @objc private func signIn() {
    // start test code
    usernameField.text = "nrizzo414@gmail.com"
    passwordField.text = "myfakepassword"
    // end test code
    
    if let email = usernameField.text, let password = passwordField.text {
      Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
        if error != nil {
          print("failed to sign in: \(error)")
          self.showSignInError()
        } else {
          print("signed in")
          self.showDeckTableVC()
        }
      }
    }
  }
  
  private func showSignInError() {
    signInErrorLabel.text = "Invalid username or password"
    signInErrorLabel.isHidden = false
  }
  
  @objc private func createAccount() {
    if let email = usernameField.text, let password = passwordField.text {
      Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
        if error != nil {
          print("failed to create new account: \(error)")
          self.showSignInError()
        } else {
          print("Created an account")
          self.showDeckTableVC()
        }
      }
    }
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


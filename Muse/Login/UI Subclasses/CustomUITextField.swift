//
//  CustomUITextField.swift
//  Muse
//
//  Created by Nicholas Rizzo on 6/15/18.
//  Copyright © 2018 Nicholas Rizzo. All rights reserved.
//

import UIKit

class CustomUITextField: UITextField {

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    
    translatesAutoresizingMaskIntoConstraints = false
  }
  
  override func textRect(forBounds bounds: CGRect) -> CGRect {
    return UIEdgeInsetsInsetRect(bounds, UIEdgeInsetsMake(0, 15, 0, 15))
  }
  
  override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
    return UIEdgeInsetsInsetRect(bounds, UIEdgeInsetsMake(0, 15, 0, 15))
  }
  
  private func set(name: String, color: UIColor, textSize: CGFloat = Theme.fontSizes.textFieldDefault()) {
    attributedPlaceholder = NSAttributedString(string: name, attributes: [NSAttributedStringKey.foregroundColor: color])
  }

}

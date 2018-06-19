//
//  Theme.swift
//  Muse
//
//  Created by Nicholas Rizzo on 5/29/18.
//  Copyright © 2018 Nicholas Rizzo. All rights reserved.
//

import UIKit.UIFont

class Theme {
  class fonts {
    class func avenirLight(size: CGFloat) -> UIFont {
      return UIFont(name: "Avenir-Light", size: size)!
    }
    
    class func avenirBlack(size: CGFloat) -> UIFont {
      return UIFont(name: "Avenir-Black", size: size)!
    }
    
    class func avenirMedium(size: CGFloat) -> UIFont {
      return UIFont(name: "Avenir-Medium", size: size)!
    }
    
    class func futuraMedium(size: CGFloat) -> UIFont {
      return UIFont(name: "Futura-Medium", size: size)!
    }
  }
  
  class fontSizes {
    class func textFieldDefault() -> CGFloat {
      return 23
    }
  }
  
  class colors {
    static let lightGray = UIColor.lightGray
  }
  
  class inset {
    static var single = 8
    static var double = 16
    static var triple = 32
  }
}

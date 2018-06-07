//
//  Arrow.swift
//  Muse
//
//  Created by Nicholas Rizzo on 6/7/18.
//  Copyright © 2018 Nicholas Rizzo. All rights reserved.
//

import UIKit

class Arrow: UIButton {

  fileprivate var orientation: ArrowOrientation = .left {
    didSet {
      updateOrientationConstraints()
      drawArrowLayer()
    }
  }
  
  private var arrowLayer = CAShapeLayer()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    self.translatesAutoresizingMaskIntoConstraints = false
    
    activateConstraints()
    updateOrientationConstraints()
    
    setupArrowLayer()
    drawArrowLayer()
    
    self.layer.addSublayer(arrowLayer)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func activateConstraints() {
    print("activate constraints")
    guard let superview = superview else {
      return
    }
    
    NSLayoutConstraint.activate([
      self.centerYAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.centerYAnchor),
      self.heightAnchor.constraint(equalTo: superview.heightAnchor),
      self.widthAnchor.constraint(equalToConstant: 50),
      ])
  }
  
  private func setupArrowLayer() {
    arrowLayer.strokeColor = UIColor.black.cgColor
    arrowLayer.lineWidth = 1.5
  }
  
  private func updateOrientationConstraints() {
    guard let superview = superview else {
      return
    }
    
    if orientation == .left {
      self.leadingAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.leadingAnchor, constant: 0).isActive = true
      self.trailingAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.trailingAnchor, constant: 0).isActive = false
    } else {
      // orientation = right
      self.leadingAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.leadingAnchor, constant: 0).isActive = false
      self.trailingAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.trailingAnchor, constant: 0).isActive = true
    }
  }
  
  private func drawArrowLayer() {
    let path = UIBezierPath()
    let halfArrowHeight: CGFloat = 44.0
    let arrowWidth: CGFloat = 44.0
    path.move(to: CGPoint(x: self.bounds.width / 2.0, y: self.bounds.height / 2.0 - halfArrowHeight))
    path.move(to: CGPoint(x: self.bounds.width / 2.0 - arrowWidth, y: self.bounds.height / 2.0))
    path.move(to: CGPoint(x: self.bounds.width / 2.0, y: self.bounds.height / 2.0 + halfArrowHeight))
    
    arrowLayer.path = path.cgPath
  }
  
  public func setOrientation(to orientation: ArrowOrientation) {
    self.orientation = orientation
  }
  
}

public enum ArrowOrientation {
  case left
  case right
}

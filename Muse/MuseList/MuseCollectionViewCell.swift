//
//  MuseCollectionViewCell.swift
//  Muse
//
//  Created by Nicholas Rizzo on 6/6/18.
//  Copyright © 2018 Nicholas Rizzo. All rights reserved.
//

import UIKit

class MuseCollectionViewCell: UICollectionViewCell {
  
  var museLabel = UILabel()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    museLabel.translatesAutoresizingMaskIntoConstraints = false
    contentView.addSubview(museLabel)
    museLabel.textAlignment = .center
    activateConstraints()
    setupMuseLabel()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func activateConstraints() {
    NSLayoutConstraint.activate([
      museLabel.topAnchor.constraint(equalTo: self.topAnchor),
      museLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
      museLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
      museLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
      ])
  }
  
  private func setupMuseLabel() {
    museLabel.font = museLabel.font.withSize(44)
  }
}

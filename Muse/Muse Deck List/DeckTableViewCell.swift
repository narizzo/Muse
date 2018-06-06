//
//  DeckTableViewCell.swift
//  Muse
//
//  Created by Nicholas Rizzo on 5/30/18.
//  Copyright © 2018 Nicholas Rizzo. All rights reserved.
//

import UIKit

class DeckTableViewCell: UITableViewCell {

  var nameLabel = UILabel()
  var countLabel = UILabel()
  
  override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    nameLabel.translatesAutoresizingMaskIntoConstraints = false
    countLabel.translatesAutoresizingMaskIntoConstraints = false
    
    
    contentView.addSubview(nameLabel)
    contentView.addSubview(countLabel)
    
    activateConstraints()
    setupLabels()
  }
  
  private func activateConstraints() {
    NSLayoutConstraint.activate([
      nameLabel.topAnchor.constraint(equalTo: self.topAnchor),
      nameLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
      nameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
      nameLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 4/5),
      
      countLabel.topAnchor.constraint(equalTo: self.topAnchor),
      countLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
      countLabel.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
      countLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
      ])
  }
  
  private func setupLabels() {
    // Text
    countLabel.textAlignment = .center
    countLabel.text = "0"
    
    // Colors
    /*
    nameLabel.backgroundColor = UIColor.black
    nameLabel.textColor = UIColor.white
    
    countLabel.backgroundColor = UIColor.black
    countLabel.textColor = UIColor.white
 */
  }
  
//  override func layoutSubviews() {
//    super.layoutSubviews()
//  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
  
  

}

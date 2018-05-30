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
    
    nameLabel = UILabel(frame: frame)
    countLabel = UILabel(frame: frame)
    
    countLabel.textAlignment = .center
    
    contentView.addSubview(nameLabel)
    contentView.addSubview(countLabel)
    
    NSLayoutConstraint.activate([
      nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
      nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      nameLabel.heightAnchor.constraint(equalToConstant: 44),
      nameLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 4/5),
      
      countLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
      countLabel.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
      countLabel.heightAnchor.constraint(equalToConstant: 44),
      countLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 1/5),
      ])
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
  
  

}

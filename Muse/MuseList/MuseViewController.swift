//
//  MuseViewController
//  Muse
//
//  Created by Nicholas Rizzo on 5/27/18.
//  Copyright © 2018 Nicholas Rizzo. All rights reserved.
//

import UIKit
import CoreData

class MuseViewController: UIViewController {
  
  weak var selectedDeck: Deck!
  weak var coreDataStack: CoreDataStack!
  
  var collectionView: UICollectionView!
  let flowLayout = UICollectionViewFlowLayout()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    navigationItem.title = selectedDeck.name
    
    setupBarButtons()
    setupFlowLayout()
    setupCollectionView()
    registerCollectionCell()
    
    view.addSubview(collectionView)
    
    layoutCollectionView()

    // self.navigationItem.rightBarButtonItem = self.editButtonItem
  }
  
  private func setupBarButtons() {
    let addBarButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addMuse))
    navigationItem.setRightBarButton(addBarButton, animated: true)
  }
  
  @objc private func addMuse() {
    let optionMenu = UIAlertController(title: "Add Muse", message: nil, preferredStyle: .actionSheet)
    
    let addExisiting = UIAlertAction(title: "Choose From Your Saved Muses", style: .default, handler: { _ in
      self.addExistingMuse()
    })
    let addFromCommunity = UIAlertAction(title: "Choose From The Community's Muses", style: .default, handler: { _ in
      self.addFromCommunity()
    })
    let createNew = UIAlertAction(title: "Create New Muse", style: .default, handler: { _ in
      self.createMuse()
    })
    let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
    
    optionMenu.addAction(createNew)
    optionMenu.addAction(addExisiting)
    optionMenu.addAction(addFromCommunity)
    optionMenu.addAction(cancel)
    
    present(optionMenu, animated: true, completion: nil)
  }
  
  private func addExistingMuse() {
    print("addExisting")
  }
  
  private func addFromCommunity() {
    // drill down to community muses
  }
  
  private func createMuse() {
    let createMuse = UIAlertController(title: "Create Muse", message: "Enter The Muse Description", preferredStyle: .alert)
    createMuse.addTextField { textField in
      textField.placeholder = "description"
      textField.autocapitalizationType = .sentences
    }
    
    let saveAction = UIAlertAction(title: "Save", style: .default) {
      [unowned self] action in
      
      guard let description = createMuse.textFields?.first else {
        return
      }
      
      let newMuse = Muse(entity: Muse.entity(), insertInto: self.coreDataStack.moc)
      newMuse.text = description.text
      newMuse.uuid = UUID()
      
      self.selectedDeck.addToMuses(newMuse)
      newMuse.addToDecks(self.selectedDeck)
      self.coreDataStack.saveContext()
      
      self.collectionView.reloadData()
    }
    
    createMuse.addAction(saveAction)
    createMuse.addAction(UIAlertAction(title: "Cancel", style: .default))
    
    present(createMuse, animated: true)
  }
  
  private func setupFlowLayout() {
    let spacing: CGFloat = 0.0
    flowLayout.minimumLineSpacing = spacing
    flowLayout.minimumInteritemSpacing = spacing
    flowLayout.itemSize = UIScreen.main.bounds.size
    flowLayout.scrollDirection = .horizontal
  }
  
  private func setupCollectionView() {
    collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: flowLayout)
    collectionView.delegate = self
    collectionView.dataSource = self
    collectionView.isScrollEnabled = false
  }
  
  private func registerCollectionCell() {
    collectionView.register(MuseCollectionViewCell.self, forCellWithReuseIdentifier: CellIDs.museCell)
  }
  
  private func layoutCollectionView() {
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      collectionView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
      collectionView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
      collectionView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
      collectionView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
      ])
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
}

extension MuseViewController: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    collectionView.deselectItem(at: indexPath, animated: false)
  }
}

extension MuseViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    if let count = selectedDeck.muses?.count {
      print("number of items in section: \(count)")
      return count
    }
    return 0
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    print("cellForItemAt \(indexPath.row)")
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellIDs.museCell, for: indexPath)
    if let museCell = cell as? MuseCollectionViewCell {
      // add auto unwrap functionality?
      guard let muses = selectedDeck.muses else {
        return museCell
      }
      guard muses.count > 0 else {
        return museCell
      }
      guard let muse = muses[indexPath.row] as? Muse else {
        return museCell
      }
      museCell.museLabel.text = muse.text
      var color: UIColor!
      indexPath.row % 2 == 0 ? (color = UIColor.lightGray) : (color = UIColor.darkGray)
      museCell.museLabel.backgroundColor = color
      return museCell
    }
    return cell
  }
}

//
//  MuseViewController
//  Muse
//
//  Created by Nicholas Rizzo on 5/27/18.
//  Copyright © 2018 Nicholas Rizzo. All rights reserved.
//

import UIKit

class MuseViewController: UIViewController {
  
  weak var selectedDeck: Deck!
  weak var coreDataStack: CoreDataStack! // needed?
  
  var collectionView: UICollectionView!
  let flowLayout = UICollectionViewFlowLayout()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    navigationItem.title = selectedDeck.name
    
    setupFlowLayout()
    setupCollectionView()
    registerCollectionCell()
    view.addSubview(collectionView)
    
    layoutCollectionView()

    // self.navigationItem.rightBarButtonItem = self.editButtonItem
  }
  
  private func setupFlowLayout() {
    let spacing: CGFloat = 0.0
//    flowLayout.estimatedItemSize = CGSize(width: view.bounds.width, height: view.bounds.height)
    flowLayout.minimumLineSpacing = spacing
    flowLayout.minimumInteritemSpacing = spacing
    
    flowLayout.scrollDirection = .horizontal
  }
  
  private func setupCollectionView() {
    collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: flowLayout)
    collectionView.delegate = self
    collectionView.dataSource = self
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
    print("did select")
  }
}

extension MuseViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 3
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
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
      return museCell
    }
    return cell
  }
}

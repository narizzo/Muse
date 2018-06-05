//
//  DeckTableViewController.swift
//  Muse
//
//  Created by Nicholas Rizzo on 5/27/18.
//  Copyright © 2018 Nicholas Rizzo. All rights reserved.
//

import UIKit
import CoreData

class DeckTableViewController: UITableViewController {
  
  weak var coreDataStack: CoreDataStack!
  private var selectedDeck: Deck?
  lazy var fetchedResultsController: NSFetchedResultsController<Deck> = {
    let fetchRequest: NSFetchRequest<Deck> = Deck.fetchRequest()
    let dateSort = NSSortDescriptor(key: #keyPath(Deck.creationDate), ascending: true)
    let nameSort = NSSortDescriptor(key: #keyPath(Deck.name), ascending: true)
    fetchRequest.sortDescriptors = [dateSort, nameSort]
    let fetchedResultsController = NSFetchedResultsController(
      fetchRequest: fetchRequest,
      managedObjectContext: coreDataStack.moc,
      sectionNameKeyPath: nil,
      cacheName: "deckCache")
    fetchedResultsController.delegate = self
    return fetchedResultsController
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupBarButtons()
    
    navigationItem.title = "Decks"
    tableView.backgroundColor = UIColor.black
    
    tableView.delegate = self
    tableView.dataSource = self
    
    tableView.register(DeckTableViewCell.self, forCellReuseIdentifier: CellIDs.deckCell)
    
    fetchData()
  }
  
  private func setupBarButtons() {
    let addBarButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addDeck))
    navigationItem.setRightBarButton(addBarButton, animated: true)
  }
  
  private func fetchData() {
    do {
      try fetchedResultsController.performFetch()
    } catch let error as NSError {
      print("Fetching error: \(error), \(error.userInfo)")
    }
  }
  
  @objc private func addDeck() {
    let alert = UIAlertController(title: "Add Deck", message: "Enter the deck name", preferredStyle: .alert)
    alert.addTextField { textField in
      textField.placeholder = "Deck name"
    }
    
    let saveAction = UIAlertAction(title: "Save", style: .default) {
      [unowned self] action in
      
      guard let name = alert.textFields?.first else {
        return
      }
      
      self.controllerWillChangeContent(self.fetchedResultsController as! NSFetchedResultsController<NSFetchRequestResult>)
      let newDeck = Deck(entity: Deck.entity(), insertInto: self.coreDataStack.moc)
      newDeck.name = name.text
      newDeck.creationDate = Date()
      self.coreDataStack.saveContext()
      self.controllerDidChangeContent(self.fetchedResultsController as! NSFetchedResultsController<NSFetchRequestResult>)
      
    }
    
    alert.addAction(saveAction)
    alert.addAction(UIAlertAction(title: "Cancel", style: .default))
    present(alert, animated: true)
  }
  
  // MARK: - Table view data source
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if let count = fetchedResultsController.fetchedObjects?.count {
      return count
    } else {
      return 0
    }
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: CellIDs.deckCell) as! DeckTableViewCell
    configure(cell, for: indexPath)
    return cell
  }
  
  private func configure(_ cell: UITableViewCell, for indexPath: IndexPath) {
    let deck = fetchedResultsController.object(at: indexPath)
    if let cell = cell as? DeckTableViewCell {
      cell.textLabel?.text = deck.name
    }
  }
  
  override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 70
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == Segues.museList {
      if let destination = segue.destination as? MuseListTableViewController {
        destination.selectedDeck = selectedDeck
      }
    }
  }
  
   override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
    return true
   }
  
  
  // Override to support editing the table view.
  override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
      
      controllerWillChangeContent(self.fetchedResultsController as! NSFetchedResultsController<NSFetchRequestResult>)
      let deck = fetchedResultsController.object(at: indexPath)
      self.coreDataStack.moc.delete(deck)
      self.coreDataStack.saveContext()
      controllerDidChangeContent(self.fetchedResultsController as! NSFetchedResultsController<NSFetchRequestResult>)
    }
  }
  
  /*
   // Override to support rearranging the table view.
   override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
   
   }
   */
  
  /*
   // Override to support conditional rearranging of the table view.
   override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
   // Return false if you do not want the item to be re-orderable.
   return true
   }
   */
  
}

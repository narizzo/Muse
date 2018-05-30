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
      sectionNameKeyPath: #keyPath(Deck.name),
      cacheName: "deckCache")
    fetchedResultsController.delegate = self
    return fetchedResultsController
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    let addBarButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addDeck))
    navigationItem.setRightBarButton(addBarButton, animated: true)
    navigationItem.title = "Decks"
    tableView.backgroundColor = UIColor.black
    
    tableView.delegate = self
    tableView.dataSource = self
    
    tableView.register(DeckTableViewCell.self, forCellReuseIdentifier: CellIDs.deckCell)
    
    fetchData()
  }
  
  private func fetchData() {
    do {
      try fetchedResultsController.performFetch()
    } catch let error as NSError {
      print("Fetching error: \(error), \(error.userInfo)")
    }
  }
  
  @objc private func addDeck() {
    let newDeck = Deck(entity: Deck.entity(), insertInto: coreDataStack.moc)
    newDeck.name = "newDeck"
    newDeck.creationDate = Date()
    
    controllerWillChangeContent(fetchedResultsController as! NSFetchedResultsController<NSFetchRequestResult>)
    let indexPath = IndexPath(row: 0, section: 0)
    tableView.insertRows(at: [indexPath], with: .automatic)
    controllerDidChangeContent(fetchedResultsController as! NSFetchedResultsController<NSFetchRequestResult>)
    coreDataStack.saveContext()
  }
  
  // MARK: - Table view data source
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if let count = fetchedResultsController.fetchedObjects?.count {
      print("number of rows in section: \(count)")
      return count
    } else {
      print("number of rows in section is 0")
      return 0
    }
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    print("cell for row at")
    let cell = tableView.dequeueReusableCell(withIdentifier: CellIDs.deckCell, for: indexPath)
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
    performSegue(withIdentifier: Segues.museList, sender: nil)
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
   // Delete the row from the data source
   tableView.deleteRows(at: [indexPath], with: .fade)
   } else if editingStyle == .insert {
   // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
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
  
  /*
   // MARK: - Navigation
   
   // In a storyboard-based application, you will often want to do a little preparation before navigation
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
   // Get the new view controller using segue.destinationViewController.
   // Pass the selected object to the new view controller.
   }
   */
  
}

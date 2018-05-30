//
//  NSFRCDelegate.swift
//  Muse
//
//  Created by Nicholas Rizzo on 5/30/18.
//  Copyright © 2018 Nicholas Rizzo. All rights reserved.
//

import Foundation
import CoreData

extension DeckTableViewController: NSFetchedResultsControllerDelegate {
  func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
    tableView.beginUpdates()
  }
  
  func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
    
    let indexSet = IndexSet(integer: sectionIndex)
    
    switch type {
    case .insert:
      tableView.insertSections(indexSet, with: .automatic)
    case .delete:
      tableView.deleteSections(indexSet, with: .automatic)
    default: break
    }
  }
  
  
  func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
    print("frc did change")
    switch type {
    case .insert:
      print("inserting row")
      tableView.insertRows(at: [newIndexPath!], with: .automatic)
      print("row inserted")
    case .delete:
      tableView.deleteRows(at: [indexPath!], with: .automatic)
    case .update:
      if let indexPath = indexPath {
        if let cell = tableView.cellForRow(at: indexPath) {
          //configure(cell, for: indexPath)
        }
      }
    case .move:
      tableView.deleteRows(at: [indexPath!], with: .automatic)
      tableView.insertRows(at: [newIndexPath!], with: .automatic)
    }
  }
  
  func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
    tableView.endUpdates()
  }
}

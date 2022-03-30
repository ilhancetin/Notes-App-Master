//
//  CategoryViewController.swift
//  Notes-App
//
//  Created by Kaan on 11.04.2020.
//  Copyright © 2020 Kaan. All rights reserved.
//

import UIKit
import CoreData

class NotesViewController: SwipeTableViewController {
    
    //MARK: - Properties
    
    
    var notes = [Note]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var selectedCategory: Category? {
        didSet{
            loadNotes()
        }
    }
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        loadNotes()
    }
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "goToAddNote", sender: self)
        
    }
    //MARK: - Data Manipulation
    
    func loadNotes(with request: NSFetchRequest<Note> = Note.fetchRequest(),
                   predicate: NSPredicate? = nil){
        let categoryPredicate = NSPredicate(format: "parentCategory.name MATCHES %@", selectedCategory!.name!)
        
        if let predicate = predicate {
            let compoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate, predicate])
            request.predicate = compoundPredicate
        } else {
            request.predicate = categoryPredicate
        }
        
        do {
            notes = try context.fetch(request)
        } catch {
            print("Error while fetching")
        }
        tableView.reloadData()
    }
    
    
    override func updateModel(at indexPath: IndexPath) {
           
        context.delete(notes[indexPath.row])
         notes.remove(at: indexPath.row)
       }
    
    //MARK: - UITableViewDataSource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = super.tableView(tableView, cellForRowAt: indexPath)

        cell.textLabel?.text = notes[indexPath.row].text
        return cell
    }
    
    
    //MARK: - UITableViewDelegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToEditNote", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (segue.identifier == "goToAddNote") {
            let destination = segue.destination as! AddNoteViewController
            destination.context = self.context
            destination.notes = self.notes
            destination.selectedCategory = self.selectedCategory
        }
        
        if (segue.identifier == "goToEditNote") {
            let destination = segue.destination as! EditNoteViewController
            if let indexPath = tableView.indexPathForSelectedRow {
                destination.noteToEdit = notes[indexPath.row]
                destination.context = self.context
            }
        }
    }
}


//MARK: - UISearchBarDelegate

extension NotesViewController: UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let request: NSFetchRequest<Note> = Note.fetchRequest()
        let predicate = NSPredicate(format: "text CONTAINS[cd] %@", searchBar.text!)
        request.sortDescriptors = [NSSortDescriptor(key: "text", ascending: true)]
        loadNotes(with: request,  predicate: predicate)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            loadNotes()
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
            
        }
    }
}

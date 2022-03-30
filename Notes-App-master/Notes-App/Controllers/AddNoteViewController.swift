//
//  AddNoteViewController.swift
//  Notes-App
//
//  Created by Kaan on 12.04.2020.
//  Copyright © 2020 Kaan. All rights reserved.
//

import UIKit
import CoreData

class AddNoteViewController: UIViewController {
    
    //MARK: - Properties
    
    @IBOutlet weak var textView: UITextView!
    var context: NSManagedObjectContext?
    var notes: [Note]?
    var selectedCategory: Category?
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func saveButtonPressed(_ sender: UIBarButtonItem) {
        let newNote = Note(context: self.context!)
        if textView.text != ""{
            newNote.text = textView.text
        } else {
            newNote.text = "No name"
        }
        newNote.parentCategory = selectedCategory
        notes?.append(newNote)
        do {
            try context!.save()
        } catch {
            print("Error while saving.")
        }
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
}

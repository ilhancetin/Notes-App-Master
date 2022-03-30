//
//  CreateNoteViewController.swift
//  Notes-App
//
//  Created by Kaan on 11.04.2020.
//  Copyright © 2020 Kaan. All rights reserved.
//

import UIKit
import CoreData

class EditNoteViewController: UIViewController {
    
    //MARK: - Properties
    
    var noteToEdit: Note?
    var selectedCategory: Category?
    var context: NSManagedObjectContext?
    
    @IBOutlet weak var noteTextView: UITextView!
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        noteTextView.text = noteToEdit?.text
    }
    
    //MARK: - Data Manipulation
    
    @IBAction func saveNote(_ sender: UIBarButtonItem) {
        noteToEdit?.text = noteTextView.text!
        do {
            try context!.save()
        } catch {
            print("Error while saving.")
        }
        self.navigationController?.popViewController(animated: true)
    }
     
    
}

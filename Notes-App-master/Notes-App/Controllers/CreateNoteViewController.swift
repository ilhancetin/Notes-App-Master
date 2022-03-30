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
    var selectedNote: Note?{
        didSet{
            
        }
    }
    @IBOutlet weak var noteTextView: UITextView!
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    //MARK: - Data Manipulation
    
    @IBAction func saveNote(_ sender: UIBarButtonItem) {
        selectedNote?.text = noteTextView.text!
        do {
            try context.save()
        } catch {
            print("Error while saving.")
        }
        self.navigationController?.popViewController(animated: true)
    }
//
//    func getNote(with request: NSFetchRequest<Note> = Note.fetchRequest()){
//        do {
//            selectedNote?.text = try context.fetch(request)
//        } catch {
//            print("Error while fetching")
//        }
//    }
    
}

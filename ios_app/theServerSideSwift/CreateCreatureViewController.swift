//
//  CreateCreatureViewController.swift
//  theServerSideSwift
//
//  Created by pierre-marie de jaureguiberry on 9/30/17.
//  Copyright © 2017 vo2. All rights reserved.
//

import UIKit
import os.log

class CreateCreatureViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var creatureImageView: UIImageView!
    @IBOutlet weak var creatureNameTextField: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    public func loadCreatures() -> [Creature]?  {
        return NSKeyedUnarchiver.unarchiveObject(withFile: Creature.ArchiveURL.path) as? [Creature]
    }
    
    //MARK: Actions
    
    @IBAction func selectImageFromPhotoLibrary(_ sender: Any) {
        
        // Hide the keyboard.
        creatureNameTextField.resignFirstResponder()
        
        // UIImagePickerController is a view controller that lets a user pick media from their photo library.
        let imagePickerController = UIImagePickerController()
        
        // Only allow photos to be picked, not taken.
        imagePickerController.sourceType = .photoLibrary
        
        // Make sure ViewController is notified when the user picks an image.
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
    }
    
    @IBAction func save(_ sender: Any) {
        
        let name = creatureNameTextField.text ?? ""
        let picture = creatureImageView.image
        let creature = Creature(name: name, picture: picture)
        
        guard var creatures = loadCreatures() else {
            
            let isSuccessfulSave = NSKeyedArchiver.archiveRootObject([creature], toFile: Creature.ArchiveURL.path)
            if isSuccessfulSave {
                os_log("Creatures successfully saved.", log: OSLog.default, type: .debug)
            } else {
                os_log("Failed to save creatures...", log: OSLog.default, type: .error)
            }
            self.dismiss(animated: true) {}
            return
        }
        
        creatures.append(creature!)
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(creatures, toFile: Creature.ArchiveURL.path)
        if isSuccessfulSave {
            os_log("Creatures successfully saved.", log: OSLog.default, type: .debug)
        } else {
            os_log("Failed to save creatures...", log: OSLog.default, type: .error)
        }
        self.dismiss(animated: true) {}
        
        /* // UNCOMMENT TO USE SWIFT BACKEND SERVER
         for creature in creatures {
         saveToServer(creature: creature)
         }
         */
    }
    
    //MARK: UITextFieldDelegate
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Hide the keyboard.
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        navigationItem.title = textField.text
    }
    
    //MARK: UIImagePickerControllerDelegate
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        // Dismiss the picker if the user canceled.
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        // The info dictionary may contain multiple representations of the image. You want to use the original.
        guard let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        
        // Set photoImageView to display the selected image.
        creatureImageView.image = selectedImage
        
        // Dismiss the picker.
        dismiss(animated: true, completion: nil)
    }
    
}

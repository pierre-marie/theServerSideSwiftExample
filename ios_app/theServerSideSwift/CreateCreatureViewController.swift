//
//  CreateCreatureViewController.swift
//  theServerSideSwift
//
//  Created by pierre-marie de jaureguiberry on 9/30/17.
//  Copyright © 2017 vo2. All rights reserved.
//

import UIKit
import os.log

// UNCOMMENT TO USE SWIFT BACKEND SERVER
//import Server_app_iOS_SDK
//extension Creature {
//    func asServerCreature() -> Server_app_iOS_SDK.Creature {
//        let serverCreature = Server_app_iOS_SDK.Creature()
//        serverCreature.name = self.name
//        serverCreature.picture = UIImageJPEGRepresentation(self.picture!, 0)?.base64EncodedString()
//        return serverCreature
//    }
//}

class CreateCreatureViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var creatureImageView: UIImageView!
    @IBOutlet weak var creatureNameTextField: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    
    //MARK: Send a creature to server
    
    // UNCOMMENT TO USE SWIFT BACKEND SERVER
//    private func saveToServer(creature: Creature) {
//        
//        CreatureAPI.creatureCreate(data: creature.asServerCreature()) { (returnedData, response, error) in
//            guard error == nil else {
//                print(error!)
//                return
//            }
//            if let result = returnedData {
//                print(result)
//            }
//            if let status = response?.statusCode {
//                print("ServerCreatureAPI.serverCreatureCreate() finished with status code: \(status)")
//            }
//        }
//    }
    
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
        
        var isSuccessfulSave = true
        if var creatures = loadCreatures() {
            creatures.append(creature!)
            isSuccessfulSave = NSKeyedArchiver.archiveRootObject(creatures, toFile: Creature.ArchiveURL.path)
        } else {
            isSuccessfulSave = NSKeyedArchiver.archiveRootObject([creature], toFile: Creature.ArchiveURL.path)
        }
        if isSuccessfulSave {
            os_log("Creatures successfully saved.", log: OSLog.default, type: .debug)
        } else {
            os_log("Failed to save creatures...", log: OSLog.default, type: .error)
        }
        
        // UNCOMMENT TO USE SWIFT BACKEND SERVER
//        saveToServer(creature: creature!)

        self.dismiss(animated: true) {}
        return
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

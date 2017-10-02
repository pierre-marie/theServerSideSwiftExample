//
//  Creature.swift
//  theServerSideSwift
//
//  Created by pierre-marie de jaureguiberry on 9/30/17.
//  Copyright © 2017 vo2. All rights reserved.
//       __
//      /_/\
//     / /\ \
//    / / /\ \
//   / / /\ \ \
//  / /_/__\ \ \
// /_/______\_\/\
// \_\_________\/ WTF PROGRAMMING CLUB

import UIKit
import os.log

class Creature: NSObject, NSCoding {
    
    var name: String
    var picture: UIImage?
    
    //MARK: Archiving Paths
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("creatures")
    
    //MARK: Types
    struct PropertyKey {
        static let name = "name"
        static let picture = "picture"
    }
    
    //MARK: Initialization
    
    init?(name: String, picture: UIImage?) {
        
        // The name must not be empty
        guard !name.isEmpty else {
            return nil
        }
        
        // Initialize stored properties.
        self.name = name
        self.picture = picture
    }
    
    //MARK: NSCoding
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: PropertyKey.name)
        aCoder.encode(picture, forKey: PropertyKey.picture)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        
        // The name is required. If we cannot decode a name string, the initializer should fail.
        guard let name = aDecoder.decodeObject(forKey: PropertyKey.name) as? String else {
            os_log("Unable to decode the name for a Creature object.", log: OSLog.default, type: .debug)
            return nil
        }
        
        // Because picture is an optional property of Creature, just use conditional cast.
        let picture = aDecoder.decodeObject(forKey: PropertyKey.picture) as? UIImage
        
        // Must call designated initializer.
        self.init(name: name, picture: picture)
        
    }
}

//
//  ViewController.swift
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

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var table: UITableView!
    let cellIdentifier = "creatureCell"
    var creatures: [Creature]? = []
    
    public func loadCreatures() -> [Creature]?  {
        return NSKeyedUnarchiver.unarchiveObject(withFile: Creature.ArchiveURL.path) as? [Creature]
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(animated)
        creatures = loadCreatures()
        table.reloadData()
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        creatures = loadCreatures()
        table.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (creatures != nil) {
            return creatures!.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? CreatureTableViewCell  else {
            fatalError("The dequeued cell is not an instance of MealTableViewCell.")
        }
        
        let currentCreature = creatures?[indexPath.row]
        cell.nameLabel?.text = currentCreature?.name
        cell.photoImageView?.image = currentCreature?.picture
        return cell
    }
}


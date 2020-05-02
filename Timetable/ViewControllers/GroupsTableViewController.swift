//
//  GroupsTableViewController.swift
//  Timetable
//
//  Created by art-off on 01.05.2020.
//  Copyright © 2020 art-off. All rights reserved.
//

import UIKit
import RealmSwift

class GroupsTableViewController: UITableViewController {
    
    private var data: [Results<RGroup>?]!

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func set(saveObjects: Results<RGroup>, allObjects: Results<RGroup>) {
        data.append(saveObjects)
        data.append(allObjects)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

}

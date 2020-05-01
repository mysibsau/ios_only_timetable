//
//  ChoiceSearchViewController.swift
//  Timetable
//
//  Created by art-off on 01.05.2020.
//  Copyright © 2020 art-off. All rights reserved.
//

import UIKit

class ChoiceSearchViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Поиск"
        view.backgroundColor = Colors.backgroungColor

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    // MARK: - Table view delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        let tvc = TimetableViewController()
        tvc.title = "xui"
        navigationController?.pushViewController(tvc, animated: true)
    }


}

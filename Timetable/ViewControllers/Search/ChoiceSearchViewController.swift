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
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    // MARK: - Table view delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        if indexPath.row == 0 {
            let groupsViewController = GroupsTableViewController()
            groupsViewController.data = [
                DataManager.shared.getFavoriteGruops(),
                DataManager.shared.getGroups()
            ]
            
            navigationController?.pushViewController(groupsViewController, animated: true)
            
        } else if indexPath.row == 1 {
            let professorViewController = ProfessorsTableViewController()
            professorViewController.data = [
                DataManager.shared.getFavoriteProfessors(),
                DataManager.shared.getProfessors()
            ]
            
            navigationController?.pushViewController(professorViewController, animated: true)
            
        } else if indexPath.row == 2 {
            let placeViewController = PlacesTableViewController()
            placeViewController.data = [
                DataManager.shared.getFavoritePlaces(),
                DataManager.shared.getPlaces()
            ]
            
            navigationController?.pushViewController(placeViewController, animated: true)
            
        }
        
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("fine")
    }

}

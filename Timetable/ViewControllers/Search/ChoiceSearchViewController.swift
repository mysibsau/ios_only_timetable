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

        // Раньше создавал 3 отдельных класса: для Групп, Преподавателей, Мест
        // Сейчас создал один класс с дженериками и почти все норм, осталось поиск прикрутить
        
        if indexPath.row == 0 {
            
            let groupTableViewController = TableViewController<RGroup>()
            groupTableViewController.data = [
                DataManager.shared.getFavoriteGruops(),
                DataManager.shared.getGroups()
            ]
            
            navigationController?.pushViewController(groupTableViewController, animated: true)
            
        } else if indexPath.row == 1 {
            
            let professorTableViewController = TableViewController<RProfessor>()
            professorTableViewController.data = [
                DataManager.shared.getFavoriteProfessors(),
                DataManager.shared.getProfessors()
            ]
            
            navigationController?.pushViewController(professorTableViewController, animated: true)
            
        } else if indexPath.row == 2 {
            
            let placeTableViewController = TableViewController<RPlace>()
            placeTableViewController.data = [
                DataManager.shared.getFavoritePlaces(),
                DataManager.shared.getPlaces()
            ]
            
            navigationController?.pushViewController(placeTableViewController, animated: true)
            
        }
        
    }

}

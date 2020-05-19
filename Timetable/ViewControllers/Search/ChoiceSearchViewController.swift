//
//  ChoiceSearchViewController.swift
//  Timetable
//
//  Created by art-off on 01.05.2020.
//  Copyright © 2020 art-off. All rights reserved.
//

import UIKit

class ChoiceSearchViewController: UITableViewController{
    
    // Первый элемент массива - сохранненные группа, второй - все
    private let data = [
        "Группы",
        "Преподаватели",
        "Кабинеты"
    ]
    

    // MARK: - View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Поиск"
        
        // Меняем слишь table view на .grouped
        tableView = UITableView(frame: self.tableView.frame, style: .grouped)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        //view.backgroundColor = Colors.backgroungColor
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Выберите"
        } else {
            return nil
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = data[indexPath.row]
        cell.accessoryType = .disclosureIndicator

        return cell
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

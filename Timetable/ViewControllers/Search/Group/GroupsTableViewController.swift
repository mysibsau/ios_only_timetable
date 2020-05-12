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
    
    // Первый элемент массива - сохранненные группа, второй - все
    var data: [Results<RGroup>]!
    private var filtredData: [Results<RGroup>]!
    
    
    // MARK: Для SearchController'а
    private let searchController = UISearchController(searchResultsController: nil)
    
    private var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else { return false }
        return text.isEmpty
    }
    private var isFiltering: Bool {
        return searchController.isActive && !searchBarIsEmpty
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Меняем слишь table view на .grouped
        tableView = UITableView(frame: self.tableView.frame, style: .grouped)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        setupSearchController()
    }
    
    // MARK: Установка SearchController'а
    private func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Поиск"
        
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
        // Для того, чтобы поиск был доступен сразу, без необходимости свайпать вниз (нужно поставить false)
        navigationItem.hidesSearchBarWhenScrolling = true
    }
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        if isFiltering {
            return filtredData.count
        }
        return data.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return filtredData[section].count
        }
        return data[section].count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Сохраненные"
        } else if section == 1 {
            return "Все"
        } else {
            // если вдруг появится третий раздел (:
            return "Что-то странное"
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let group: RGroup
        if isFiltering {
            group = filtredData[indexPath.section][indexPath.row]
        } else {
            group = data[indexPath.section][indexPath.row]
        }
        
        cell.textLabel?.text = group.name
        return cell
    }
    
    // MARK: ТУТ НАПИСАТЬ ПЕРЕХОД НА ДЕТАЛЬНЫЙ ПРОСМОТР ГРУППЫ
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UIViewController()
        vc.view.backgroundColor = .green
        navigationController?.pushViewController(vc, animated: true)
    }

}

extension GroupsTableViewController: UISearchResultsUpdating {

    func updateSearchResults(for searchController: UISearchController) {
        // filterContentForSearchText(searchController.searchBar.text!)
        guard let searchText = searchController.searchBar.text else { return }
        filtredData = [
            data[0].filter("name CONTAINS[c] '\(searchText)'"),
            data[1].filter("name CONTAINS[c] '\(searchText)'")
        ]
        tableView.reloadData()
    }

//    private func filterContentForSearchText(_ searchText: String) {
//        filtredData = [
//            data[0].filter("name CONTAINS[c] '\(searchText)'"),
//            data[1].filter("name CONTAINS[c] '\(searchText)'")
//        ]
//        tableView.reloadData()
//    }

}

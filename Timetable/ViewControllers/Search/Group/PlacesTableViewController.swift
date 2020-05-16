//
//  PlacesTableViewController.swift
//  Timetable
//
//  Created by art-off on 15.05.2020.
//  Copyright © 2020 art-off. All rights reserved.
//

import UIKit
import RealmSwift

class PlacesTableViewController: UITableViewController {

    // Первый элемент массива - сохранненные группа, второй - все
    var data: [Results<RPlace>]!
    private var filtredData: [Results<RPlace>]!
    
    
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
        if isFiltering { return filtredData.count }
        return data.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering { return filtredData[section].count }
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
        
        let place: RPlace
        if isFiltering {
            place = filtredData[indexPath.section][indexPath.row]
        } else {
            place = data[indexPath.section][indexPath.row]
        }
        
        cell.textLabel?.text = place.name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let place: RPlace
        if isFiltering {
            place = filtredData[indexPath.section][indexPath.row]
        } else {
            place = data[indexPath.section][indexPath.row]
        }
        
        let detailVC = DetailViewController(place: place)
        
        navigationController?.pushViewController(detailVC, animated: true)
    }

}

extension PlacesTableViewController: UISearchResultsUpdating {

    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else { return }
        filtredData = [
            data[0].filter("name CONTAINS[c] '\(searchText)'"),
            data[1].filter("name CONTAINS[c] '\(searchText)'")
        ]
        tableView.reloadData()
    }

}

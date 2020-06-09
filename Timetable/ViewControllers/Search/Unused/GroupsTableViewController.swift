////
////  GroupsTableViewController.swift
////  Timetable
////
////  Created by art-off on 01.05.2020.
////  Copyright © 2020 art-off. All rights reserved.
////
//
//import UIKit
//import RealmSwift
//
//class GroupsTableViewController: UITableViewController {
//    
//    // Первый элемент массива - сохранненные группа, второй - все
//    var data: [Results<RGroup>]!
//    private var filtredData: [Results<RGroup>]!
//    
//    
//    // MARK: - Для SearchController'а
//    private let searchController = UISearchController(searchResultsController: nil)
//    
//    private var searchBarIsEmpty: Bool {
//        guard let text = searchController.searchBar.text else { return false }
//        return text.isEmpty
//    }
//    private var isFiltering: Bool {
//        return searchController.isActive && !searchBarIsEmpty
//    }
//    
//    // MARK: - View Did Load
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        navigationItem.title = "Группы"
//        
//        // Меняем слишь table view на .grouped
//        tableView = UITableView(frame: self.tableView.frame, style: .grouped)
//        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
//        
//        // добавляем отработку длинного нажатия (открытие расписания)
//        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(showTimetableHandler(longPressGesture:)))
//        longPressGesture.minimumPressDuration = 0.7
//        tableView.addGestureRecognizer(longPressGesture)
//        
//        setupSearchController()
//    }
//    
//    // MARK: - Обработчик длинного нажатия для открытия расписания
//    @objc private func showTimetableHandler(longPressGesture: UILongPressGestureRecognizer) {
//        let point = longPressGesture.location(in: tableView)
//        guard let indexPath = tableView.indexPathForRow(at: point) else { return }
//        
//        let group = data[indexPath.section][indexPath.row]
//        
//        showTimetable(withId: group.id)
//    }
//    
//    // MARK: - Установка SearchController'а
//    private func setupSearchController() {
//        searchController.searchResultsUpdater = self
//        searchController.obscuresBackgroundDuringPresentation = false
//        searchController.searchBar.placeholder = "Поиск"
//        
//        navigationItem.searchController = searchController
//        definesPresentationContext = true
//        
//        // Для того, чтобы поиск был доступен сразу, без необходимости свайпать вниз (нужно поставить false)
//        navigationItem.hidesSearchBarWhenScrolling = true
//    }
//    
//
//    // MARK: - Table view data source
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        if isFiltering { return filtredData.count }
//        return data.count
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if isFiltering { return filtredData[section].count }
//        return data[section].count
//    }
//    
//    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        if section == 0 {
//            return "Избранное"
//        } else if section == 1 {
//            return "Все"
//        } else {
//            // если вдруг появится третий раздел (:
//            return "Что-то странное"
//        }
//    }
//    
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
//        
//        let group: RGroup
//        if isFiltering {
//            group = filtredData[indexPath.section][indexPath.row]
//        } else {
//            group = data[indexPath.section][indexPath.row]
//        }
//        
//        cell.textLabel?.text = group.name
//        return cell
//    }
//    
//    // MARK: - Table view delegate
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        
//        let group: RGroup
//        let isSave: Bool
//        
//        if isFiltering {
//            group = filtredData[indexPath.section][indexPath.row]
//        } else {
//            group = data[indexPath.section][indexPath.row]
//        }
//        
//        // содержится ли данный объект в сохраненных
//        if data[0].filter("id = \(group.id)").count == 0 {
//            isSave = false
//        } else {
//            isSave = true
//        }
//        
//        let detailVC = DetailViewController(group: group, isFavorite: isSave)
//        detailVC.delegate = self
//        
//        navigationController?.pushViewController(detailVC, animated: true)
//    }
//
//}
//
//// MARK: - Search Result Updating
//extension GroupsTableViewController: UISearchResultsUpdating {
//
//    func updateSearchResults(for searchController: UISearchController) {
//        guard let searchText = searchController.searchBar.text else { return }
//        filtredData = [
//            data[0].filter("name CONTAINS[c] '\(searchText)'"),
//            data[1].filter("name CONTAINS[c] '\(searchText)'")
//        ]
//        tableView.reloadData()
//    }
//
//}
//
//// MARK: - Showing Timetable
//extension GroupsTableViewController: DetailViewDelegate {
//    func makeTimetableBasic(withId id: Int) {
//        <#code#>
//    }
//    
//    
//    // MARK: ЭТО ДОПИСАТЬ ТОЛЬКО ПРИНТИТ БЛЯДЬ
//    func showTimetable(withId id: Int) {
//        print(id)
//    }
//    
//    // MARK: Добавление в избранные
//    func addToFavorite(objectWithId id: Int) {
//        // проверяем, вдруг этот объект уже в Избранном
//        guard data[0].filter("id = \(id)").isEmpty else { return }
//        
//        // Выбираем объект для добавления
//        let allGroups = data[1].filter("id = \(id)")
//        guard let group = allGroups.first else { return }
//        
//        // добавляем в избранные
//        DataManager.shared.writeFavorite(group: group)
//        tableView.reloadData()
//    }
//    
//    // MARK: Удаление из избранных
//    func removeFromFavorite(objectWithId id: Int) {
//        // проверяем, вдруг этого объекта нет в Избранном
//        guard !data[0].filter("id = \(id)").isEmpty else { return }
//        
//        // Выбираем объект для удаления
//        let favoriteGroups = data[0].filter("id = \(id)")
//        guard let group = favoriteGroups.first else { return }
//        
//        // Удаляем из избранных
//        DataManager.shared.deleteFavorite(group: group)
//        tableView.reloadData()
//    }
//}

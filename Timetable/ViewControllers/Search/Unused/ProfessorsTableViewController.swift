////
////  ProfessorsTableViewController.swift
////  Timetable
////
////  Created by art-off on 15.05.2020.
////  Copyright © 2020 art-off. All rights reserved.
////
//
//import UIKit
//import RealmSwift
//
//class ProfessorsTableViewController: UITableViewController {
//
//    // Первый элемент массива - сохранненные группа, второй - все
//    var data: [Results<RProfessor>]!
//    private var filtredData: [Results<RProfessor>]!
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
//        navigationItem.title = "Преподаватели"
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
//        let professor = data[indexPath.section][indexPath.row]
//        
//        showTimetable(withId: professor.id)
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
//        let professor: RProfessor
//        if isFiltering {
//            professor = filtredData[indexPath.section][indexPath.row]
//        } else {
//            professor = data[indexPath.section][indexPath.row]
//        }
//        
//        cell.textLabel?.text = professor.name
//        return cell
//    }
//    
//    // MARK: - Table view delegate
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        
//        let professor: RProfessor
//        let isSave: Bool
//        
//        if isFiltering {
//            professor = filtredData[indexPath.section][indexPath.row]
//        } else {
//            professor = data[indexPath.section][indexPath.row]
//        }
//        
//        // содержится ли данный объект в сохраненных
//        if data[0].filter("id = \(professor.id)").count == 0 {
//            isSave = false
//        } else {
//            isSave = true
//        }
//        
//        let detailVC = DetailViewController(professor: professor, isFavorite: isSave)
//        detailVC.delegate = self
//        
//        navigationController?.pushViewController(detailVC, animated: true)
//    }
//
//}
//
//// MARK: - Search Results Updating
//extension ProfessorsTableViewController: UISearchResultsUpdating {
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
//extension ProfessorsTableViewController: DetailViewDelegate {
//    
//    func showTimetable(withId id: Int) {
//        print(id)
//    }
//    
//    func addToFavorite(objectWithId id: Int) {
//        // проверяем, вдруг этот объект уже в Избранном
//        guard data[0].filter("id = \(id)").isEmpty else { return }
//        
//        // Выбираем объект для добавления
//        let allProfessors = data[1].filter("id = \(id)")
//        guard let professor = allProfessors.first else { return }
//        
//        // добавляем в избранные
//        DataManager.shared.writeFavorite(professor: professor)
//        tableView.reloadData()
//    }
//    
//    func removeFromFavorite(objectWithId id: Int) {
//        // проверяем, вдруг этого объекта нет в Избранном
//        guard !data[0].filter("id = \(id)").isEmpty else { return }
//        
//        // Выбираем объект для удаления
//        let favoriteProfessors = data[0].filter("id = \(id)")
//        guard let professor = favoriteProfessors.first else { return }
//        
//        // Удаляем из избранных
//        DataManager.shared.deleteFavorite(professor: professor)
//        tableView.reloadData()
//    }
//    
//}

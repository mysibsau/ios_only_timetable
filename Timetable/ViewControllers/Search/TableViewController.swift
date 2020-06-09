//
//  TableViewController.swift
//  Timetable
//
//  Created by art-off on 18.05.2020.
//  Copyright © 2020 art-off. All rights reserved.
//

import UIKit
import RealmSwift

class TableViewController<REntitie: Object>: UITableViewController, UISearchResultsUpdating {
    
    // Первый элемент массива - сохранненные группа, второй - все
    var data: [Results<REntitie>]!
    private var filtredData: [Results<REntitie>]!
    
    
    // MARK: - Для SearchController'а
    private let searchController = UISearchController(searchResultsController: nil)
    
    private var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else { return false }
        return text.isEmpty
    }
    private var isFiltering: Bool {
        return searchController.isActive && !searchBarIsEmpty
    }
    
    // MARK: Для загрузки расписаний
    var task: Thread?

    // MARK: - Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Группы"
        
        // Меняем слишь table view на .grouped
        tableView = UITableView(frame: self.tableView.frame, style: .grouped)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        // добавляем отработку длинного нажатия (открытие расписания)
        addLongGestureRecognizer()
        
        setupSearchController()
        
        //view.backgroundColor = Colors.backgroungColor
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Если уходят с эгото экрана - прекращаем загрузку
        task?.cancel()
    }
    
    // MARK: - Добавление обработки длинного нажатия на ячейку ДЛЯ ОТКРЫТИЯ ДЕТАЛЬНОГО ПРОСМОТА
    private func addLongGestureRecognizer() {
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(showDetailHandler(longPressGesture:)))
        tableView.addGestureRecognizer(longPressGesture)
    }
    
    // MARK: Обработчик длинного нажатия для открытия детального просмотра
    @objc private func showDetailHandler(longPressGesture: UILongPressGestureRecognizer) {
        // Чтобы он срабатывал только один раз
        guard longPressGesture.state == .began else { return }
        
        let point = longPressGesture.location(in: tableView)
        guard let indexPath = tableView.indexPathForRow(at: point) else { return }
        
        let object: REntitie
        if isFiltering {
            object = filtredData[indexPath.section][indexPath.row]
        } else {
            object = data[indexPath.section][indexPath.row]
        }
        
        // Отображение Детального экрана
        let isFavorite: Bool
        let detailVC: DetailViewController
        
        if let object = object as? RGroup {
            isFavorite = !data[0].filter("id = \(object.id)").isEmpty
            detailVC = DetailViewController(group: object, isFavorite: isFavorite)
            detailVC.delegate = self
            navigationController?.pushViewController(detailVC, animated: true)
            tableView.selectRow(at: indexPath, animated: false, scrollPosition: .none)
        } else if let object = object as? RProfessor {
            isFavorite = !data[0].filter("id = \(object.id)").isEmpty
            detailVC = DetailViewController(professor: object, isFavorite: isFavorite)
            detailVC.delegate = self
            navigationController?.pushViewController(detailVC, animated: true)
            tableView.selectRow(at: indexPath, animated: false, scrollPosition: .none)
        } else if let object = object as? RPlace {
            isFavorite = !data[0].filter("id = \(object.id)").isEmpty
            detailVC = DetailViewController(place: object, isFavorite: isFavorite)
            detailVC.delegate = self
            navigationController?.pushViewController(detailVC, animated: true)
            tableView.selectRow(at: indexPath, animated: false, scrollPosition: .none)
        }
        
        // Леграя вибрация в конце длинного нажатия
        UIDevice.vibrate()
    }
    
    // MARK: - Установка SearchController'а
    private func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Поиск"
        
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
        // Для того, чтобы поиск был доступен сразу, без необходимости свайпать вниз нужно поставить false
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
            return "Избранное"
        } else if section == 1 {
            return "Все"
        } else {
            // если вдруг появится третий раздел (:
            return "Что-то странное"
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        if section == 0 {
            return "Для детального просмотра и добавления или удаления избранных нажмите и удерживайте нужную ячейку"
        } else {
            return nil
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let object: REntitie
        if isFiltering {
            object = filtredData[indexPath.section][indexPath.row]
        } else {
            object = data[indexPath.section][indexPath.row]
        }
        
        if let object = object as? RGroup {
            cell.textLabel?.text = object.name
        } else if let object = object as? RProfessor {
            cell.textLabel?.text = object.name
        } else if let object = object as? RPlace {
            cell.textLabel?.text = object.name
        }

        return cell
    }
    
    // MARK: - Table view delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let object = data[indexPath.section][indexPath.row]
        
        if let object = object as? RGroup {
            showTimetable(withId: object.id)
        } else if let object = object as? RProfessor {
            showTimetable(withId: object.id)
        } else if let object = object as? RPlace {
            showTimetable(withId: object.id)
        }
    }
    
    // MARK: - Search Result Updating (не в качетстве расширения потому что дженерини не умеют работать с @objc в расширениях)
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else { return }
        filtredData = [
            data[0].filter("name CONTAINS[c] '\(searchText)'"),
            data[1].filter("name CONTAINS[c] '\(searchText)'")
        ]
        tableView.reloadData()
    }

}

// MARK: - Detail View Delegate
extension TableViewController: DetailViewDelegate {
    
    // MARK: Открытие расписания
    func showTimetable(withId id: Int) {
        // берем группу с нужным id из всех групп
        // потом нужно просто запросить расписание из бд
        guard let entitie = data[1].filter("id = \(id)").first else { return }
        
        if let group = entitie as? RGroup {
            
            let optionalTimetable = DataManager.shared.getTimetable(forGroupId: group.id)
            
            if let timetable = optionalTimetable {
                NotificationCenter.default.post(name: .didSelectGroup, object: nil, userInfo: [0: timetable])
                // FIXME: Тут происходит дизбалансный вызов
                tabBarController?.selectedIndex = 0
                navigationController?.popToRootViewController(animated: true)
            } else {
                
                print("Качаем...")
                /// Иначе качаем из API, если нет в БД
                // начинаем спинер
                task = ApiManager.loadTimetableTask(forGroupId: group.id) { optionalTimetable in
                    
                    DispatchQueue.main.async {
                        if let timetable = optionalTimetable {
                            DataManager.shared.write(groupTimetable: timetable)
                            let timetableForShowing = DataManager.shared.getTimetable(forGroupId: group.id)!
                            NotificationCenter.default.post(name: .didSelectGroup, object: nil, userInfo: [0: timetableForShowing])
                            // FIXME: Тут происходит дизбалансный вызов
                            self.tabBarController?.selectedIndex = 0
                            self.navigationController?.popToRootViewController(animated: true)
                        } else {
                            // Тут показываем алерт
                            print("Не вышло")
                        }
                        // останавливаем спинер
                    }
                    
                }
                
                task?.start()
            }
            
        } else if let professor = entitie as? RProfessor {
            
            let optionalTimetable = DataManager.shared.getTimetable(forProfessorId: professor.id)
            
            if let timetable = optionalTimetable {
                NotificationCenter.default.post(name: .didSelectProfessor, object: nil, userInfo: [0: timetable])
                tabBarController?.selectedIndex = 0
                navigationController?.popToRootViewController(animated: true)
                
            } else {
                
                print("Качаем...")
                /// Иначе качаем из API, если нет в БД
                // начинаем спинер
                task = ApiManager.loadTimetableTask(forProfessorId: professor.id) { optionalTimetable in
                    
                    DispatchQueue.main.async {
                        if let timetable = optionalTimetable {
                            DataManager.shared.write(professorTimetable: timetable)
                            let timetableForShowing = DataManager.shared.getTimetable(forProfessorId: professor.id)!
                            NotificationCenter.default.post(name: .didSelectProfessor, object: nil, userInfo: [0: timetableForShowing])
                            // FIXME: Тут происходит дизбалансный вызов
                            self.tabBarController?.selectedIndex = 0
                            self.navigationController?.popToRootViewController(animated: true)
                        } else {
                            // Тут показываем алерт
                            print("Не вышло")
                        }
                        // останавливаем спинер
                    }
                    
                }
                
                task?.start()
                
            }
            
        } else if let place = entitie as? RPlace {
            
            let optionalTimetable = DataManager.shared.getTimetable(forPlaceId: place.id)
            
            if let timetable = optionalTimetable {
                NotificationCenter.default.post(name: .didSelectPlace, object: nil, userInfo: [0: timetable])
                tabBarController?.selectedIndex = 0
                navigationController?.popToRootViewController(animated: true)
                
            } else {
                
                print("Качаем...")
                /// Иначе качаем из API, если нет в БД
                // начинаем спинер
                task = ApiManager.loadTimetableTask(forPlaceId: place.id) { optionalTimetable in
                    
                    DispatchQueue.main.async {
                        if let timetable = optionalTimetable {
                            DataManager.shared.write(placeTimetable: timetable)
                            let timetableForShowing = DataManager.shared.getTimetable(forPlaceId: place.id)!
                            NotificationCenter.default.post(name: .didSelectPlace, object: nil, userInfo: [0: timetableForShowing])
                            // FIXME: Тут происходит дизбалансный вызов
                            self.tabBarController?.selectedIndex = 0
                            self.navigationController?.popToRootViewController(animated: true)
                        } else {
                            // Тут показываем алерт
                            print("Не вышло")
                        }
                        // останавливаем спинер
                    }
                    
                }
                
                task?.start()
            }
        }
        
    }
    
    // MARK: Добавление в избранные
    func addToFavorite(objectWithId id: Int) {
        // проверяем, вдруг этот объект уже в Избранном
        guard data[0].filter("id = \(id)").isEmpty else { return }
        
        // Выбираем объект для добавления
        let allObjects = data[1].filter("id = \(id)")
        guard let object = allObjects.first else { return }
        
        // добавляем в избранные
        if let object = object as? RGroup {
            DataManager.shared.writeFavorite(group: object)
        } else if let object = object as? RProfessor {
            DataManager.shared.writeFavorite(professor: object)
        } else if let object = object as? RPlace {
            DataManager.shared.writeFavorite(place: object)
        }
        
        tableView.reloadData()
    }
    
    // MARK: Удаление из избранных
    func removeFromFavorite(objectWithId id: Int) {
        // проверяем, вдруг этого объекта нет в Избранном
        guard !data[0].filter("id = \(id)").isEmpty else { return }
        
        // Выбираем объект для удаления
        let favoriteObjects = data[0].filter("id = \(id)")
        guard let object = favoriteObjects.first else { return }
        
        // Удаляем из избранных
        if let object = object as? RGroup {
            DataManager.shared.deleteFavorite(group: object)
        } else if let object = object as? RProfessor {
            DataManager.shared.deleteFavorite(professor: object)
        } else if let object = object as? RPlace {
            DataManager.shared.deleteFavorite(place: object)
        }
        
        tableView.reloadData()
    }
//
//    func showActivityIndicatory(uiView: UIView) {
//        let container: UIView = UIView()
//        container.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0) // UIColor.fromHex(0xffffff, alpha: 0.3)
//
//        uiView.addSubview(container)
//        container.translatesAutoresizingMaskIntoConstraints = false
//        container.addConstraintsOnAllSides(to: uiView.safeAreaLayoutGuide, withConstantForTop: 0, leadint: 0, trailing: 0, bottom: 0)
//
//        let loadingView: UIView = UIView()
//        loadingView.backgroundColor = UIColor(red: 0.25, green: 0.25, blue: 0.25, alpha: 0.7) // UIColorFromHex(0x444444, alpha: 0.7)
//        loadingView.clipsToBounds = true
//        loadingView.layer.cornerRadius = 10
//
//        container.addSubview(loadingView)
//        loadingView.translatesAutoresizingMaskIntoConstraints = false
//        loadingView.centerYAnchor.constraint(equalTo: container.centerYAnchor).isActive = true
//        loadingView.centerXAnchor.constraint(equalTo: container.centerXAnchor).isActive = true
//        loadingView.widthAnchor.constraint(equalToConstant: 80).isActive = true
//        loadingView.heightAnchor.constraint(equalToConstant: 80).isActive = true
//
//        let activityIndicator = UIActivityIndicatorView()
//        activityIndicator.style = .whiteLarge
//
//        loadingView.addSubview(activityIndicator)
//
//        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
//        activityIndicator.centerYAnchor.constraint(equalTo: loadingView.centerYAnchor).isActive = true
//        activityIndicator.centerXAnchor.constraint(equalTo: loadingView.centerXAnchor).isActive = true
//        activityIndicator.widthAnchor.constraint(equalToConstant: 40).isActive = true
//        activityIndicator.heightAnchor.constraint(equalToConstant: 40).isActive = true
//
//
//        activityIndicator.startAnimating()
//        tableView.isScrollEnabled = false
//    }
}

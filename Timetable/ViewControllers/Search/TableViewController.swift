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
    
    // MARK: - Для загрузки расписаний
    let downloadingQueue: OperationQueue = {
        let queue = OperationQueue()
        queue.maxConcurrentOperationCount = 2
        return queue
    }()
    
    let session = URLSession(configuration: URLSessionConfiguration.default)
    
    // MARK: - UI
    // MARK: Activity Indicator
    let viewWithActivityIndicator = ActivityIndicatorView()
    // MARK: Alert View
    let alertViewForNetrowk = AlertView(alertText: "Проблемы с сетью")

    // MARK: - Overrides
    override func loadView() {
        super.loadView()
        
        navigationItem.title = "Группы"
        
        // Меняем слишь table view на .grouped
        tableView = UITableView(frame: self.tableView.frame, style: .grouped)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        setupSearchController()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // добавляем отработку длинного нажатия (открытие расписания)
        addLongGestureRecognizer()
        
        //view.backgroundColor = Colors.backgroungColor
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Если уходят с эгото экрана - прекращаем загрузку
        downloadingQueue.cancelAllOperations()
        stopActivityIndicator()
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
        navigationItem.hidesSearchBarWhenScrolling = false
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
        }// else if let object = object as? RProfessor {
        //    cell.textLabel?.text = object.name
        //} else if let object = object as? RPlace {
        //    cell.textLabel?.text = object.name
        //}

        return cell
    }
    
    // MARK: - Table view delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let object: REntitie
        if isFiltering {
            object = filtredData[indexPath.section][indexPath.row]
        } else {
            object = data[indexPath.section][indexPath.row]
        }
        
        if let object = object as? RGroup {
            showTimetable(withId: object.id, animatingViewController: self)
        }// else if let object = object as? RProfessor {
        //    showTimetable(withId: object.id, animatingViewController: self)
        //} else if let object = object as? RPlace {
        //    showTimetable(withId: object.id, animatingViewController: self)
        //}
    }
    
    // MARK: - Search Result Updating (не в качетстве расширения потому что дженерини не умеют работать с @objc в расширениях)
    func updateSearchResults(for searchController: UISearchController) {
        // TODO: Не ищет нормально
        guard let searchText = searchController.searchBar.text?.uppercased() else { return }
        filtredData = [
            data[0].filter("name CONTAINS[c] '\(searchText)'"),
            data[1].filter("name CONTAINS[c] '\(searchText)'")
        ]
        tableView.reloadData()
    }

}

// MARK: - Detail View Delegate
extension TableViewController: DetailViewDelegate {
    
    // MARK: Открыть расписания
    func showTimetable(withId id: Int, animatingViewController: AnimatingNetworkViewProtocol) {
        // берем группу с нужным id из всех групп
        // потом нужно просто запросить расписание из бд
        guard let entitie = data[1].filter("id = \(id)").first else { return }
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let timetableViewController = storyboard.instantiateViewController(withIdentifier: "TimetableViewControllerId") as! TimetableViewController
        timetableViewController.mood = .notBasic
        
        if let group = entitie as? RGroup {
            animatingViewController.startActivityIndicator()
            
            timetableViewController.type = .group
            
            var downloadedGroupTimetable: RGroupTimetable?
            var downloadedGroupsHash: String?
            
            // Обычный ход скачивания
            let completionOperation = BlockOperation {
                DispatchQueue.main.async {
                    if downloadedGroupsHash == UserDefaultsConfig.groupsHash {
                        self.push(
                            timetableViewController: timetableViewController,
                            optionalDownloadedTimetable: downloadedGroupTimetable,
                            groupId: group.id,
                            animatingViewController: animatingViewController)
                    } else {
                        self.loadNewGroups()
                    }
                }
            }
            
            let groupTimetableDownloadOperation = DownloadOperation(session: session, url: API.timetable(forGroupId: group.id)) { data, response, error in
                DispatchQueue.main.async {
                    // Вот из-за этого в главном потоке все :)
                    let (optionalGroupTimetable, optionalGroupHash) = ApiManager.handleGroupTimetableResponse(groupId: group.id, data, response, error)
                    
                    guard
                        let groupTimetable = optionalGroupTimetable,
                        let groupHash = optionalGroupHash
                    else {
                        DispatchQueue.main.async {
                            self.showAlertForNetwork()
                            self.stopActivityIndicator()
                        }
                        // Если не вышло скачать - прекращаем остальные загрузки и пытаемся открыть старое
                        self.downloadingQueue.cancelAllOperations()
                        self.push(
                            timetableViewController: timetableViewController,
                            optionalDownloadedTimetable: downloadedGroupTimetable,
                            groupId: group.id,
                            animatingViewController: animatingViewController)
                        return
                    }
                    
                    downloadedGroupsHash = groupHash
                    downloadedGroupTimetable = groupTimetable
                }
            }
            
            // Добавляем зависимости
            completionOperation.addDependency(groupTimetableDownloadOperation)
            
            // Добавляем все в очередь
            downloadingQueue.addOperation(groupTimetableDownloadOperation)
            downloadingQueue.addOperation(completionOperation)
        }
    }
    
    private func push(timetableViewController: TimetableViewController, optionalDownloadedTimetable: RGroupTimetable?, groupId: Int, animatingViewController: AnimatingNetworkViewProtocol) {
        // Если скачивание успешно - открываем скачанное
        if let downloadedTimetable = optionalDownloadedTimetable {
            DataManager.shared.write(groupTimetable: downloadedTimetable)
            guard let timetableForShowing = DataManager.shared.getTimetable(forGroupId: groupId) else { return }
            timetableViewController.timetable = timetableForShowing
            self.navigationController?.pushViewController(timetableViewController, animated: true)
        // Если скачивание не успешно, но есть уже загруженно до этого - открываем его
        } else if let localTimetable = DataManager.shared.getTimetable(forGroupId: groupId) {
            animatingViewController.showAlertForNetwork()
            timetableViewController.timetable = localTimetable
            self.navigationController?.pushViewController(timetableViewController, animated: true)
        // Иначе грустим
        } else {
            animatingViewController.showAlertForNetwork()
        }
        animatingViewController.stopActivityIndicator()
    }
    
    // MARK: Сделать расписание основным
    func makeTimetableBasic(withId id: Int, animatingViewController: AnimatingNetworkViewProtocol) {
        // берем группу с нужным id из всех групп
        // потом нужно просто запросить расписание из бд
        guard let entitie = data[1].filter("id = \(id)").first else { return }
        
        if let group = entitie as? RGroup {
            animatingViewController.startActivityIndicator()
            
            var downloadedGroupTimetable: RGroupTimetable?
            var downloadedGroupsHash: String?
            
            // Обычный ход скачивания
            let completionOperation = BlockOperation {
                DispatchQueue.main.async {
                    if downloadedGroupsHash == UserDefaultsConfig.groupsHash {
                        self.post(
                            optionalDownloadedTimetable: downloadedGroupTimetable,
                            groupId: group.id,
                            animatingViewController: animatingViewController)
                    } else {
                        self.loadNewGroups()
                    }
                }
            }
            
            let groupTimetableDownloadOperation = DownloadOperation(session: session, url: API.timetable(forGroupId: group.id)) { data, response, error in
                DispatchQueue.main.async {
                    // Вот из-за этого в главном потоке все :)
                    let (optionalGroupTimetable, optionalGroupHash) = ApiManager.handleGroupTimetableResponse(groupId: group.id, data, response, error)
                    
                    guard
                        let groupTimetable = optionalGroupTimetable,
                        let groupHash = optionalGroupHash
                    else {
                        DispatchQueue.main.async {
                            self.showAlertForNetwork()
                            self.stopActivityIndicator()
                        }
                        // Если не вышло скачать - прекращаем остальные загрузки и пытаемся открыть старое
                        self.downloadingQueue.cancelAllOperations()
                        self.post(
                            optionalDownloadedTimetable: downloadedGroupTimetable,
                            groupId: group.id,
                            animatingViewController: animatingViewController)
                        return
                    }
                    
                    downloadedGroupsHash = groupHash
                    downloadedGroupTimetable = groupTimetable
                }
            }
            
            // Добавляем зависимости
            completionOperation.addDependency(groupTimetableDownloadOperation)
            
            // Добавляем все в очередь
            downloadingQueue.addOperation(groupTimetableDownloadOperation)
            downloadingQueue.addOperation(completionOperation)
        }
    }
    
    private func post(optionalDownloadedTimetable: RGroupTimetable?, groupId: Int, animatingViewController: AnimatingNetworkViewProtocol) {
        // Если скачивание успешно - открываем скачанное
        if let downloadedTimetable = optionalDownloadedTimetable {
            DataManager.shared.write(groupTimetable: downloadedTimetable)
            guard let timetableForShowing = DataManager.shared.getTimetable(forGroupId: groupId) else { return }
            NotificationCenter.default.post(name: .didSelectGroup, object: nil, userInfo: [0: timetableForShowing])
        // Если скачивание не успешно, но есть уже загруженно до этого - открываем его
        } else if let localTimetable = DataManager.shared.getTimetable(forGroupId: groupId) {
            animatingViewController.showAlertForNetwork()
            NotificationCenter.default.post(name: .didSelectGroup, object: nil, userInfo: [0: localTimetable])
        // Иначе грустим
        } else {
            animatingViewController.showAlertForNetwork()
        }
        animatingViewController.stopActivityIndicator()
    }
    
    private func loadNewGroups() {
        // Тут качаем группы и хеш групп
        
        //var downloadedGroupTimetable: RGroupTimetable?
        var downloadedGroupsHash: String?
        var downloadedGroups: [RGroup]?

        let completionOperation = BlockOperation {
            DispatchQueue.main.async {
                guard
                    let downloadedGroups = downloadedGroups,
                    let downloadedGroupsHash = downloadedGroupsHash
                else {
                    DispatchQueue.main.async {
                        self.showAlertForNetwork()
                        self.stopActivityIndicator()
                    }
                    return
                }

                UserDefaultsConfig.groupsHash = downloadedGroupsHash
                DataManager.shared.write(groups: downloadedGroups)
                self.stopActivityIndicator()
                self.tableView.reloadData()
                print("Все норм братан")
            }
        }

        let groupsDownloadOperation = DownloadOperation(session: session, url: API.groups()) { data, response, error in
            DispatchQueue.main.async {
                guard let groups = ApiManager.handleGroupsResponse(data, response, error) else {
                    DispatchQueue.main.async {
                        self.showAlertForNetwork()
                        self.stopActivityIndicator()
                    }
                    self.downloadingQueue.cancelAllOperations()
                    return
                }

                downloadedGroups = groups
            }
        }
        
        let hashDownloadOperation = DownloadOperation(session: session, url: API.groupsHash()) { data, response, error in
            guard let hash = ApiManager.handleHashResponse(data, response, error) else {
                DispatchQueue.main.async {
                    self.showAlertForNetwork()
                    self.stopActivityIndicator()
                }
                self.downloadingQueue.cancelAllOperations()
                return
            }
            
            downloadedGroupsHash = hash
        }

        completionOperation.addDependency(groupsDownloadOperation)
        completionOperation.addDependency(hashDownloadOperation)

        downloadingQueue.addOperation(groupsDownloadOperation)
        downloadingQueue.addOperation(hashDownloadOperation)
        downloadingQueue.addOperation(completionOperation)
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
        }// else if let object = object as? RProfessor {
        //    DataManager.shared.writeFavorite(professor: object)
        //} else if let object = object as? RPlace {
        //    DataManager.shared.writeFavorite(place: object)
        //}
        
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
        }// else if let object = object as? RProfessor {
        //    DataManager.shared.deleteFavorite(professor: object)
        //} else if let object = object as? RPlace {
        //    DataManager.shared.deleteFavorite(place: object)
        //}
        
        tableView.reloadData()
    }

}


// MARK: - Animating Network View Protocol
extension TableViewController: AnimatingNetworkViewProtocol {
    
    // MARK: Activity Indicator
    func startActivityIndicator() {
        if !view.subviews.contains(viewWithActivityIndicator) {
            view.addSubview(viewWithActivityIndicator)
            viewWithActivityIndicator.translatesAutoresizingMaskIntoConstraints = false
            viewWithActivityIndicator.addConstraintsOnAllSides(to: view.safeAreaLayoutGuide, withConstant: 0)
        }
        viewWithActivityIndicator.startAnimating()
        tableView.isScrollEnabled = false
    }
    
    func stopActivityIndicator() {
        viewWithActivityIndicator.stopAnimating()
        tableView.isScrollEnabled = true
    }
    
    // MARK: Arert View
    func showAlertForNetwork() {
        if !view.subviews.contains(alertViewForNetrowk) {
            view.addSubview(alertViewForNetrowk)
            
            alertViewForNetrowk.translatesAutoresizingMaskIntoConstraints = false
            alertViewForNetrowk.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor).isActive = true
            alertViewForNetrowk.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        }
        
        alertViewForNetrowk.hideWithAnimation()
    }
    
}

//
//  ChoiceSearchViewController.swift
//  Timetable
//
//  Created by art-off on 01.05.2020.
//  Copyright © 2020 art-off. All rights reserved.
//

import UIKit

class ChoiceSearchViewController: UITableViewController{
    
    private let data = [
        "Группы",
        //"Преподаватели",
        //"Кабинеты"
    ]
    
    // MARK: - UI
    // MARK: Activity Indicator
    let viewWithActivityIndicator = ActivityIndicatorView()
    // MARK: Alert View
    let alertViewForNetrowk = AlertView(alertText: "Проблемы с сетью")
    
    
    // MARK: - Для загрузки таблиц групп/преподавателей/кабинетов
    let downloadingQueue: OperationQueue = {
        let queue = OperationQueue()
        queue.maxConcurrentOperationCount = 2
        return queue
    }()
    
    let session = URLSession(configuration: URLSessionConfiguration.default)

    
    // MARK: - Overrides
    override func loadView() {
        super.loadView()
        
        navigationItem.title = "Поиск"
        
        // Меняем слишь table view на .grouped
        tableView = UITableView(frame: self.tableView.frame, style: .grouped)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //view.backgroundColor = Colors.backgroungColor
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //task?.cancel()
        //taskForHash?.cancel()
        downloadingQueue.cancelAllOperations()
        stopActivityIndicator()
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
        // Сейчас создал один класс с дженериками
        
        if indexPath.row == 0 {
            // Если нет таблицы с группами - качаем
            if UserDefaultsConfig.groupsHash == nil || DataManager.shared.getGroups().isEmpty {
                startActivityIndicator()
                
                var downloadedGroups: [RGroup]?
                var downloadedHash: String?
                
                let completionOperation = BlockOperation {
                    guard
                        let downloadedGroups = downloadedGroups,
                        let downloadedHash = downloadedHash
                    else {
                        DispatchQueue.main.async {
                            self.showAlertForNetwork()
                            self.stopActivityIndicator()
                        }
                        return
                    }
                    
                    DispatchQueue.main.async {
                        UserDefaultsConfig.groupsHash = downloadedHash
                        DataManager.shared.write(groups: downloadedGroups)
                        
                        self.pushGroupTableViewController()
                    }
                }
                
                let groupsDownloadOperation = DownloadOperation(session: session, url: API.groups()) { data, response, error in
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
                
                let hashDownloadOperation = DownloadOperation(session: session, url: API.groupsHash()) { data, response, error in
                    guard let hash = ApiManager.handleHashResponse(data, response, error) else {
                        DispatchQueue.main.async {
                            self.showAlertForNetwork()
                            self.stopActivityIndicator()
                        }
                        self.downloadingQueue.cancelAllOperations()
                        return
                    }
                    
                    downloadedHash = hash
                }
                
                // Добавляем зависимости
                hashDownloadOperation.addDependency(groupsDownloadOperation)
                completionOperation.addDependency(hashDownloadOperation)
                completionOperation.addDependency(groupsDownloadOperation)
                
                // Добавляем в очередь все
                downloadingQueue.addOperation(groupsDownloadOperation)
                downloadingQueue.addOperation(hashDownloadOperation)
                downloadingQueue.addOperation(completionOperation)
            // Если есть, то все норм - открываем
            } else {
                pushGroupTableViewController()
            }
        }
    }
    
    private func pushGroupTableViewController() {
        let groupTableViewController = TableViewController<RGroup>()
        groupTableViewController.data = [
            DataManager.shared.getFavoriteGruops(),
            DataManager.shared.getGroups()
        ]
        navigationController?.pushViewController(groupTableViewController, animated: true)
    }

}


extension ChoiceSearchViewController: AnimatingNetworkViewProtocol {
    
    // MARK: Activity Indicator
    func startActivityIndicator() {
        if !view.subviews.contains(viewWithActivityIndicator) {
            view.addSubview(viewWithActivityIndicator)
            viewWithActivityIndicator.translatesAutoresizingMaskIntoConstraints = false
            viewWithActivityIndicator.addConstraintsOnAllSides(to: view.safeAreaLayoutGuide, withConstant: 0)
        }
        viewWithActivityIndicator.startAnimating()
        view.isUserInteractionEnabled = false
    }
    
    func stopActivityIndicator() {
        viewWithActivityIndicator.stopAnimating()
        view.isUserInteractionEnabled = true
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
    
    func popViewController() {
        //
    }
    
}

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
    
    // MARK: - Animating Network
    let activityIndicatorView = ActivityIndicatorView()
    let alertView = AlertView()

    
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
        //UserDefaultsConfig.groupsHash = nil
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)

        ApiManager.shared.cancelAllDownloading()
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
                self.startActivityIndicator()
                ApiManager.shared.loadGroupsAndGroupsHash { optionalGroupsHash, optionalGroups in
                    guard
                        let groupsHash = optionalGroupsHash,
                        let groups = optionalGroups
                    else {
                        DispatchQueue.main.async {
                            self.showAlertForNetwork()
                            self.stopActivityIndicator()
                        }
                        return
                    }
                    
                    DispatchQueue.main.async {
                        UserDefaultsConfig.groupsHash = groupsHash
                        DataManager.shared.write(groups: groups)
                        
                        self.pushGroupTableViewController()
                    }
                }
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
    func animatingSuperViewForDisplay() -> UIView {
        return view
    }
    
    func animatingViewForDisableUserInteraction() -> UIView {
        if let navBar = navigationController?.navigationBar {
            return navBar
        }
        return view
    }
    
    func animatingActivityIndicatorView() -> ActivityIndicatorView {
        return activityIndicatorView
    }
    
    func animatingAlertView() -> AlertView {
        return alertView
    }
    
    func popViewController() {
        //
    }
    
}

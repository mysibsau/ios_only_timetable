//
//  DetailViewController.swift
//  Timetable
//
//  Created by art-off on 13.05.2020.
//  Copyright © 2020 art-off. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    var data: [[String]]!
    var type: EntitiesType!
    
    
    let tableView = UITableView(frame: .zero, style: .grouped)
    
    
    override func loadView() {
        super.loadView()
        
        setupTableView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = Colors.backgroungColor
    }

    convenience init(group: RGroup) {
        self.init()
        
        navigationItem.title = group.name
        
        let tableData1 = [
            "Группа",
            group.name,
            group.email ?? "Нет email"
        ]
        let tableData2 = [
            "Староста",
            group.leaderName ?? "Нет ФИО",
            group.leaderEmail ?? "Нет email",
            group.leaderPhone ?? "Нет номера"
        ]
        
        data = [tableData1, tableData2]
        type = .gruop
    }
    
    convenience init(professor: RProfessor) {
        self.init()
        
        // Фамилия преподавателя в nav bar
        navigationItem.title = String(professor.name.split(separator: " ")[0])
        
        let tableData = [
            "Преподаватель",
            professor.name,
            professor.department ?? "Нет кафедры",
            professor.email ?? "Нет телефона"
        ]
        
        data = [tableData]
        type = .gruop
    }
    
    convenience init(place: RPlace) {
        self.init()
        
        navigationItem.title = place.name
        
        let tableData = [
            "Кабинет",
            place.name
        ]
        
        data = [tableData]
        type = .place
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.addConstraintsOnAllSides(to: view.safeAreaLayoutGuide, withConstant: 0)
        
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }


}

extension DetailViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        cell.textLabel?.text = data[indexPath.section][indexPath.row]
        
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.lineBreakMode = .byWordWrapping
        if indexPath.row == 0 {
            cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        }
        
        return cell
    }
    
}

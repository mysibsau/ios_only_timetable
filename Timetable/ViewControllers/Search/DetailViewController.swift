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
    var isSave: Bool!
    private var type: EntitiesType!
    private var id: Int!
    
    
    var buttons: [(text: String, color: UIColor)]!
    
    let tableView = UITableView(frame: .zero, style: .grouped)
    
    
    override func loadView() {
        super.loadView()
        
        setupTableView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = Colors.backgroungColor
    }

    // MARK: - Init
    
    convenience init(group: RGroup, isSave: Bool) {
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
        id = group.id
        self.isSave = isSave
        updateButtons()
    }
    
    convenience init(professor: RProfessor, isSave: Bool) {
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
        id = professor.id
        self.isSave = isSave
        updateButtons()
    }
    
    convenience init(place: RPlace, isSave: Bool) {
        self.init()
        
        navigationItem.title = place.name
        
        let tableData = [
            "Кабинет",
            place.name
        ]
        
        data = [tableData]
        type = .place
        id = place.id
        self.isSave = isSave
        updateButtons()
    }
    
    //MARK: - Setup View
    
    private func setupTableView() {
        view.addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.addConstraintsOnAllSides(to: view.safeAreaLayoutGuide, withConstant: 0)
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }
    
    private func updateButtons() {
        buttons = [
            isSave ? ("Удалить из 'Сохраненные'", .red) : ("Добавить в 'Сохраненные'", Colors.sibsuGreen),
            ("Показать расписание", .systemBlue)
        ]
    }

}

extension DetailViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return data.count + buttons.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // для секций с кнопкой
        if section >= data.count { return 1 }
        return data[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        // для кнопок
        if indexPath.section >= data.count {
            let indexButton = indexPath.section - data.count
            cell.textLabel?.text = buttons[indexButton].text
            cell.textLabel?.textAlignment = .center
            cell.textLabel?.textColor = buttons[indexButton].color
            return cell
        }
        
        cell.textLabel?.text = data[indexPath.section][indexPath.row]
        
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.lineBreakMode = .byWordWrapping
        if indexPath.row == 0 {
            cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        }
        
        return cell
    }
    
}

extension DetailViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.section, indexPath.row)
    }

}

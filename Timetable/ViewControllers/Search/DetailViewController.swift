//
//  DetailViewController.swift
//  Timetable
//
//  Created by art-off on 13.05.2020.
//  Copyright © 2020 art-off. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    var data: [[(text: String, color: UIColor?)]]!
    var isSave: Bool!
    
    private var type: EntitiesType!
    private var id: Int!
    
    private var firstSectionHeader: String? = nil
    private var secondSectionHeader: String? = nil
    
    
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
        
        // Формируем данные для отображения в таблице
        let tableData1 = [
            (group.name, nil),
            group.email != nil ? (group.email!, nil) : ("Нет email", UIColor.gray)
        ]
        let tableData2 = [
            group.leaderName  != nil ? (group.leaderName!, nil)  : ("Нет ФИО", UIColor.gray),
            group.leaderEmail != nil ? (group.leaderEmail!, nil) : ("Нет email", UIColor.gray),
            group.leaderPhone != nil ? (group.leaderPhone!, nil) : ("Нет номера", UIColor.gray)
        ]
        
        firstSectionHeader = "Группа"
        secondSectionHeader = "Староста"
        
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
        
        // Формируем данные для отображения в таблице
        let tableData = [
            (professor.name, nil),
            professor.department != nil ? (professor.department!, nil) : ("Нет кафедры", UIColor.gray),
            professor.email      != nil ? (professor.email!, nil)      : ("Нет email", UIColor.gray)
        ]
        
        firstSectionHeader = "Преподаватель"
        
        data = [tableData]
        type = .gruop
        id = professor.id
        self.isSave = isSave
        
        updateButtons()
    }
    
    convenience init(place: RPlace, isSave: Bool) {
        self.init()
        
        navigationItem.title = place.name
        
        // Формируем данные для отображения в таблице
        let tableData = [
            (place.name, UIColor?(nil))
        ]
        
        firstSectionHeader = "Кабинет"
        
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
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return firstSectionHeader
        } else if section == 1 {
            return secondSectionHeader
        } else {
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // для секций с кнопкой
        if section >= data.count { return 1 }
        return data[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.lineBreakMode = .byWordWrapping
        
        // для кнопок
        if indexPath.section >= data.count {
            let indexButton = indexPath.section - data.count
            cell.textLabel?.text = buttons[indexButton].text
            cell.textLabel?.textColor = buttons[indexButton].color
            cell.textLabel?.textAlignment = .center
            
            return cell
        }
        
        let currElem = data[indexPath.section][indexPath.row]
        cell.textLabel?.text = currElem.text
        cell.textLabel?.textColor = currElem.color
        
        return cell
    }
    
}

extension DetailViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.section, indexPath.row)
    }

}

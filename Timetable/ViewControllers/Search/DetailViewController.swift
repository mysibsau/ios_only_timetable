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
    var isFavorite: Bool!
    var delegate: DetailViewDelegate?
    
    // MARK: - Private
    // MARK: Массив кнопок
    private var buttons: [(text: String, color: UIColor, action: () -> ())]!
    
    private var type: EntitiesType!
    private var id: Int!
    
    // MARK: Заголовки для 1 и 2 секции
    private var firstSectionHeader: String? = nil
    private var secondSectionHeader: String? = nil
    
    private let tableView = UITableView(frame: .zero, style: .grouped)
    
    // MARK: Нижняя надпись, которыя появляется при копировании текста
    private let alertView = AlertView(alertText: "Текст скопирован")
    
    
    // MARK: - Overrides
    override func loadView() {
        super.loadView()
        
        setupTableView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = Colors.backgroungColor
        
        // скрываем алерт надпись
        alertView.isHidden = true
    }

    // MARK: - Initialization
    convenience init(group: RGroup, isFavorite: Bool) {
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
        type = .group
        id = group.id
        self.isFavorite = isFavorite
        
        updateButtons()
    }
    
    convenience init(professor: RProfessor, isFavorite: Bool) {
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
        type = .professor
        id = professor.id
        self.isFavorite = isFavorite
        
        updateButtons()
    }
    
    convenience init(place: RPlace, isFavorite: Bool) {
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
        self.isFavorite = isFavorite
        
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
        
        // добавляем отработку длинного нажатия (копирование)
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(copyTextFromCell(longPressGesture:)))
        longPressGesture.minimumPressDuration = 0.7
        tableView.addGestureRecognizer(longPressGesture)
        
    }
    
    // MARK: - Обработчки для долгого нажатия
    @objc private func copyTextFromCell(longPressGesture: UILongPressGestureRecognizer) {
        // Чтобы он срабатывал только один раз
        guard longPressGesture.state == .began else { return }
        
        let point = longPressGesture.location(in: tableView)
        guard let indexPath = tableView.indexPathForRow(at: point) else { return }
        
        // обходим обработку долгого нажатия на кнопки
        if indexPath.section < data.count {
            let cellText = data[indexPath.section][indexPath.row].text
            UIPasteboard.general.string = cellText
            // Леграя вибрация в конце длинного нажатия
            UIDevice.vibrate()
            showAlertView()
        }
    }
    
    private func showAlertView() {
        if !view.subviews.contains(alertView) {
            view.addSubview(alertView)
            
            alertView.translatesAutoresizingMaskIntoConstraints = false
            
            alertView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16).isActive = true
            alertView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8).isActive = true
            alertView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8).isActive = true
        }
        
        alertView.alpha = 1.0
        alertView.isHidden = false
        
        alertView.hideWithAnimation()
    }

}


// MARK: - Для кнопок
extension DetailViewController {
    
    private func updateButtons() {
        let addOrDeleteButton: (String, UIColor, () -> ())
        if isFavorite {
            addOrDeleteButton = ("Удалить из 'Избранное'", UIColor.systemRed, addOrDeleteFavorite)
        } else {
            addOrDeleteButton = ("Добавить в 'Избранное'", Colors.sibsuGreen, addOrDeleteFavorite)
        }
        
        let showButton = ("Показать расписание", UIColor.systemBlue, showTimetableHandler)
        
        buttons = [
            addOrDeleteButton,
            showButton
        ]
    }
    
    private func addOrDeleteFavorite() {
        guard let delegate = delegate else { return }
        
        if !isFavorite {
            delegate.addToFavorite(objectWithId: id)
        } else {
            delegate.removeFromFavorite(objectWithId: id)
        }
        
        isFavorite = !isFavorite
        updateButtons()
        tableView.reloadData()
    }
    
    private func showTimetableHandler() {
        guard let delegate = delegate else { return }
        delegate.showTimetable(withId: id)
    }
}

// MARK: - Table View Data Source
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

// MARK: - Table View Delegate
extension DetailViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // для обработки нажатий кнопок
        if indexPath.section >= data.count {
            let indexButton = indexPath.section - data.count
            buttons[indexButton].action()
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }

}

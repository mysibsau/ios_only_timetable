//
//  DetailViewController.swift
//  Timetable
//
//  Created by art-off on 13.05.2020.
//  Copyright © 2020 art-off. All rights reserved.
//

import UIKit

typealias CellData = (text: String, color: UIColor?)
private typealias Button = (text: String, color: UIColor, action: () -> ())

class DetailViewController: UIViewController {

    var data: [[CellData]]!
    var isFavorite: Bool!
    var delegate: DetailViewDelegate?
    
    // MARK: - Private
    // MARK: Массив кнопок
    private var buttons: [Button]!
    
    private var type: EntitiesType!
    private var id: Int!
    
    // MARK: Заголовки для 1 и 2 секции
    private var firstSectionHeader: String? = nil
    private var secondSectionHeader: String? = nil
    
    private let tableView = UITableView(frame: .zero, style: .grouped)
    
    private let alertViewForCoppy = AlertView(alertText: "Текст скопирован")
    
    let alertViewForNetwork = AlertView(alertText: "Проблема с сетью")
    let viewWithActivityIndicator = ActivityIndicatorView()
    
    
    // MARK: - Overrides
    override func loadView() {
        super.loadView()
        
        setupTableView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = Colors.backgroungColor
        
        // скрываем алерт надпись
        alertViewForCoppy.isHidden = true
    }

    // MARK: - Initialization
    convenience init(group: RGroup, isFavorite: Bool) {
        self.init()
        
        navigationItem.title = group.name
        
        // Формируем данные для отображения в таблице
        let tableData1 = [
            (group.name, UIColor?(nil)),
            // убрал из-за конфидеальность бла бла
            //group.email != nil ? (group.email!, nil) : ("Нет email", UIColor.gray)
        ]
        
        firstSectionHeader = "Группа"
        
        data = [tableData1]
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
            professor.email      != nil ? (professor.email!, nil)      : ("Нет email", UIColor.gray),
            professor.phone      != nil ? (professor.phone!, nil)      : ("Нет номера", UIColor.gray)
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
            showAlertViewForCoppy()
        }
    }
    
    private func showAlertViewForCoppy() {
        if !view.subviews.contains(alertViewForCoppy) {
            view.addSubview(alertViewForCoppy)
            
            alertViewForCoppy.translatesAutoresizingMaskIntoConstraints = false
            
            alertViewForCoppy.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16).isActive = true
            alertViewForCoppy.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8).isActive = true
            alertViewForCoppy.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8).isActive = true
        }
        
        alertViewForCoppy.hideWithAnimation()
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
        
        let makeBasicButton = ("Сделать основным", UIColor.blue, makeTimetableBasiHandler)
        
        let showButton = ("Показать расписание", UIColor.systemBlue, showTimetableHandler)
        
        buttons = [
            addOrDeleteButton,
            makeBasicButton,
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
    
    private func makeTimetableBasiHandler() {
        guard let delegate = delegate else { return }
        delegate.makeTimetableBasic(withId: id, animatingViewController: self)
    }
    
    private func showTimetableHandler() {
        guard let delegate = delegate else { return }
        delegate.showTimetable(withId: id, animatingViewController: self)
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


extension DetailViewController: AnimatingNetworkViewProtocol {
    
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
        if !view.subviews.contains(alertViewForNetwork) {
            view.addSubview(alertViewForNetwork)
            
            alertViewForNetwork.translatesAutoresizingMaskIntoConstraints = false
            alertViewForNetwork.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor).isActive = true
            alertViewForNetwork.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        }
        
        alertViewForNetwork.hideWithAnimation()
    }
    
}

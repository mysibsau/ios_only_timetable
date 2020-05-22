//
//  TimetableViewController.swift
//  Timetable
//
//  Created by art-off on 02.05.2020.
//  Copyright © 2020 art-off. All rights reserved.
//

import UIKit
import PagingKit

class TimetableViewController: UIViewController {
    
    var type: EntitiesType?
    var weeks: [Any]?
    var currWeek = 0
    
    
    @IBOutlet weak var numberWeekSegmentedView: UIView!
    @IBOutlet weak var numberWeekSegmented: UISegmentedControl!
    
    // MARK: Верхрее меню и контент для PagingKit
    private var menuViewController: PagingMenuViewController!
    private var contentViewController: PagingContentViewController!
    // MARK: линия, для выбранной ячейки в меню
    let focusView = UnderlineFocusView()
    
    // MARK: Для случая, если не выбрана группа/преподаватель/кабинет
    let alertForChoice = WrapperViewWithLabel(text: "Выберите группу, преподавателя или кабинет в 'Поиск'")
    
    
    // MARK: Для того, чтобы menuViewController занимал ровно весь экран
    private lazy var firstLoad: (() -> Void)? = { [weak self, menuViewController, contentViewController] in
        menuViewController?.reloadData()
        contentViewController?.reloadData { [weak self] in
            self?.adjustfocusViewWidth(index: 0, percent: 0)
        }
        self?.firstLoad = nil
    }
    
    // MARK: - Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // убираем нижний бордер у navigaton bar
        self.navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
        navigationItem.title = "Расписание"
        
        // настройка сегментера
        numberWeekSegmented.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
        numberWeekSegmentedView.backgroundColor = Colors.topBarColor
        numberWeekSegmented.selectedSegmentIndex = currWeek
        
        setupPagingKit()
        
        // загружаем расписание с помощью его id из UserDefaults, если там есть информация
        loadTimetableFromUserDetaults()
        
        // регистрируем наблюдателя за уведомлениями
        NotificationCenter.default.addObserver(self, selector: #selector(onDidSelectGroup(_:)), name: .didSelectGroup, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(onDidSelectProfessor(_:)), name: .didSelectProfessor, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(onDidSelectPlace(_:)), name: .didSelectPlace, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // если расписание есть, то нет смысла показывать надпись
        guard weeks == nil else {
            alertForChoice.isHidden = true
            return
        }
        
        // добавляем, если view с этой надписью еще не добавлена в subview
        if !view.subviews.contains(alertForChoice) {
            view.addSubview(alertForChoice)
            alertForChoice.frame = view.bounds
        }
        alertForChoice.isHidden = false
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        firstLoad?()
    }
    
    // MARK: - Для настройки PagingKit
    private func setupPagingKit() {
        menuViewController.view.backgroundColor = Colors.topBarColor
        
        // для скрола у последнего и первого элемента
        contentViewController.scrollView.bounces = true
        contentViewController.view.backgroundColor = Colors.backgroungColor
        
        focusView.underlineColor = .systemBlue
        focusView.underlineHeight = 3
        
        menuViewController.register(nib: UINib(nibName: "MenuCell", bundle: nil), forCellWithReuseIdentifier: "MenuCell")
        menuViewController.registerFocusView(view: focusView)
        
        menuViewController.reloadData()
        contentViewController.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? PagingMenuViewController {
            menuViewController = vc
            menuViewController.dataSource = self
            menuViewController.delegate = self
        } else if let vc = segue.destination as? PagingContentViewController {
            contentViewController = vc
            contentViewController.dataSource = self
            contentViewController.delegate = self
        }
    }
    
    // MARK: - Методы для Notification Center
    @objc func onDidSelectGroup(_ notification: Notification) {
        if let userInfo = notification.userInfo as? [Int: GroupTimetable] {
            type = .group
            
            print("IN onDidSelectGroup")
            guard let groupTimetable = userInfo[0] else { return }
            weeks = [GroupTimetable]()
            weeks?.append(groupTimetable.weeks[0])
            weeks?.append(groupTimetable.weeks[1])
            
            navigationItem.title = groupTimetable.groupName
            
            // Сохраняем выбранное расписание в UserDefaults
            UserDefaultsConfig.timetableType = type?.raw
            UserDefaultsConfig.timetableId = groupTimetable.groupId
            
            menuViewController.reloadData()
            contentViewController.reloadData()
        }
    }
    
    @objc func onDidSelectProfessor(_ notification: Notification) {
        type = .professor
        if let a = notification.userInfo as? [Int: RProfessor] {
            print("IN onDidSelectProfessor")
        }
    }
    
    @objc func onDidSelectPlace(_ notification: Notification) {
        type = .place
        if let a = notification.userInfo as? [Int: RPlace] {
            print("IN onDidSelectPlace")
        }
    }
    
    // MARK: - Загрузка расписания из UserDefaults
    private func loadTimetableFromUserDetaults() {
        // берем из UserDefaults тип расписания (группа, преподаватель, кабинет)
        guard let timetableTypeString = UserDefaultsConfig.timetableType else { return }
        guard let timetableType = EntitiesType(rawValue: timetableTypeString) else { return }
        
        // берем из UserDefaults id расписания
        guard let timetableId = UserDefaultsConfig.timetableId else { return }
        
        if timetableType == .group {
            guard let groupTimetable = DataManager.shared.getTimetable(forGroupId: timetableId) else { return }
            
            weeks = [GroupTimetable]()
            weeks?.append(groupTimetable.weeks[0])
            weeks?.append(groupTimetable.weeks[1])
            
            type = timetableType
            
            navigationItem.title = groupTimetable.groupName
            
            menuViewController.reloadData()
            contentViewController.reloadData()
        } else if timetableType == .professor {
            
            
            menuViewController.reloadData()
            contentViewController.reloadData()
        } else if timetableType == .place {
            
            
            menuViewController.reloadData()
            contentViewController.reloadData()
        }
    }
    
    // MARK: - IBActions
    // MARK: Изменение недели (нечетная / четная)
    @IBAction func numberWeekChanged(_ sender: UISegmentedControl) {
        currWeek = numberWeekSegmented.selectedSegmentIndex
        menuViewController.reloadData()
        contentViewController.reloadData()
    }
}


// MARK: - Настройка меню
extension TimetableViewController: PagingMenuViewControllerDataSource {
    
    // MARK: Число ячеек меню
    func numberOfItemsForMenuViewController(viewController: PagingMenuViewController) -> Int {
        //return dataSource.count
        return 6
    }
    
    // MARK: Формирование ячейки ( НУЖНО ДОПИСАТЬ ЕЩЕЕЕЕ )
    func menuViewController(viewController: PagingMenuViewController, cellForItemAt index: Int) -> PagingMenuViewCell {
        // FIXME: сделать нормальные числа и недели
        let cell = viewController.dequeueReusableCell(withReuseIdentifier: "MenuCell", for: index) as! MenuCell
        //cell.titleLabel.text = dataSource[index].menuTitle
        return cell
    }
    
    // MARK: Расчет ширины ячейки
    func menuViewController(viewController: PagingMenuViewController, widthForItemAt index: Int) -> CGFloat {
        //return viewController.view.bounds.width / CGFloat(dataSource.count)
        return viewController.view.bounds.width / CGFloat(6)
    }

}

// MARK: - Настройка слайдящихся экранов
extension TimetableViewController: PagingContentViewControllerDataSource {
    
    // MARK: Число экранов
    func numberOfItemsForContentViewController(viewController: PagingContentViewController) -> Int {
        //return dataSource.count
        return 6
    }

    // MARK: Отправка ViewController'а для индекса
    func contentViewController(viewController: PagingContentViewController, viewControllerAt index: Int) -> UIViewController {
        // FIXME: сделать нормальные числа и недели
        
        //return DayViewController()
        //return dataSource[index].vc
        guard let weeks = weeks else {
            return UIViewController()
        }
        // тут будет проверка на тип сущности, которой будет отображаться расписание (группа, преподаватель, кабинет)
        // FIXME: Не нужна тут проверка типа, скорее всего
        if type == .group {
            if let weeks = weeks as? [GroupWeek] {
                //return GroupDayViewController(day: weeks[currWeek].days[index])
                return GroupDayViewController(day: weeks[currWeek].days[index])
            }
        }
        return UIViewController()
    }

}

// MARK: - Делегат для меню
extension TimetableViewController: PagingMenuViewControllerDelegate {
    
    // MARK: Метод для перехода по выбранному пункту меню
    func menuViewController(viewController: PagingMenuViewController, didSelect page: Int, previousPage: Int) {
        contentViewController.scroll(to: page, animated: true)
    }

}

// MARK: - Делегат для слайдящихся экранов
extension TimetableViewController: PagingContentViewControllerDelegate {

    // MARK: Метод для синхронизации выбранного пункта в меню и текущего экрана
    func contentViewController(viewController: PagingContentViewController, didManualScrollOn index: Int, percent: CGFloat) {
        menuViewController.scroll(index: index, percent: percent, animated: true)
    }

    // MARK: Странная функция, которая помогает сделать ячейки меню правльной ширины (возможно стоит перенести в делегат меню)
    func adjustfocusViewWidth(index: Int, percent: CGFloat) {
        guard let leftCell = menuViewController.cellForItem(at: index) as? TitleLabelMenuViewCell,
            let rightCell = menuViewController.cellForItem(at: index + 1) as? TitleLabelMenuViewCell else {
                return
        }
        focusView.underlineWidth = rightCell.calcIntermediateLabelSize(with: leftCell, percent: percent)
    }

}

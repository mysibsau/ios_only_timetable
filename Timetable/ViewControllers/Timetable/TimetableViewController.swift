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
    private var menuViewController: PagingMenuViewController!
    private var contentViewController: PagingContentViewController!
    
    let focusView = UnderlineFocusView()
    
    // MARK: Для случая, если не выбрана группа/преподаватель/кабинет
    lazy var wrapperWithLabel: UIView = {
        let wrapper = UIView(frame: view.bounds)
        wrapper.backgroundColor = Colors.backgroungColor
        view.addSubview(wrapper)
        
        let label = UILabel(frame: view.bounds)
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.text = "Выберите\nгруппу,\nпреподавателя\nили кабинет\nв 'Поиск'"
        label.textAlignment = .center
        label.numberOfLines = 0
        
        wrapper.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerYAnchor.constraint(equalTo: wrapper.centerYAnchor).isActive = true
        label.centerXAnchor.constraint(equalTo: wrapper.centerXAnchor).isActive = true
        
        return wrapper
    }()
    
    
    // MARK: Для того, чтобы menuViewController занимал ровно весь экран
    private lazy var firstLoad: (() -> Void)? = { [weak self, menuViewController, contentViewController] in
        menuViewController?.reloadData()
        contentViewController?.reloadData { [weak self] in
            self?.adjustfocusViewWidth(index: 0, percent: 0)
        }
        self?.firstLoad = nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK: ЭТИ СТРОКИ --------------------------------------------------------------------------------------------------------------
        type = .group
        weeks = [GroupWeek]()
//        weeks?.append(Common.getWeek1())
//        weeks?.append(Common.getWeek2())
        let timetable = DataManager.shared.getTimetable(forGroupId: 1)!
        weeks?.append(timetable.weeks[0])
        weeks?.append(timetable.weeks[1])
        // MARK: ЭТИ СТРОКИ --------------------------------------------------------------------------------------------------------------
        
        // убираем нижний бордер у наб бара
        self.navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
        navigationItem.title = "БПИ18-01"
        
        numberWeekSegmented.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
        numberWeekSegmentedView.backgroundColor = Colors.topBarColor
        
        setupPagingKit()
        
        // регистрируем наблюдателя за уведомлениями
        NotificationCenter.default.addObserver(self, selector: #selector(onDidSelectGroup(_:)), name: .didSelectGroup, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(onDidSelectProfessor(_:)), name: .didSelectProfessor, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(onDidSelectPlace(_:)), name: .didSelectPlace, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // скрываем вью предложения выбора, если weeks != nil и наоборот
        wrapperWithLabel.isHidden = weeks != nil
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
        type = .group
        if let a = notification.userInfo as? [Int: String] {
            print("IN onDidSelectGroup")
            print(a[0])
            print(a[1])
        }
        // MARK: ЭТИ СТРОКИ --------------------------------------------------------------------------------------------------------------
        // тут weeks будет ставиться
    }
    
    @objc func onDidSelectProfessor(_ notification: Notification) {
        type = .professor
        if let a = notification.userInfo as? [Int: String] {
            print("IN onDidSelectProfessor")
            print(a[0])
            print(a[1])
        }
        // MARK: ЭТИ СТРОКИ --------------------------------------------------------------------------------------------------------------
        // тут weeks будет ставиться
    }
    
    @objc func onDidSelectPlace(_ notification: Notification) {
        type = .place
        if let a = notification.userInfo as? [Int: String] {
            print("IN onDidSelectPlace")
            print(a[0])
            print(a[1])
        }
        // MARK: ЭТИ СТРОКИ --------------------------------------------------------------------------------------------------------------
        // тут weeks будет ставиться
    }
    
    // MARK: - Изменение недели (нечетная / четная)
    @IBAction func numberWeekChanged(_ sender: UISegmentedControl) {
        currWeek = numberWeekSegmented.selectedSegmentIndex
        //print("RELOAD")
        // сюда вставить измеение
        menuViewController.reloadData()
        contentViewController.reloadData()
    }
    
    // MARK: - Загрузка расписания из UserDefaults
    private func loadTimetableFromUserDetaults() {
        // берем из UserDefaults тип расписания (группа, преподаватель, кабинет)
        guard let timetableTypeString = UserDefaultsConfig.timetableType else { return }
        guard let timetableType = EntitiesType(rawValue: timetableTypeString) else { return }
        
        guard let timetableId = UserDefaultsConfig.timetableId else { return }
        
        // ТУТ ДОПИСАТЬ ЗАПИСЬ В weeks
        // MARK: ЭТИ СТРОКИ --------------------------------------------------------------------------------------------------------------
        // тут weeks будет ставиться
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
        //return DayViewController()
        //return dataSource[index].vc
        guard let weeks = weeks else {
            return UIViewController()
        }
        // MARK: ЭТИ СТРОКИ --------------------------------------------------------------------------------------------------------------
        if type == .group {
            if let weeks = weeks as? [GroupWeek] {
                //return GroupDayViewController(day: weeks[currWeek].days[index])
                return GroupDayViewController(day: weeks[currWeek].days[index])
            }
        }
        return UIViewController()
        //return DayViewController(day: weeks[currWeek].days[index])
        // MARK: ЭТИ СТРОКИ --------------------------------------------------------------------------------------------------------------
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

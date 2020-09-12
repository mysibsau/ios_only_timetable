//
//  TimetableViewController.swift
//  Timetable
//
//  Created by art-off on 02.05.2020.
//  Copyright © 2020 art-off. All rights reserved.
//

import UIKit
import PagingKit

private typealias MenuCellData = (weekday: String, date: String)

// ####### ВАЖНО ##########
// reloadData вызывается только перед появлением view (viewWillAppear)
// и при смене недели
// у других местах его лучше не вызывать, неадекватное поведение
// ########################

class TimetableViewController: UIViewController {
    
    var type: EntitiesType?
    var mood: TimetableMood = .basic
    // Any потому что тут будут GroupTimetable, ProfessorTimetable и PlaceTimetable
    // думаю, можно сделать как то получше (протоколы и т д) но пока не придумал
    var timetable: Any?
    //var entitieId: Int?
    var currWeek = 0
    
    // MARK: Для скачивания расписания
    let downloadingQueue: OperationQueue = {
        let queue = OperationQueue()
        queue.maxConcurrentOperationCount = 2
        return queue
    }()
    let session = URLSession(configuration: URLSessionConfiguration.default)
    
    // MARK: Animating Network
    let activityIndicatorView = ActivityIndicatorView()
    let alertView = AlertView()
    
    // Данные для ячеек дня недели и даты
    private var menuData: [[MenuCellData]]?
    
    
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
    private lazy var firstLoadForPagingKit: (() -> Void)? = { [weak self, menuViewController, contentViewController] in
        menuViewController?.reloadData()
        contentViewController?.reloadData { [weak self] in
            self?.adjustfocusViewWidth(index: 0, percent: 0)
        }
        self?.firstLoadForPagingKit = nil
    }
    
    // MARK: Для показывания сегодняшнего дня только при первом появлении view
    private lazy var firstLoadForViewWillAppearSelectToday: (() -> Void)? = { [weak self, menuViewController, contentViewController] in
        self?.selectToday()
        self?.firstLoadForViewWillAppearSelectToday = nil
    }
    private lazy var firstLoadForViewDidAppearSelectToday: (() -> Void)? = { [weak self, menuViewController, contentViewController] in
        self?.selectToday()
        self?.firstLoadForViewDidAppearSelectToday = nil
    }
    
    // MARK: - Overrides
    override func loadView() {
        super.loadView()
        
        // убираем нижний бордер у navigaton bar
        self.navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
        navigationItem.title = "Расписание"
        
        // настройка сегментера
        numberWeekSegmented.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
        numberWeekSegmentedView.backgroundColor = Colors.topBarColor
        numberWeekSegmented.selectedSegmentIndex = currWeek
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupPagingKit()
        
        menuData = [
            DateHelper.getDatesNotEvenWeek(),
            DateHelper.getDatesEvenWeek()
        ]

        // и если это основной экран расписания
        if mood == .basic {
            // загружаем расписание с помощью его id из UserDefaults, если там есть информация
            loadTimetableFromUserDetaults()
            
            // регистрируем наблюдателя за уведомлениями
            NotificationCenter.default.addObserver(self, selector: #selector(onDidSelectGroup(_:)), name: .didSelectGroup, object: nil)
            //NotificationCenter.default.addObserver(self, selector: #selector(onDidSelectProfessor(_:)), name: .didSelectProfessor, object: nil)
            //NotificationCenter.default.addObserver(self, selector: #selector(onDidSelectPlace(_:)), name: .didSelectPlace, object: nil)
        } else if mood == .notBasic {
            if let timetable = timetable as? GroupTimetable {
                navigationItem.title = timetable.groupName
            }// else if let timetable = timetable as? ProfessorTimetable {
            //    navigationItem.title = timetable.professorName
            //} else if let timetable = timetable as? PlaceTimetable {
            //    navigationItem.title = timetable.placeName
            //}
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard timetable != nil else {
            showAlertForChoice()
            return
        }
        alertForChoice.isHidden = true
        
        // Да, нужно юзать 2 раза (это первый) - сраный PagingKit
        //selectToday()
        firstLoadForViewWillAppearSelectToday?()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Да, нужно юзать 2 раза (это второй) - сраный PagingKit
        //selectToday()
        firstLoadForViewDidAppearSelectToday?()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        firstLoadForPagingKit?()
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
    
    // MARK: - Private Methods
    private func selectToday() {
        let (currWeekNumber, currWeekdayNumber) = getCurrWeekNumberAndCurrWeekdayNumber()
        
        numberWeekSegmented.selectedSegmentIndex = currWeekNumber
        currWeek = currWeekNumber
        
        menuViewController.scroll(index: currWeekdayNumber - 1, animated: true)
        contentViewController.scroll(to: currWeekdayNumber - 1, animated: true)
        
        menuViewController.reloadData()
        contentViewController.reloadData()
    }
    
    private func getCurrWeekNumberAndCurrWeekdayNumber() -> (currWeekNumber: Int, currWeekdayNumber: Int) {
        // Выбираем текущую неделю
        let currWeekNumber: Int
        if DateHelper.currWeekIsEven() {
            currWeekNumber = 1
        } else {
            currWeekNumber = 0
        }
        
        // Выбираем текущий день
        var currWeekdayNumber = DateHelper.getCurrNumberWeekday()
        // Воскресенья у меня тут нет
        if currWeekdayNumber == 7 {
            currWeekdayNumber -= 1
        }
        
        return (currWeekNumber, currWeekdayNumber)
    }
    
    // MARK: - Методы для Notification Center
    @objc func onDidSelectGroup(_ notification: Notification) {
        if let userInfo = notification.userInfo as? [Int: GroupTimetable] {
            type = .group
            
            guard let groupTimetable = userInfo[0] else { return }
            DispatchQueue.main.async {
                self.set(timetable: groupTimetable)
            }
            //entitieId = groupTimetable.groupId
            
            navigationItem.title = groupTimetable.groupName
            
            // Сохраняем выбранное расписание в UserDefaults
            UserDefaultsConfig.timetableType = type?.raw
            UserDefaultsConfig.timetableId = groupTimetable.groupId
        }
    }
    
//    @objc func onDidSelectProfessor(_ notification: Notification) {
//        if let userInfo = notification.userInfo as? [Int: ProfessorTimetable] {
//            type = .professor
//
//            guard let professorTimetable = userInfo[0] else { return }
//            timetable = professorTimetable
//
//            navigationItem.title = professorTimetable.professorName
//
//            // Сохраняем выбранное расписание в UserDefaults
//            UserDefaultsConfig.timetableType = type?.raw
//            UserDefaultsConfig.timetableId = professorTimetable.professorId
//        }
//    }
//
//    @objc func onDidSelectPlace(_ notification: Notification) {
//        if let userInfo = notification.userInfo as? [Int: PlaceTimetable] {
//            type = .place
//
//            guard let placeTimetable = userInfo[0] else { return }
//            timetable = placeTimetable
//
//            navigationItem.title = placeTimetable.placeName
//
//            // Сохраняем выбранное расписание у UserDefaults
//            UserDefaultsConfig.timetableType = type?.raw
//            UserDefaultsConfig.timetableId = placeTimetable.placeId
//        }
//    }
    
    // MARK: - Загрузка расписания из UserDefaults
    private func loadTimetableFromUserDetaults() {
        // берем из UserDefaults тип расписания (группа, преподаватель, кабинет)
        guard let timetableTypeString = UserDefaultsConfig.timetableType else { return }
        guard let timetableType = EntitiesType(rawValue: timetableTypeString) else { return }
        
        // берем из UserDefaults id расписания
        guard let timetableId = UserDefaultsConfig.timetableId else { return }
        
        if timetableType == .group {
            guard let groupTimetable = DataManager.shared.getTimetable(forGroupId: timetableId) else { return }
            
            timetable = groupTimetable
            type = timetableType
            
            navigationItem.title = groupTimetable.groupName
            
        }// else if timetableType == .professor {
        //    guard let professorTimetable = DataManager.shared.getTimetable(forProfessorId: timetableId) else { return }
        //
        //    timetable = professorTimetable
        //    type = timetableType
        //
        //    navigationItem.title = professorTimetable.professorName
        //
        //} else if timetableType == .place {
        //    guard let placeTimetable = DataManager.shared.getTimetable(forPlaceId: timetableId) else { return }
        //
        //    timetable = placeTimetable
        //    type = timetableType
        //
        //    navigationItem.title = placeTimetable.placeName
        //}
    }
    
    // MARK: - Для использования в Search
    func set(timetable: Any?) {
        self.timetable = timetable
        self.contentViewController.reloadData()
        self.menuViewController.reloadData()
    }
    
    // MARK: - Show Alert
    // MARK: Show Alert For Choice
    func showAlertForChoice() {
        // добавляем, если view с этой надписью еще не добавлена в subview
        if !view.subviews.contains(alertForChoice) {
            view.addSubview(alertForChoice)
            alertForChoice.frame = view.bounds
        }
        alertForChoice.isHidden = false
    }
    
    // MARK: - IBActions
    // MARK: Изменение недели (нечетная / четная)
    @IBAction func numberWeekChanged(_ sender: UISegmentedControl) {
        currWeek = numberWeekSegmented.selectedSegmentIndex
        menuViewController.reloadData()
        contentViewController.reloadData()
    }
    
    // MARK: Для выбора текущего дня
    @IBAction func selectTodayTapped(_ sender: UIBarButtonItem) {
        selectToday()
    }
    
    @IBAction func refreshTimetableTapped(_ sender: UIBarButtonItem) {
        loadCurrGroupTimetable(animatingViewController: self)
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
        cell.weekdayLabel.text = menuData?[currWeek][index].weekday
        cell.dateLabel.text = menuData?[currWeek][index].date
        cell.isToday = isToday(weekNumber: currWeek, weekdayNumber: index + 1)
        return cell
    }
    
    // MARK: Расчет ширины ячейки
    func menuViewController(viewController: PagingMenuViewController, widthForItemAt index: Int) -> CGFloat {
        //return viewController.view.bounds.width / CGFloat(dataSource.count)
        return viewController.view.bounds.width / CGFloat(6)
    }
    
    private func isToday(weekNumber: Int, weekdayNumber: Int) -> Bool {
        let (currWeekNumber, currWeekdayNumber) = getCurrWeekNumberAndCurrWeekdayNumber()
        
        // Если сейчас воскресенье - нет текущего дня
        if DateHelper.getCurrNumberWeekday() == 7 {
            return false
        }
        
        return currWeekNumber == weekNumber && currWeekdayNumber == weekdayNumber
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
        guard let timetable = timetable else {
            return UIViewController()
        }
        // тут будет проверка на тип сущности, которой будет отображаться расписание (группа, преподаватель, кабинет)
        // FIXME: Не нужна тут проверка типа, скорее всего
        if type == .group {
            if let timetable = timetable as? GroupTimetable {
                return DayViewController<GroupDay>(day: timetable.weeks[currWeek].days[index])
            }
        }// else if type == .professor {
        //    if let timetable = timetable as? ProfessorTimetable {
        //        return DayViewController<ProfessorDay>(day: timetable.weeks[currWeek].days[index])
        //    }
        //} else if type == .place {
        //    if let timetable = timetable as? PlaceTimetable {
        //        return DayViewController<PlaceDay>(day: timetable.weeks[currWeek].days[index])
        //    }
        //}
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


// MARK: - Animating Network View Protocol
extension TimetableViewController: AnimatingNetworkViewProtocol {
    
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


// MARK: - Скачивание расписания для групп
extension TimetableViewController {
    
    func loadCurrGroupTimetable(animatingViewController: AnimatingNetworkViewProtocol) {
        //guard let groupId = entitieId else { return }
        guard let groupId = (timetable as? GroupTimetable)?.groupId else { return }
        animatingViewController.startActivityIndicator()
        
        var downloadedGroupTimetable: RGroupTimetable?
        var downloadedGroupsHash: String?
        
        let completionOperation = BlockOperation {
            if downloadedGroupsHash == UserDefaultsConfig.groupsHash {
                guard let downloadedGroupTimetable = downloadedGroupTimetable else {
                    self.showAlertForNetwork()
                    self.stopActivityIndicator()
                    return
                }
                DispatchQueue.main.async {
                    DataManager.shared.write(groupTimetable: downloadedGroupTimetable)
                    guard let timetableForShowing = DataManager.shared.getTimetable(forGroupId: downloadedGroupTimetable.groupId) else {
                        self.showAlertForNetwork()
                        return
                    }
                    
                    self.set(timetable: timetableForShowing)
                    animatingViewController.stopActivityIndicator()
                }
            } else {
                self.loadNewGroups(animatingViewController: animatingViewController)
            }
        }
        
        let groupTimetableDownloadOperation = DownloadOperation(session: session, url: API.timetable(forGroupId: groupId)) { data, response, error in
            let (optionalGroupTimetable, optionalGroupHash) = ApiManager.handleGroupTimetableResponse(groupId: groupId, data, response, error)
            
            guard
                let groupTimetable = optionalGroupTimetable,
                let groupHash = optionalGroupHash
            else {
                // Есил не вышло скачать - прекращаем все загрузки и пытаемся открыть старое
                self.downloadingQueue.cancelAllOperations()
                DispatchQueue.main.async {
                    animatingViewController.showAlertForNetwork()
                    animatingViewController.stopActivityIndicator()
                }
                return
            }
            
            downloadedGroupsHash = groupHash
            downloadedGroupTimetable = groupTimetable
        }
        
        // Добавляем зависимости
        completionOperation.addDependency(groupTimetableDownloadOperation)
        
        // Добавляем все в очередь
        downloadingQueue.addOperation(groupTimetableDownloadOperation)
        downloadingQueue.addOperation(completionOperation)
    }
    
    private func loadNewGroups(animatingViewController: AnimatingNetworkViewProtocol) {
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
                        animatingViewController.showAlertForNetwork()
                        animatingViewController.stopActivityIndicator()
                    }
                    return
                }

                UserDefaultsConfig.groupsHash = downloadedGroupsHash
                DataManager.shared.write(groups: downloadedGroups)
                animatingViewController.stopActivityIndicator()

                self.set(timetable: nil)
                self.showAlertForChoice()
                
                print("Все норм братан")
            }
        }

        let groupsDownloadOperation = DownloadOperation(session: session, url: API.groups()) { data, response, error in
            DispatchQueue.main.async {
                guard let groups = ApiManager.handleGroupsResponse(data, response, error) else {
                    DispatchQueue.main.async {
                        animatingViewController.showAlertForNetwork()
                        animatingViewController.stopActivityIndicator()
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
                    animatingViewController.showAlertForNetwork()
                    animatingViewController.stopActivityIndicator()
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
    
}

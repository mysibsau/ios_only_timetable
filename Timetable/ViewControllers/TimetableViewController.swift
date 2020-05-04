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
    
    var type: TimetableType?
    var weeks: [Week]?
    var currWeek = 0
    
    
    @IBOutlet weak var numberWeekSegmentedView: UIView!
    @IBOutlet weak var numberWeekSegmented: UISegmentedControl!
    var menuViewController: PagingMenuViewController!
    var contentViewController: PagingContentViewController!
    
    let focusView = UnderlineFocusView()
    
    // для случая, если не выбрана группа/преподаватель/кабинет
    lazy var wrapperWithLabel: UIView = {
        let wrapper = UIView(frame: view.bounds)
        wrapper.backgroundColor = Colors.backgroungColor
        view.addSubview(wrapper)
        let label = UILabel(frame: view.bounds)
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.text = "Выберите\nгруппу, преподавателя\nили кабинет\nв 'Поиск'"
        label.textAlignment = .center
        label.numberOfLines = 0
        wrapper.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerYAnchor.constraint(equalTo: wrapper.centerYAnchor).isActive = true
        label.centerXAnchor.constraint(equalTo: wrapper.centerXAnchor).isActive = true
        return wrapper
    }()
    
    
    // для того, чтобы menuViewController занимал ровно весь экран
    private lazy var firstLoad: (() -> Void)? = { [weak self, menuViewController, contentViewController] in
        menuViewController?.reloadData()
        contentViewController?.reloadData { [weak self] in
            self?.adjustfocusViewWidth(index: 0, percent: 0)
        }
        self?.firstLoad = nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        weeks = []
        weeks?.append(Common.getWeek1())
        weeks?.append(Common.getWeek2())
        
        NotificationCenter.default.addObserver(self, selector: #selector(onDidSelectGroup(_:)), name: .didSelectGroup, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(onDidSelectProfessor(_:)), name: .didSelectProfessor, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(onDidSelectPlace(_:)), name: .didSelectPlace, object: nil)
        
        numberWeekSegmented.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
        numberWeekSegmentedView.backgroundColor = Colors.topBarColor
        menuViewController.view.backgroundColor = Colors.topBarColor
        
        // убираем нижний бордер у наб бара
        self.navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
        navigationItem.title = "БПИ18-01"
        
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
    
    override func viewWillAppear(_ animated: Bool) {
        // скрываем вью предложения выбора, если weeks != nil и наоборот
        wrapperWithLabel.isHidden = !(weeks == nil)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        firstLoad?()
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
    
    // MARK: - Методы для NotificationCenter
    @objc func onDidSelectGroup(_ notification: Notification) {
        type = .gruop
    }
    
    @objc func onDidSelectProfessor(_ notification: Notification) {
        type = .professor
    }
    
    @objc func onDidSelectPlace(_ notification: Notification) {
        type = .place
    }
    
    // MARK: Изменение недели (нечетная / четная)
    @IBAction func numberWeekChanged(_ sender: UISegmentedControl) {
        currWeek = numberWeekSegmented.selectedSegmentIndex
        print("RELOAD")
        // сюда вставить измеение
        menuViewController.reloadData()
        contentViewController.reloadData()
    }
    
}


extension TimetableViewController: PagingMenuViewControllerDataSource {

    func numberOfItemsForMenuViewController(viewController: PagingMenuViewController) -> Int {
        //return dataSource.count
        return 6
    }

    func menuViewController(viewController: PagingMenuViewController, cellForItemAt index: Int) -> PagingMenuViewCell {
        let cell = viewController.dequeueReusableCell(withReuseIdentifier: "MenuCell", for: index) as! MenuCell
        //cell.titleLabel.text = dataSource[index].menuTitle
        return cell
    }

    func menuViewController(viewController: PagingMenuViewController, widthForItemAt index: Int) -> CGFloat {
        //return viewController.view.bounds.width / CGFloat(dataSource.count)
        return viewController.view.bounds.width / CGFloat(6)
    }

}

extension TimetableViewController: PagingContentViewControllerDataSource {

    func numberOfItemsForContentViewController(viewController: PagingContentViewController) -> Int {
        //return dataSource.count
        return 6
    }

    func contentViewController(viewController: PagingContentViewController, viewControllerAt index: Int) -> UIViewController {
        //return DayViewController()
        //return dataSource[index].vc
        guard let weeks = weeks else {
            return UIViewController()
        }
        return DayViewController(day: weeks[currWeek].days[index])
    }

}

extension TimetableViewController: PagingMenuViewControllerDelegate {

    func menuViewController(viewController: PagingMenuViewController, didSelect page: Int, previousPage: Int) {
        contentViewController.scroll(to: page, animated: true)
    }

}

extension TimetableViewController: PagingContentViewControllerDelegate {

    func contentViewController(viewController: PagingContentViewController, didManualScrollOn index: Int, percent: CGFloat) {
        menuViewController.scroll(index: index, percent: percent, animated: true)
    }

    func adjustfocusViewWidth(index: Int, percent: CGFloat) {
        guard let leftCell = menuViewController.cellForItem(at: index) as? TitleLabelMenuViewCell,
            let rightCell = menuViewController.cellForItem(at: index + 1) as? TitleLabelMenuViewCell else {
                return
        }
        focusView.underlineWidth = rightCell.calcIntermediateLabelSize(with: leftCell, percent: percent)
    }

}

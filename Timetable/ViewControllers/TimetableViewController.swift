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
    
    var typeTimetable: TypeTimetable?
    var week: [Week]?
    
    
    @IBOutlet weak var numberWeekSegmentedView: UIView!
    @IBOutlet weak var numberWeekSegmented: UISegmentedControl!
    var menuViewController: PagingMenuViewController!
    var contentViewController: PagingContentViewController!
    
    let focusView = UnderlineFocusView()
    
    var dataSource = [
        //[
            (menuTitle: "Пн", vc: DayViewController()),
            (menuTitle: "Вт", vc: DayViewController()),
            (menuTitle: "Ср", vc: DayViewController()),
            (menuTitle: "Чт", vc: DayViewController()),
            (menuTitle: "Пт", vc: DayViewController()),
            (menuTitle: "Сб", vc: DayViewController())
        //]
    ]
    
//    var dataSource = [
//        (),
//        (),
//        (),
//        (),
//        (),
//        (),
//    ]
    
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
        
        numberWeekSegmented.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
        
        // убираем нижний бордер у наб бара
        self.navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
        navigationItem.title = "БПИ18-01"
        
        numberWeekSegmentedView.backgroundColor = Colors.topBarColor
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
    
    
    @IBAction func numberWeekChanged(_ sender: UISegmentedControl) {
        print("RELOAD")
        menuViewController.reloadData()
        contentViewController.reloadData()
    }
    
}


extension TimetableViewController: PagingMenuViewControllerDataSource {

    func numberOfItemsForMenuViewController(viewController: PagingMenuViewController) -> Int {
        return dataSource.count
    }

    func menuViewController(viewController: PagingMenuViewController, cellForItemAt index: Int) -> PagingMenuViewCell {
        let cell = viewController.dequeueReusableCell(withReuseIdentifier: "MenuCell", for: index) as! MenuCell
        //cell.titleLabel.text = dataSource[index].menuTitle
        return cell
    }

    func menuViewController(viewController: PagingMenuViewController, widthForItemAt index: Int) -> CGFloat {
        return viewController.view.bounds.width / CGFloat(dataSource.count)
    }

}

extension TimetableViewController: PagingContentViewControllerDataSource {

    func numberOfItemsForContentViewController(viewController: PagingContentViewController) -> Int {
        return dataSource.count
    }

    func contentViewController(viewController: PagingContentViewController, viewControllerAt index: Int) -> UIViewController {
        //return DayViewController()
        return dataSource[index].vc
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

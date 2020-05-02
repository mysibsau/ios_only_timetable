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
    
    var menuViewController: PagingMenuViewController!
    var contentViewController: PagingContentViewController!
    
    let focusView = UnderlineFocusView()
    
    
    static var viewController: (UIColor) -> UIViewController = { (color) in
        let vc = UIViewController()
        vc.view.backgroundColor = color
        return vc
    }
    
    var dataSource = [
        (menuTitle: "Пон", vc: DayViewController()),
        (menuTitle: "Вт", vc: DayViewController()),
        (menuTitle: "Ср", vc: DayViewController()),
        (menuTitle: "Чт", vc: DayViewController()),
        (menuTitle: "Пт", vc: DayViewController()),
        (menuTitle: "Сб", vc: DayViewController())
    ]
    

    lazy var firstLoad: (() -> Void)? = { [weak self, menuViewController, contentViewController] in
        menuViewController?.reloadData()
        contentViewController?.reloadData { [weak self] in
            self?.adjustfocusViewWidth(index: 0, percent: 0)
        }
        self?.firstLoad = nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(navigationController?.navigationBar.tintColor)
        print(navigationController?.toolbar.barTintColor)
        // убираем нижний бордер у наб бара
        self.navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
        navigationItem.title = "БПИ18-01"
        
        focusView.underlineColor = .systemBlue
        focusView.underlineHeight = 2

        menuViewController.register(nib: UINib(nibName: "MenuCell", bundle: nil), forCellWithReuseIdentifier: "MenuCell")
        //menuViewController.register(type: TitleLabelMenuViewCell.self, forCellWithReuseIdentifier: "MenuCell")
        //menuViewController.registerFocusView(nib: UINib(nibName: "FocusView", bundle: nil))
        menuViewController.registerFocusView(view: focusView)
        
        contentViewController.scrollView.bounces = true
        //focusView.underlineWidth = 40
        
        //menuViewController.view.backgroundColor = Colors.contentColor
        contentViewController.view.backgroundColor = Colors.backgroungColor
        
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

}

//extension TimetableViewController: PagingMenuViewControllerDataSource {
//    func menuViewController(viewController: PagingMenuViewController, cellForItemAt index: Int) -> PagingMenuViewCell {
//        let cell = viewController.dequeueReusableCell(withReuseIdentifier: "MenuCell", for: index)  as! MenuCell
//        //cell.titleLabel.text = dataSource[index].menuTitle
//        return cell
//    }
//
//    func menuViewController(viewController: PagingMenuViewController, widthForItemAt index: Int) -> CGFloat {
//        focusView.underlineWidth = viewController.view.bounds.width / CGFloat(dataSource.count)
//        return viewController.view.bounds.width / CGFloat(dataSource.count)
//    }
//
//    var insets: UIEdgeInsets {
//        if #available(iOS 11.0, *) {
//            return view.safeAreaInsets
//        } else {
//            return .zero
//        }
//    }
//
//    func numberOfItemsForMenuViewController(viewController: PagingMenuViewController) -> Int {
//        return dataSource.count
//    }
//}
//
//extension TimetableViewController: PagingContentViewControllerDataSource {
//    func numberOfItemsForContentViewController(viewController: PagingContentViewController) -> Int {
//        return dataSource.count
//    }
//
//    func contentViewController(viewController: PagingContentViewController, viewControllerAt index: Int) -> UIViewController {
//        return dataSource[index].vc
//    }
//}
//
//extension TimetableViewController: PagingMenuViewControllerDelegate {
//    func menuViewController(viewController: PagingMenuViewController, didSelect page: Int, previousPage: Int) {
//        print("MENU VIEW did select: page - \(page), previousPage - \(previousPage)")
//        contentViewController.scroll(to: page, animated: true)
//    }
//}
//
//extension TimetableViewController: PagingContentViewControllerDelegate {
//    func contentViewController(viewController: PagingContentViewController, didManualScrollOn index: Int, percent: CGFloat) {
//        print("CONTENT VIEW did manual scroll on : index - \(index), percent - \(percent)")
//        if index == 0 && percent < -0.20 {
//            contentViewController.scroll(to: dataSource.count-1, animated: true)
//            menuViewController.scroll(index: dataSource.count-1, animated: true)
//            return
//        }
//        if index == dataSource.count-1 && percent > 0.20 {
//            contentViewController.scroll(to: 0, animated: true)
//            menuViewController.scroll(index: 0, animated: true)
//            return
//        }
//        menuViewController.scroll(index: index, percent: percent, animated: false)
//        adjustfocusViewWidth(index: index, percent: percent)
//    }
//
//    func adjustfocusViewWidth(index: Int, percent: CGFloat) {
//        guard let leftCell = menuViewController.cellForItem(at: index) as? TitleLabelMenuViewCell,
//            let rightCell = menuViewController.cellForItem(at: index + 1) as? TitleLabelMenuViewCell else {
//            return
//        }
//        focusView.underlineWidth = rightCell.calcIntermediateLabelSize(with: leftCell, percent: percent)
//    }
//}



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

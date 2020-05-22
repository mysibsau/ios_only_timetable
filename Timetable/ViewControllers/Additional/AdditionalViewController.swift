//
//  AdditionalViewController.swift
//  Timetable
//
//  Created by art-off on 22.05.2020.
//  Copyright © 2020 art-off. All rights reserved.
//

import UIKit

class AdditionalViewController: UIViewController {

    let alert = WrapperViewWithLabel(text: "В данный момент этот раздел недоступен")

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Дополнительно"
    }

    override func viewWillAppear(_ animated: Bool) {
        // добавляем, если view с этой надписью еще не добавлена в subview
        if !view.subviews.contains(alert) {
            view.addSubview(alert)
            alert.frame = view.bounds
        }
        alert.isHidden = false
    }

}

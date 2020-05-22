//
//  SessionViewController.swift
//  Timetable
//
//  Created by art-off on 22.05.2020.
//  Copyright © 2020 art-off. All rights reserved.
//

import UIKit

class SessionViewController: UIViewController {
    
    let alert = WrapperViewWithLabel(text: "В данный момент сессия недоступна")

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Сессия"
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

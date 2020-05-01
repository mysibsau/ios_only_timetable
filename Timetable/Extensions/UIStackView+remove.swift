//
//  UIStackView+Extensions.swift
//  Timetable
//
//  Created by art-off on 10.04.2020.
//  Copyright © 2020 art-off. All rights reserved.
//

import UIKit

extension UIStackView {
    
    func removeAllArrangedSubviews() {
        for view in arrangedSubviews {
            view.removeFromSuperview()
        }
    }
    
}

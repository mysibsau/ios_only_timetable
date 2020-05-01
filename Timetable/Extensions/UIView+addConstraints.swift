//
//  UIView+Extensions.swift
//  Timetable
//
//  Created by art-off on 09.04.2020.
//  Copyright © 2020 art-off. All rights reserved.
//

import UIKit

extension UIView {
    
    func addConstraintsOnAllSides(to toView: UIView, withConstant: CGFloat) {
        self.topAnchor.constraint(equalTo: toView.topAnchor, constant: withConstant).isActive = true
        self.leadingAnchor.constraint(equalTo: toView.leadingAnchor, constant: withConstant).isActive = true
        self.trailingAnchor.constraint(equalTo: toView.trailingAnchor, constant: -withConstant).isActive = true
        self.bottomAnchor.constraint(equalTo: toView.bottomAnchor, constant: -withConstant).isActive = true
    }
    
    func addConstraintsOnAllSides(to toView: UIView, withConstantForTop: CGFloat, leadint: CGFloat, trailing: CGFloat, bottom: CGFloat) {
        self.topAnchor.constraint(equalTo: toView.topAnchor, constant: withConstantForTop).isActive = true
        self.leadingAnchor.constraint(equalTo: toView.leadingAnchor, constant: leadint).isActive = true
        self.trailingAnchor.constraint(equalTo: toView.trailingAnchor, constant: trailing).isActive = true
        self.bottomAnchor.constraint(equalTo: toView.bottomAnchor, constant: bottom).isActive = true
    }
    
}

//
//  UIDevice+vibrate.swift
//  Timetable
//
//  Created by art-off on 19.05.2020.
//  Copyright © 2020 art-off. All rights reserved.
//

import UIKit

extension UIDevice {
    
    static func vibrate() {
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred()
    }
    
}

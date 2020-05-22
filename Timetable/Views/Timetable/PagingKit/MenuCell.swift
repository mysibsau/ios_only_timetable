//
//  MenuCell.swift
//  Timetable
//
//  Created by art-off on 03.05.2020.
//  Copyright © 2020 art-off. All rights reserved.
//

import UIKit
import PagingKit

class MenuCell: PagingMenuViewCell {
    
    @IBOutlet weak var weekLabel: UILabel!
    @IBOutlet weak var dataLabel: UILabel!
    
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                weekLabel.textColor = .systemBlue
                dataLabel.textColor = .systemBlue
            } else {
                weekLabel.textColor = Colors.label
                dataLabel.textColor = Colors.label
            }
        }
    }
    
}

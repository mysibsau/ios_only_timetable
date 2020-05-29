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
    
    @IBOutlet weak var dateLabel: UILabel!
    //@IBOutlet weak var weekday: UILabel!
    @IBOutlet weak var weekdayLabel: UILabel!
    
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                weekdayLabel.textColor = .systemBlue
                dateLabel.textColor = .systemBlue
            } else {
                weekdayLabel.textColor = Colors.label
                dateLabel.textColor = Colors.label
            }
        }
    }
    
}

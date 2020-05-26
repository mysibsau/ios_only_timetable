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
    @IBOutlet weak var dayLabel: UILabel!
    
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                dayLabel.textColor = .systemBlue
                dateLabel.textColor = .systemBlue
            } else {
                dayLabel.textColor = Colors.label
                dateLabel.textColor = Colors.label
            }
        }
    }
    
}

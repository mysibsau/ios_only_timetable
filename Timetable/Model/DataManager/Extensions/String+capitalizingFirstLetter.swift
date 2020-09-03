//
//  String+capitalizingFirstLetter.swift
//  Timetable
//
//  Created by art-off on 03.09.2020.
//  Copyright © 2020 art-off. All rights reserved.
//

import Foundation

extension String {
    
    func capitalizinFirstLetter() -> String {
        return prefix(1).uppercased() + lowercased().dropFirst()
    }
    
}

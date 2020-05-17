//
//  ShowingTimetableProtocol.swift
//  Timetable
//
//  Created by art-off on 17.05.2020.
//  Copyright © 2020 art-off. All rights reserved.
//

import Foundation

protocol DetailViewDelegate {
    func showTimetable(withId id: Int)
    func addToFavorite(objectWithId id: Int)
    func removeFromFavorite(objectWithId id: Int)
}

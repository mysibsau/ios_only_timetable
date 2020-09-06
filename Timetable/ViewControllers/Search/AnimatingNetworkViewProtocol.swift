//
//  AnimatingNetworkViewProtocol.swift
//  Timetable
//
//  Created by art-off on 09.06.2020.
//  Copyright © 2020 art-off. All rights reserved.
//

import Foundation

protocol AnimatingNetworkViewProtocol {
    
    func startActivityIndicator()
    func stopActivityIndicator()
    func showAlertForNetwork()
    
    func popViewController()
    
}

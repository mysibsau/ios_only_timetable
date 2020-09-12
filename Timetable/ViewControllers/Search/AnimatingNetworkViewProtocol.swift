//
//  AnimatingNetworkViewProtocol.swift
//  Timetable
//
//  Created by art-off on 09.06.2020.
//  Copyright © 2020 art-off. All rights reserved.
//

import UIKit

protocol AnimatingNetworkViewProtocol {
    
    // MARK: - Нужно реализовать
    func animatingSuperViewForDisplay() -> UIView
    func animatingViewForDisableUserInteraction() -> UIView
    
    func animatingActivityIndicatorView() -> ActivityIndicatorView
    func animatingAlertView() -> AlertView
    
    func popViewController()
    
    // MARK: - Реализованные
    func startActivityIndicator()
    func stopActivityIndicator()
    func showAlert(withText alertText: String)
    func showAlertForNetwork()
    
}


extension AnimatingNetworkViewProtocol {
    
    // MARK: Activity Indicator
    func startActivityIndicator() {
        if !animatingSuperViewForDisplay().subviews.contains(animatingActivityIndicatorView()) {
            animatingSuperViewForDisplay().addSubview(animatingActivityIndicatorView())
            animatingActivityIndicatorView().translatesAutoresizingMaskIntoConstraints = false
            animatingActivityIndicatorView().addConstraintsOnAllSides(to: animatingSuperViewForDisplay().safeAreaLayoutGuide, withConstant: 0)
        }
        animatingActivityIndicatorView().startAnimating()
        //tableView.isScrollEnabled = false
        //tableView.isUserInteractionEnabled = false
        animatingViewForDisableUserInteraction().isUserInteractionEnabled = false
    }
    
    func stopActivityIndicator() {
        animatingActivityIndicatorView().stopAnimating()
        animatingViewForDisableUserInteraction().isUserInteractionEnabled = true
    }
    
    // MARK: Alert View
    func showAlert(withText alertText: String) {
        if !animatingSuperViewForDisplay().subviews.contains(animatingAlertView()) {
            animatingSuperViewForDisplay().addSubview(animatingAlertView())
            
            animatingAlertView().translatesAutoresizingMaskIntoConstraints = false
            animatingAlertView().centerYAnchor.constraint(equalTo: animatingSuperViewForDisplay().safeAreaLayoutGuide.centerYAnchor).isActive = true
            animatingAlertView().centerXAnchor.constraint(equalTo: animatingSuperViewForDisplay().safeAreaLayoutGuide.centerXAnchor).isActive = true
        }
        
        animatingAlertView().alertLabel.text = alertText
        animatingAlertView().hideWithAnimation()
    }
    
    func showAlertForNetwork() {
        showAlert(withText: "Проблемы с интернетом")
    }
    
}

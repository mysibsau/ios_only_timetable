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
        let _animatingSuperViewForDisplay = animatingSuperViewForDisplay()
        let _animatingActivityIndicatioView = animatingActivityIndicatorView()
        let _animatingViewForDisableUserInteraction = animatingViewForDisableUserInteraction()
        
        if !_animatingSuperViewForDisplay.subviews.contains(_animatingActivityIndicatioView) {
            _animatingSuperViewForDisplay.addSubview(_animatingActivityIndicatioView)
            _animatingActivityIndicatioView.translatesAutoresizingMaskIntoConstraints = false
            _animatingActivityIndicatioView.addConstraintsOnAllSides(to: _animatingSuperViewForDisplay.safeAreaLayoutGuide, withConstant: 0)
        }
        _animatingActivityIndicatioView.startAnimating()
        _animatingViewForDisableUserInteraction.isUserInteractionEnabled = false
    }
    
    func stopActivityIndicator() {
        let _animatingActivityIndicatorView = animatingActivityIndicatorView()
        let _animatingViewForDisableUserInteraction = animatingViewForDisableUserInteraction()
        
        _animatingActivityIndicatorView.stopAnimating()
        _animatingViewForDisableUserInteraction.isUserInteractionEnabled = true
    }
    
    // MARK: Alert View
    func showAlert(withText alertText: String) {
        let _animatingSuperViewForDisplay = animatingSuperViewForDisplay()
        let _animatingAlertView = animatingAlertView()
        
        if !_animatingSuperViewForDisplay.subviews.contains(_animatingAlertView) {
            _animatingSuperViewForDisplay.addSubview(_animatingAlertView)
            
            _animatingAlertView.translatesAutoresizingMaskIntoConstraints = false
            _animatingAlertView.centerYAnchor.constraint(equalTo: _animatingSuperViewForDisplay.safeAreaLayoutGuide.centerYAnchor).isActive = true
            _animatingAlertView.centerXAnchor.constraint(equalTo: _animatingSuperViewForDisplay.safeAreaLayoutGuide.centerXAnchor).isActive = true
        }
        
        _animatingAlertView.alertLabel.text = alertText
        _animatingAlertView.hideWithAnimation()
    }
    
    func showAlertForNetwork() {
        showAlert(withText: "Проблемы с интернетом")
    }
    
}

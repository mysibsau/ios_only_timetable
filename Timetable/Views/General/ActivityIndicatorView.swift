//
//  ActivityIndicatorView.swift
//  Timetable
//
//  Created by art-off on 09.06.2020.
//  Copyright © 2020 art-off. All rights reserved.
//

import UIKit

class ActivityIndicatorView: UIView {
    
    let loadingView = UIView()
    let activityIndicator = UIActivityIndicatorView(style: .whiteLarge)
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    
    // MARK: - Setup Views
    private func setupView() {
        backgroundColor = .clear
        
        loadingView.backgroundColor = UIColor(red: 0.25, green: 0.25, blue: 0.25, alpha: 0.7)
        loadingView.layer.cornerRadius = 15
        
        addSubview(loadingView)
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        loadingView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        loadingView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        loadingView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        loadingView.widthAnchor.constraint(equalToConstant: 80).isActive = true
        
        loadingView.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.centerXAnchor.constraint(equalTo: loadingView.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: loadingView.centerYAnchor).isActive = true
        activityIndicator.heightAnchor.constraint(equalToConstant: 40).isActive = true
        activityIndicator.widthAnchor.constraint(equalToConstant: 40).isActive = true
        
        self.isHidden = true
    }
    
    // MARK: - Animating
    func startAnimating() {
        self.isHidden = false
        activityIndicator.startAnimating()
    }
    
    func stopAnimating() {
        self.isHidden = true
        activityIndicator.stopAnimating()
    }
    
}

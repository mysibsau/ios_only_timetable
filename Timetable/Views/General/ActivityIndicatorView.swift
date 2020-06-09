//
//  IctivityIndicatorView.swift
//  Timetable
//
//  Created by art-off on 09.06.2020.
//  Copyright © 2020 art-off. All rights reserved.
//

import UIKit

class IctivityIndicatorView: UIView {
    
    let container = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("required init(coder:) does not exist")
    }
    
    
    private func commonInit() {
        addSubview(container)
        
        container.frame = bounds
        container.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        container.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0)
        
    }
    
    
    func showActivityIndicatory(uiView: UIView) {
        let container: UIView = UIView()
        container.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0) // UIColor.fromHex(0xffffff, alpha: 0.3)
        
        uiView.addSubview(container)
        container.translatesAutoresizingMaskIntoConstraints = false
        container.addConstraintsOnAllSides(to: uiView.safeAreaLayoutGuide, withConstantForTop: 0, leadint: 0, trailing: 0, bottom: 0)
        
        let loadingView: UIView = UIView()
        loadingView.backgroundColor = UIColor(red: 0.25, green: 0.25, blue: 0.25, alpha: 0.7) // UIColorFromHex(0x444444, alpha: 0.7)
        loadingView.clipsToBounds = true
        loadingView.layer.cornerRadius = 10
        
        container.addSubview(loadingView)
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        loadingView.centerYAnchor.constraint(equalTo: container.centerYAnchor).isActive = true
        loadingView.centerXAnchor.constraint(equalTo: container.centerXAnchor).isActive = true
        loadingView.widthAnchor.constraint(equalToConstant: 80).isActive = true
        loadingView.heightAnchor.constraint(equalToConstant: 80).isActive = true

        let activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
        activityIndicator.style = .whiteLarge
        
        loadingView.addSubview(activityIndicator)
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.centerYAnchor.constraint(equalTo: loadingView.centerYAnchor).isActive = true
        activityIndicator.centerXAnchor.constraint(equalTo: loadingView.centerXAnchor).isActive = true
        activityIndicator.widthAnchor.constraint(equalToConstant: 40).isActive = true
        activityIndicator.heightAnchor.constraint(equalToConstant: 40).isActive = true
        

        //activityIndicator.startAnimating()
        //tableView.isScrollEnabled = false
    }
    
}

//
//  WrapperViewWithLabel.swift
//  Timetable
//
//  Created by art-off on 22.05.2020.
//  Copyright © 2020 art-off. All rights reserved.
//

import UIKit

class WrapperViewWithLabel: UIView {
    
    let label = UILabel()
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    convenience init(text: String) {
        self.init()
        label.text = text
    }
    
    // MARK: - Setup Views
    private func setupView() {
        backgroundColor = Colors.backgroungColor
        
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        
        addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        // центрируем label
        label.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        label.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        label.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20).isActive = true
    }
    
}

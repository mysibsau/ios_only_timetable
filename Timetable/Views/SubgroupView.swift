//
//  Subgroup.swift
//  Timetable
//
//  Created by art-off on 08.04.2020.
//  Copyright © 2020 art-off. All rights reserved.
//

import UIKit


class SubgroupView: UIView {
    
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var subject: UILabel!
    @IBOutlet weak var type: UILabel!
    @IBOutlet weak var professor: UILabel!
    @IBOutlet weak var place: UILabel!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadXib()
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadXib()
        setupViews()
    }
    
    private func loadXib() {
        // загружаем xib из какого-то Boundle (можно чекнуть документацию)
        Bundle.main.loadNibNamed("SubgroupView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
    
    private func setupViews() {
        contentView.backgroundColor = Colors.contentColor
        setupLabels()
    }
    
    private func setupLabels() {
        for label in [subject, type, professor, place] {
            label?.textAlignment = .left
            label?.numberOfLines = 0
            label?.lineBreakMode = .byWordWrapping
        }
        place.textAlignment = .right
        place.textColor = .gray
        
        subject.textColor = Colors.sibsuBlue
        type.textColor = Colors.sibsuGreen
        professor.textColor = .systemGray
    }
    
}


extension SubgroupView {
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        
        // тут написать открытие преподавателя или что-то подобное
    }
    
}

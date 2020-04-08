//
//  LessonView.swift
//  Timetable
//
//  Created by art-off on 07.04.2020.
//  Copyright © 2020 art-off. All rights reserved.
//

// LessonView.xib: сначала лежит UIView, на которую
// с констрейтами 8 по всем сторонам я кладу UIView,
// на которой уже и закрепляю все UILabel


import UIKit

class LessonView: UIView {
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var lessonView: UIView!
    
    @IBOutlet weak var subject: UILabel!
    @IBOutlet weak var type: UILabel!
    @IBOutlet weak var professor: UILabel!
    @IBOutlet weak var place: UILabel!
    @IBOutlet weak var time: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadXib()
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadXib()
        setupUI()
    }
    
    
    private func setupUI() {
        setupLessonView()
        setupLabels()
        
        contentView.backgroundColor = Colors.backgroungColor
        lessonView.layer.cornerRadius = 15
    }
    
    private func loadXib() {
        // загружаем xib из какого-то Boundle (можно чекнуть документацию)
        Bundle.main.loadNibNamed("LessonView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
    
    private func setupLessonView() {
        
        //lessonView.layer.shadowColor = Colors.shadowColor.cgColor
    }
    
    private func setupLabels() {
        for label in [subject, type, professor, place, time] {
            label?.textAlignment = .left
            label?.numberOfLines = 0
            label?.lineBreakMode = .byWordWrapping
        }
        time.textAlignment = .right
        
        subject.textColor = Colors.sibsuBlue
        type.textColor = Colors.sibsuGreen
        professor.textColor = .systemGray
    }
    
}


extension LessonView {
    // для отрисовки интерфейса при смене темы
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        /// Border color is not automatically catched by trait collection changes. Therefore, update it here.
        lessonView.layer.shadowColor = Colors.shadowColor.cgColor
    }
}

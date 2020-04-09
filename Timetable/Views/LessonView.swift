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
    
    let contentView = UIView()
    let wrapper = UIView()
    let subgroupStack = UIStackView()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    
    private func setupViews() {
        
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        setupStackView()
        
        contentView.backgroundColor = Colors.backgroungColor
        wrapper.backgroundColor = Colors.white
        wrapper.layer.cornerRadius = 15
    }
    
    private func setupStackView() {
        // настраиваем свойства StackView
        subgroupStack.backgroundColor = .clear
        subgroupStack.axis = .vertical
        subgroupStack.distribution = .equalSpacing
        subgroupStack.spacing = 1 // было 2
        
        contentView.addSubview(wrapper)
        // расставляем констрейнты для подВью к контентВью
        wrapper.translatesAutoresizingMaskIntoConstraints = false
        wrapper.addConstraintsOnAllSides(to: contentView, withConstantForTop: 8, leadint: 8, trailing: -8, bottom: -4)
        
        wrapper.addSubview(subgroupStack)
        // расставляем констрейнты для стекВью с отступами в 8 к подВью
        subgroupStack.translatesAutoresizingMaskIntoConstraints = false
        subgroupStack.addConstraintsOnAllSides(to: wrapper, withConstant: 8)
    }
}

extension LessonView {
    
    public func addSubject() {
        
    }
    
    public func addSubgroup(subject: String, type: String, proffesor: String, place: String) {
        // добавляем разделительную линию, если в стеке уже есть подгруппы
        if subgroupStack.arrangedSubviews.count > 1 {
            // добавление дополнительного отступа перед линией
            let spaceBeforeLine = UIView()
            spaceBeforeLine.backgroundColor = .clear
            subgroupStack.addArrangedSubview(spaceBeforeLine)
            spaceBeforeLine.heightAnchor.constraint(equalToConstant: 2).isActive = true
            spaceBeforeLine.widthAnchor.constraint(equalTo: subgroupStack.widthAnchor).isActive = true
            
            // добавление разделительной черты
            let separator = UIView()
            let line = UIView()
            separator.backgroundColor = .clear
            line.backgroundColor = Colors.backgroungColor

            separator.addSubview(line)
            line.translatesAutoresizingMaskIntoConstraints = false
            line.topAnchor.constraint(equalTo: separator.topAnchor).isActive = true
            line.bottomAnchor.constraint(equalTo: separator.bottomAnchor).isActive = true
            line.widthAnchor.constraint(equalTo: separator.widthAnchor, multiplier: 7.0 / 10.0).isActive = true
            line.centerXAnchor.constraint(equalTo: separator.centerXAnchor).isActive = true

            subgroupStack.addArrangedSubview(separator)
            separator.heightAnchor.constraint(equalToConstant: 3).isActive = true
            separator.widthAnchor.constraint(equalTo: subgroupStack.widthAnchor).isActive = true
            
            // добавление дополнительного отступа после лини
            let spaceAfterLine = UIView()
            spaceAfterLine.backgroundColor = .clear
            subgroupStack.addArrangedSubview(spaceAfterLine)
            spaceAfterLine.heightAnchor.constraint(equalToConstant: 1).isActive = true
            spaceAfterLine.widthAnchor.constraint(equalTo: subgroupStack.widthAnchor).isActive = true
        }
        
        let subgroupView = SubgroupView()
        subgroupView.subject.text = subject
        subgroupView.type.text = type
        subgroupView.professor.text = proffesor
        subgroupView.place.text = place
        
        subgroupStack.addArrangedSubview(subgroupView)
        subgroupView.widthAnchor.constraint(equalTo: subgroupStack.widthAnchor).isActive = true
    }
    
    public func addTime(time: String) {
        let attribetedTime = NSMutableAttributedString(string: time)
        attribetedTime.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: 20), range: NSRange(location: 0, length: 5))
        
        let timeLabel = UILabel()
        timeLabel.attributedText = attribetedTime
        timeLabel.textAlignment = .left
        subgroupStack.addArrangedSubview(timeLabel)
        timeLabel.widthAnchor.constraint(equalTo: subgroupStack.widthAnchor).isActive = true
    }
    
}


extension LessonView {
    // для отрисовки интерфейса при смене темы
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
    }
}

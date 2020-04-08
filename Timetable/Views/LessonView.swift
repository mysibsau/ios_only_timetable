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
    let wrapper = UIView()
    let subgroupStack = UIStackView()
    
    
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
        setupStackView()
        
        contentView.backgroundColor = Colors.backgroungColor
        wrapper.backgroundColor = Colors.white
        wrapper.layer.cornerRadius = 15
    }
    
    private func loadXib() {
        // загружаем xib из какого-то Boundle (можно чекнуть документацию)
        Bundle.main.loadNibNamed("LessonView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
    
    private func setupStackView() {
        // настраиваем свойства StackView
        subgroupStack.backgroundColor = .clear
        subgroupStack.axis = .vertical
        subgroupStack.distribution = .equalSpacing
        subgroupStack.spacing = 2
        
        contentView.addSubview(wrapper)
        // расставляем констрейнты для подВью с отступов в 8 к контентВью
        wrapper.translatesAutoresizingMaskIntoConstraints = false
        wrapper.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8).isActive = true
        wrapper.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4).isActive = true
        wrapper.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8).isActive = true
        wrapper.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8).isActive = true
        
        wrapper.addSubview(subgroupStack)
        // расставляем констрейнты для стекВью с отступами в 8 к подВью
        subgroupStack.translatesAutoresizingMaskIntoConstraints = false
        subgroupStack.topAnchor.constraint(equalTo: wrapper.topAnchor, constant: 8).isActive = true
        subgroupStack.bottomAnchor.constraint(equalTo: wrapper.bottomAnchor, constant: -8).isActive = true
        subgroupStack.leadingAnchor.constraint(equalTo: wrapper.leadingAnchor, constant: 8).isActive = true
        subgroupStack.trailingAnchor.constraint(equalTo: wrapper.trailingAnchor, constant: -8).isActive = true
    }
}

extension LessonView {
    
    public func addSubgroup(subject: String, type: String, proffesor: String, place: String) {
        // добавляем разделительную линию, если в стеке уже есть подгруппы
        if subgroupStack.arrangedSubviews.count > 1 {
            // добавление дополнительного отступа перед линией
            let spaceBeforeLine = UIView()
            spaceBeforeLine.backgroundColor = .clear
            subgroupStack.addArrangedSubview(spaceBeforeLine)
            spaceBeforeLine.heightAnchor.constraint(equalToConstant: 2).isActive = true
            spaceBeforeLine.widthAnchor.constraint(equalTo: subgroupStack.widthAnchor).isActive = true
            
            let separator = UIView()
            let line = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 20))
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

//
//  StackViewCornerRadius.swift
//  Timetable
//
//  Created by art-off on 07.04.2020.
//  Copyright © 2020 art-off. All rights reserved.
//

// StackViewCornerRadius.xib: сначала лежит UIView, на которую
// с констрейтами 8 по всем сторонам я кладу UIView,
// на которой уже и закрепляю все UILabel


import UIKit

class StackViewCornerRadius: UIView {
    
    private let contentView = UIView()
    private let wrapperView = UIView()
    private let subgroupStackView = UIStackView()
    
    var spacing: CGFloat = 2 {
        didSet { subgroupStackView.spacing = self.spacing }
    }
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    // MARK: - Setup Views
    private func setupViews() {
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        setupStackView()
        
        subgroupStackView.backgroundColor = .clear
        contentView.backgroundColor = Colors.backgroungColor
        wrapperView.backgroundColor = Colors.contentColor
        wrapperView.layer.cornerRadius = 15
    }
    
    private func setupStackView() {
        // настраиваем свойства StackView
        subgroupStackView.axis = .vertical
        subgroupStackView.distribution = .equalSpacing
        subgroupStackView.spacing = spacing // было 2
        
        contentView.addSubview(wrapperView)
        // расставляем констрейнты для подВью к контентВью
        wrapperView.translatesAutoresizingMaskIntoConstraints = false
        wrapperView.addConstraintsOnAllSides(to: contentView, withConstantForTop: 8, leadint: 8, trailing: -8, bottom: -4)
        
        wrapperView.addSubview(subgroupStackView)
        // расставляем констрейнты для стекВью с отступами в 8 к подВью
        subgroupStackView.translatesAutoresizingMaskIntoConstraints = false
        subgroupStackView.addConstraintsOnAllSides(to: wrapperView, withConstant: 8)
    }
}


// MARK: - Все для установки нового занятия на это вью (пока только для групп)
extension StackViewCornerRadius {
    
    convenience init(lesson: GroupLesson) {
        self.init()
        self.set(lesson: lesson)
    }
    
    convenience init(lesson: ProfessorLesson) {
        self.init()
        self.set(lesson: lesson)
    }
    
    convenience init(lesson: PlaceLesson) {
        self.init()
        self.set(lesson: lesson)
    }
    
    // MARK: Установка нового занятия для группы
    private func set(lesson: GroupLesson) {
        // если тут уже было занятие, то удаляем его
        subgroupStackView.removeAllArrangedSubviews()
        
        addTime(time: lesson.time)
        
        var numberSubgroup = 1
        for subgroup in lesson.subgroups {
            // добавляем номер подргуппы, если это необходимо
            if subgroup.number != 0 {
                addNumberSubgroup(with: subgroup.number)
            }
            
            // перечисляем всех преподавателей через ;\n
            let professors = subgroup.professors.reduce("", { $0 + ($0 != "" ? ";\n": "") + $1 })
            addSubgroup(subject: subgroup.subject, type: subgroup.type, proffesor: professors, place: subgroup.place)
            
            // добавляем разделительную если это необходимо
            if lesson.subgroups.count > 1 && lesson.subgroups.count != numberSubgroup {
                addSeparatorLine()
            }
            numberSubgroup += 1
        }
    }
    
    // MARK: Установка нового занятия для проподавателей
    private func set(lesson: ProfessorLesson) {
        // если тут уже было занятие, то удаляем его
        subgroupStackView.removeAllArrangedSubviews()
        
        addTime(time: lesson.time)
        
        var numberSubgroup = 1
        for subgroup in lesson.subgroups {
            // добавляем номер подргуппы, если это необходимо
            if subgroup.number != 0 {
                addNumberSubgroup(with: subgroup.number)
            }
            
            // перечисляем все группы через ;\n
            let professors = subgroup.groups.reduce("", { $0 + ($0 != "" ? ";\n": "") + $1 })
            addSubgroup(subject: subgroup.subject, type: subgroup.type, proffesor: professors, place: subgroup.place)
            
            // добавляем разделительную если это необходимо
            if lesson.subgroups.count > 1 && lesson.subgroups.count != numberSubgroup {
                addSeparatorLine()
            }
            numberSubgroup += 1
        }
    }
    
    // MARK: Установка нового занятия для кабинетов
    private func set(lesson: PlaceLesson) {
        // если тут уже было занятие, то удаляем его
        subgroupStackView.removeAllArrangedSubviews()
        
        addTime(time: lesson.time)
        
        var numberSubgroup = 1
        for subgroup in lesson.subgroups {
            // добавляем номер подргуппы, если это необходимо
            if subgroup.number != 0 {
                addNumberSubgroup(with: subgroup.number)
            }
            
            // перечисляем все группы через ;\n
            let professors = subgroup.groups.reduce("", { $0 + ($0 != "" ? ";\n": "") + $1 })
            // перечисляем все группы через ;\n
            let groups = subgroup.groups.reduce("", { $0 + ($0 != "" ? ";\n": "") + $1 })
            addSubgroup(subject: subgroup.subject, type: subgroup.type, professors: professors, groups: groups)
            
            // добавляем разделительную если это необходимо
            if lesson.subgroups.count > 1 && lesson.subgroups.count != numberSubgroup {
                addSeparatorLine()
            }
            numberSubgroup += 1
        }
    }
    
    // MARK: Добавление времени к занятию
    private func addTime(time: String) {
        let attribetedTime = NSMutableAttributedString(string: time)
        attribetedTime.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: 18), range: NSRange(location: 0, length: 5))
        
        let timeLabel = UILabel()
        timeLabel.font = UIFont.systemFont(ofSize: 16)
        timeLabel.attributedText = attribetedTime
        timeLabel.textAlignment = .left
        subgroupStackView.addArrangedSubview(timeLabel)
        timeLabel.widthAnchor.constraint(equalTo: subgroupStackView.widthAnchor).isActive = true
    }
    
    // MARK: Добавление номера группы (для подргупп)
    private func addNumberSubgroup(with number: Int) {
        let numberSubgroundLabel = UILabel()
        numberSubgroundLabel.font = UIFont.systemFont(ofSize: 10)
        numberSubgroundLabel.textColor = .gray
        numberSubgroundLabel.text = "[\(number) подгруппа]"
        numberSubgroundLabel.textAlignment = .left
        subgroupStackView.addArrangedSubview(numberSubgroundLabel)
        numberSubgroundLabel.widthAnchor.constraint(equalTo: subgroupStackView.widthAnchor).isActive = true
    }
    
    // MARK: Добавлени разделительной линии (для подгрупп)
    func addSeparatorLine() {
        // добавление дополнительного отступа перед линией
        let spaceBeforeLine = UIView()
        spaceBeforeLine.backgroundColor = .clear
        subgroupStackView.addArrangedSubview(spaceBeforeLine)
        spaceBeforeLine.heightAnchor.constraint(equalToConstant: 2).isActive = true
        spaceBeforeLine.widthAnchor.constraint(equalTo: subgroupStackView.widthAnchor).isActive = true
        
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

        subgroupStackView.addArrangedSubview(separator)
        separator.heightAnchor.constraint(equalToConstant: 3).isActive = true
        separator.widthAnchor.constraint(equalTo: subgroupStackView.widthAnchor).isActive = true
        
        // добавление дополнительного отступа после лини
        let spaceAfterLine = UIView()
        spaceAfterLine.backgroundColor = .clear
        subgroupStackView.addArrangedSubview(spaceAfterLine)
        spaceAfterLine.heightAnchor.constraint(equalToConstant: 1).isActive = true
        spaceAfterLine.widthAnchor.constraint(equalTo: subgroupStackView.widthAnchor).isActive = true
    }
    
    // MARK: Добавление подргуппы (испльзутеся и тогда, когда подргуппа одна) (для ГРУПП)
    private func addSubgroup(subject: String, type: String, proffesor: String, place: String) {
        let subgroupView = GroupSubgroupView()
        subgroupView.subject.text = subject
        subgroupView.type.text = type
        subgroupView.professor.text = proffesor
        subgroupView.place.text = place
        
        subgroupStackView.addArrangedSubview(subgroupView)
        // возможно эта строчка и не нужна
        //subgroupView.widthAnchor.constraint(equalTo: subgroupStackView.widthAnchor).isActive = true
    }
    
    // MARK: Добавление подргуппы (для ПРЕПОДАВАТЕЛЕЙ)
    private func addSubgroup(subject: String, type: String, groups: String, place: String) {
        let subgroupView = ProfessorSubgroupView()
        subgroupView.subject.text = subject
        subgroupView.type.text = type
        subgroupView.group.text = groups
        subgroupView.place.text = place
        
        subgroupStackView.addArrangedSubview(subgroupView)
        // возможно эта строчка и не нужна
        //subgroupView.widthAnchor.constraint(equalTo: subgroupStackView.widthAnchor).isActive = true
    }
    
    // MARK: Добавление одргуппы (для КАБИНЕТОВ)
    private func addSubgroup(subject: String, type: String, professors: String, groups: String) {
        let subgroupView = PlaceSubgroupView()
        subgroupView.subject.text = subject
        subgroupView.type.text = type
        subgroupView.professor.text = professors
        subgroupView.group.text = groups
        
        subgroupStackView.addArrangedSubview(subgroupView)
        // возможно эта строчка и не нужна
        //subgroupView.widthAnchor.constraint(equalTo: subgroupStackView.widthAnchor).isActive = true
    }
    
}

// MARK: ВОЗМОЖНО СТОИТ УБРАТЬ ЭТО (Если не буду юзать в итоге)
extension StackViewCornerRadius {
    // для отрисовки интерфейса при смене темы
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
    }
}

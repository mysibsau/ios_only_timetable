//
//  ViewController.swift
//  Timetable
//
//  Created by art-off on 07.04.2020.
//  Copyright © 2020 art-off. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let scrollView = UIScrollView()
    let stackView = UIStackView()
    
    var lessons = [LessonView]()
    
    
    override func loadView() {
        super.loadView()
        
        setupScrollView()
        setupStackView()

        view.backgroundColor = Colors.backgroungColor
    }
    
    override func viewDidLoad() {
        
        let lesson1 = LessonView()
        lesson1.subject.text = "Ахритектура вычислительных систем"
        lesson1.type.text = "(Лабораторная работа)"
        lesson1.professor.text = "Богданов Константив Васильевич(?)"
        lesson1.place.text = "Л - 313"
        lesson1.time.text = "9:40 - 11:10"
        
        let lesson2 = LessonView()
        lesson2.subject.text = "Объектно-ориентированное программирование"
        lesson2.type.text = "(лекция)"
        lesson2.professor.text = "Добрая бабуля с:"
        lesson2.place.text = "Л - 319"
        lesson2.time.text = "11:30 - 13:00"
        
        let lesson3 = LessonView()
        lesson3.subject.text = "Ахритектура вычислительных систем"
        lesson3.type.text = "(лекция)"
        lesson3.professor.text = "Богданов Константив Васильевич(?)"
        lesson3.place.text = "Л - 319"
        lesson3.time.text = "13:30 - 15:00"
        
        let lesson4 = LessonView()
        lesson4.subject.text = "Вычислительная математика"
        lesson4.type.text = "(практика)"
        lesson4.professor.text = "Охорзин Дед Почти"
        lesson4.place.text = "Н - 304"
        lesson4.time.text = "15:10 - 16:40"
        
        let lesson5 = LessonView()
        lesson5.subject.text = "Вычислительная математика"
        lesson5.type.text = "(практика)"
        lesson5.professor.text = "Охорзин Дед Почти"
        lesson5.place.text = "Н - 304"
        lesson5.time.text = "15:10 - 16:40"
        
        stackView.addArrangedSubview(lesson1)
        lesson1.widthAnchor.constraint(equalTo: stackView.widthAnchor).isActive = true
        stackView.addArrangedSubview(lesson2)
        lesson2.widthAnchor.constraint(equalTo: stackView.widthAnchor).isActive = true
        stackView.addArrangedSubview(lesson3)
        lesson3.widthAnchor.constraint(equalTo: stackView.widthAnchor).isActive = true
        stackView.addArrangedSubview(lesson4)
        lesson4.widthAnchor.constraint(equalTo: stackView.widthAnchor).isActive = true
        stackView.addArrangedSubview(lesson5)
        lesson5.widthAnchor.constraint(equalTo: stackView.widthAnchor).isActive = true
        
    }
    
    private func setupScrollView() {
        view.addSubview(scrollView)
        // убираем полосы прокрутки
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        // расставляем констрейнты с отступом в 8 от view
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
    }
    
    private func setupStackView() {
        // настраиваем свойства StackView
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 0
        
        scrollView.addSubview(stackView)
        
        // расставляем констраинты на полное прилигание с scrollView
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
    }

}


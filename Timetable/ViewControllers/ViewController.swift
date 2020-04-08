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
        lesson1.addTime(time: "9:40 - 11:10")
        lesson1.addSubgroup(subject: "Ахритектура вычислительных систем", type: "(Лабораторная работа)", proffesor: "Богданов Константив Васильевич(?)", place: "Л 313")
        
        let lesson2 = LessonView()
        lesson2.addTime(time: "13:30 - 15:00")
        lesson2.addSubgroup(subject: "Объектно-ориентированное программирование", type: "(лекция)", proffesor: "Добрая бабуля с:", place: "Л 319")
        lesson2.addSubgroup(subject: "Ахритектура вычислительных систем", type: "(лекция)", proffesor: "Богданов Константив Васильевич(?)", place: "Л 319")
        
        let lesson3 = LessonView()
        lesson3.addTime(time: "15:10 - 16:40")
        lesson3.addSubgroup(subject: "Вычислительная математика", type: "(практика)", proffesor: "Охорзин Дед Почти", place: "Н 304")
        
        let lesson4 = LessonView()
        lesson4.addTime(time: "15:10 - 16:40")
        lesson4.addSubgroup(subject: "Вычислительная математика", type: "(практика)", proffesor: "Охорзин Дед Почти", place: "Н 304")
                
        stackView.addArrangedSubview(lesson1)
        lesson1.widthAnchor.constraint(equalTo: stackView.widthAnchor).isActive = true
        stackView.addArrangedSubview(lesson2)
        lesson2.widthAnchor.constraint(equalTo: stackView.widthAnchor).isActive = true
        stackView.addArrangedSubview(lesson3)
        lesson3.widthAnchor.constraint(equalTo: stackView.widthAnchor).isActive = true
        stackView.addArrangedSubview(lesson4)
        lesson4.widthAnchor.constraint(equalTo: stackView.widthAnchor).isActive = true
        
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


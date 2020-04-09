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
        
        
        let lesson1 = Lesson(
            time: "11:30 - 13:00",
            subgroups: [
                Subgroup(subject: "Физическая культура что-то там еще", type: "(практика)", professors: ["Добрая бабуля", "Богданов Константив Васильевич(?)", "Охорзин Дед Почти", "Богданов Константив Васильевич(?)"], place: "СПОРТЗАЛ")
            ]
        )
        let lessonView1 = LessonView()
        lessonView1.set(lesson: lesson1)
        
        let lesson2 = Lesson(
            time: "13:30 - 15:00",
            subgroups: [
                Subgroup(subject: "Объектно-ориентированное программирование", type: "(лекция)", professors: ["Добрая бабуля"], place: "Л 319"),
                Subgroup(subject: "Ахритектура вычислительных систем", type: "(лекция)", professors: ["Богданов Константив Васильевич(?)"], place: "Л 315")
            ]
        )
        let lessonView2 = LessonView()
        lessonView2.set(lesson: lesson2)
        
        let lesson3 = Lesson(
            time: "15:10 - 16:40",
            subgroups: [
                Subgroup(subject: "Вычислительная математика", type: "(практика)", professors: ["Охорзин Дед Почти"], place: "Н 304")
            ]
        )
        let lessonView3 = LessonView()
        lessonView3.set(lesson: lesson3)
        
        let lesson4 = Lesson(
            time: "16:50 - 18:20",
            subgroups: [Subgroup(subject: "Вычислительная математика", type: "(практика)", professors: ["Охорзин Дед Почти"], place: "Н 304")]
        )
        let lessonView4 = LessonView()
        lessonView4.set(lesson: lesson4)
                
        stackView.addArrangedSubview(lessonView1)
        lessonView1.widthAnchor.constraint(equalTo: stackView.widthAnchor).isActive = true
        stackView.addArrangedSubview(lessonView2)
        lessonView2.widthAnchor.constraint(equalTo: stackView.widthAnchor).isActive = true
        stackView.addArrangedSubview(lessonView3)
        lessonView3.widthAnchor.constraint(equalTo: stackView.widthAnchor).isActive = true
        stackView.addArrangedSubview(lessonView4)
        lessonView4.widthAnchor.constraint(equalTo: stackView.widthAnchor).isActive = true
        
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


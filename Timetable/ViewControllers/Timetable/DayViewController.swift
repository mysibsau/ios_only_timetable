//
//  DayViewController.swift
//  Timetable
//
//  Created by art-off on 25.05.2020.
//  Copyright © 2020 art-off. All rights reserved.
//

import UIKit

class DayViewController<EntitieDay>: UIViewController {
    
    
    let scrollView = UIScrollView()
    let stackView = UIStackView()
    
    var day: EntitieDay?
    
    // MARK: - Initialization
    convenience init(day: EntitieDay?) {
        self.init()
        self.day = day
    }
    
    // MARK: - Overrides
    override func loadView() {
        super.loadView()
        
        setupScrollView()
        setupStackView()

        view.backgroundColor = Colors.backgroungColor
        navigationItem.title = "Группа"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // если нет занятий в этот день - ставим label с "В этот день нет занятий"
        guard let day = day else {
            let label = UILabel(frame: .zero)
            label.font = UIFont.boldSystemFont(ofSize: 20)
            label.text = "В этот день нет занятий"
            label.numberOfLines = 0
            label.lineBreakMode = .byWordWrapping
            label.textAlignment = .center

            
            view.addSubview(label)
            
            label.translatesAutoresizingMaskIntoConstraints = false
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
            //label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
            
            return
        }
        
        // заполняем день занятиями
        if let groupDay = day as? GroupDay {
            for lesson in groupDay.lessons {
                let lessonView = LessonView(lesson: lesson)
                stackView.addArrangedSubview(lessonView)
                lessonView.widthAnchor.constraint(equalTo: stackView.widthAnchor).isActive = true
            }
        } else if let professorDay = day as? ProfessorDay {
            for lesson in professorDay.lessons {
                let lessonView = LessonView(lesson: lesson)
                stackView.addArrangedSubview(lessonView)
                lessonView.widthAnchor.constraint(equalTo: stackView.widthAnchor).isActive = true
            }
        } else if let placeDay = day as? PlaceDay {
            for lesson in placeDay.lessons {
                let lessonView = LessonView(lesson: lesson)
                stackView.addArrangedSubview(lessonView)
                lessonView.widthAnchor.constraint(equalTo: stackView.widthAnchor).isActive = true
            }
        }
        
    }
    
    // MARK: - Setup any View
    private func setupScrollView() {
        view.addSubview(scrollView)
        // убираем полосы прокрутки
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        // расставляем констрейнты с отступом в 8 от view
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addConstraintsOnAllSides(to: view.safeAreaLayoutGuide, withConstant: 0)
    }
    
    private func setupStackView() {
        // настраиваем свойства StackView
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 0
        
        scrollView.addSubview(stackView)
        // расставляем констраинты на полное прилигание с scrollView
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.addConstraintsOnAllSides(to: scrollView, withConstantForTop: 0, leadint: 0, trailing: 0, bottom: -8)
        stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
    }

}

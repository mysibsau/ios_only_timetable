//
//  ProfessorDayViewController.swift
//  Timetable
//
//  Created by art-off on 24.05.2020.
//  Copyright © 2020 art-off. All rights reserved.
//

//import UIKit
//
//class ProfessorDayViewController: UIViewController {
//
//    let scrollView = UIScrollView()
//    let stackView = UIStackView()
//    
//    var day: ProfessorDay?
//    
//    // MARK: - Initialization
//    convenience init(day: ProfessorDay?) {
//        self.init()
//        self.day = day
//    }
//    
//    // MARK: - Overrides
//    override func loadView() {
//        super.loadView()
//        
//        setupScrollView()
//        setupStackView()
//
//        view.backgroundColor = Colors.backgroungColor
//        navigationItem.title = "Преподаватель"
//    }
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        // если нет занятий в этот день - ставим label с "В этот день нет занятий"
//        guard let day = day else {
//            let label = UILabel(frame: .zero)
//            label.font = UIFont.boldSystemFont(ofSize: 20)
//            label.text = "В этот день нет занятий"
//            label.numberOfLines = 0
//            label.lineBreakMode = .byWordWrapping
//            label.textAlignment = .center
//
//            
//            view.addSubview(label)
//            
//            label.translatesAutoresizingMaskIntoConstraints = false
//            label.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
//            //label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
//            label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
//            
//            return
//        }
//        
//        // заполняем день занятиями
//        for lesson in day.lessons {
//            let lessonView = StackViewCornerRadius(lesson: lesson)
//            stackView.addArrangedSubview(lessonView)
//            lessonView.widthAnchor.constraint(equalTo: stackView.widthAnchor).isActive = true
//        }
//        
//    }
//    
//    // MARK: - Setup any View
//    private func setupScrollView() {
//        view.addSubview(scrollView)
//        // убираем полосы прокрутки
//        scrollView.showsVerticalScrollIndicator = false
//        scrollView.showsHorizontalScrollIndicator = false
//        // расставляем констрейнты с отступом в 8 от view
//        scrollView.translatesAutoresizingMaskIntoConstraints = false
//        scrollView.addConstraintsOnAllSides(to: view.safeAreaLayoutGuide, withConstant: 0)
//    }
//    
//    private func setupStackView() {
//        // настраиваем свойства StackView
//        stackView.axis = .vertical
//        stackView.distribution = .equalSpacing
//        stackView.spacing = 0
//        
//        scrollView.addSubview(stackView)
//        // расставляем констраинты на полное прилигание с scrollView
//        stackView.translatesAutoresizingMaskIntoConstraints = false
//        stackView.addConstraintsOnAllSides(to: scrollView, withConstantForTop: 0, leadint: 0, trailing: 0, bottom: -8)
//        stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
//    }
//
//}

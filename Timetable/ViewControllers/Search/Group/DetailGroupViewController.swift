//
//  DetailGroupViewController.swift
//  Timetable
//
//  Created by art-off on 13.05.2020.
//  Copyright © 2020 art-off. All rights reserved.
//

import UIKit

class DetailGroupViewController: UIViewController {

    var group: RGroup?
    
    let scrollView = UIScrollView()
    let stackView = UIStackView()

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = group?.name

        view.backgroundColor = Colors.backgroungColor
        
        setupScrollView()
        setupStackView()
        
        let block1 = StackViewCornerRadius()
        block1.addSeparatorLine()
        block1.addLabel(text: group?.email ?? "Нет почты группы")
        block1.addSeparatorLine()
        stackView.addArrangedSubview(block1)
        block1.widthAnchor.constraint(equalTo: stackView.widthAnchor).isActive = true
        
        let block2 = StackViewCornerRadius()
        block2.spacing = 8
        block2.addSeparatorLine()
        block2.addLabel(text: "Староста")
        block2.addLabel(text: group?.leaderName ?? "Нет ФИО старосты")
        block2.addLabel(text: group?.leaderEmail ?? "Нет ФИО старосты")
        block2.addLabel(text: group?.leaderName ?? "Нет ФИО старосты")
        block2.addSeparatorLine()
        stackView.addArrangedSubview(block2)
        block2.widthAnchor.constraint(equalTo: stackView.widthAnchor).isActive = true

    }

    convenience init(group: RGroup) {
        self.init()
        self.group = group
    }
    
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

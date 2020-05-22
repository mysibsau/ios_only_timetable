//
//  SubgroupProfessorVeiw.swift
//  Timetable
//
//  Created by art-off on 04.05.2020.
//  Copyright © 2020 art-off. All rights reserved.
//

//import UIKit
//
//class SubgroupProfessorVeiw: UIView {
//
//    var groupsId: [Int]?
//    var placeId: Int?
//    
//    
//    @IBOutlet weak var contentView: UIView!
//    
//    @IBOutlet weak var subject: UILabel!
//    @IBOutlet weak var type: UILabel!
//    @IBOutlet weak var group: UILabel!
//    @IBOutlet weak var place: UILabel!
//    
//    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        loadXib()
//        setupViews()
//        addRecongnizers()
//    }
//    
//    required init?(coder: NSCoder) {
//        super.init(coder: coder)
//        loadXib()
//        setupViews()
//        addRecongnizers()
//    }
//    
//    private func loadXib() {
//        // загружаем xib из какого-то Boundle (можно чекнуть документацию)
//        Bundle.main.loadNibNamed("SubgroupView", owner: self, options: nil)
//        addSubview(contentView)
//        contentView.frame = self.bounds
//        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//    }
//    
//    private func setupViews() {
//        contentView.backgroundColor = Colors.contentColor
//        setupLabels()
//    }
//    
//    private func addRecongnizers() {
//        let longRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(longPress))
//        self.addGestureRecognizer(longRecognizer)
//    }
//    
//    private func setupLabels() {
//        for label in [subject, type, professor, place] {
//            label?.textAlignment = .left
//            label?.numberOfLines = 0
//            label?.lineBreakMode = .byWordWrapping
//        }
//        place.textAlignment = .right
//        place.textColor = .gray
//        
//        subject.textColor = Colors.sibsuBlue
//        type.textColor = Colors.sibsuGreen
//        professor.textColor = .systemGray
//    }
//    
//    @objc func longPress() {
//        // 1. let timetable = DataManager.sharedInstance.getTimetable(forProfessor: professorId)
//        // NotificationCenter.default.post(name: .didSelectProfessor, object: self, userInfo: [0: timetalbe])
//        
//        // 2. let timetable = DataManager.sharedinstance.gettimetable(forPlace: placeId)
//        // NotificationCenter.default.post(name: .didSelectPlace, object: self, userInfo: [0: timetalbe])
//    }
//
//}

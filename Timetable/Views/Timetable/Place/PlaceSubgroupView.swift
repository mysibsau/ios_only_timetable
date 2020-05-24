//
//  PlaceSubgroupView.swift
//  Timetable
//
//  Created by art-off on 24.05.2020.
//  Copyright © 2020 art-off. All rights reserved.
//

import UIKit

class PlaceSubgroupView: UIView {

    var groupsId: [Int]?
    var placeId: Int?
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var subject: UILabel!
    @IBOutlet weak var type: UILabel!
    @IBOutlet weak var professor: UILabel!
    @IBOutlet weak var group: UILabel!
    
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        loadXib()
        setupViews()
        addRecongnizers()
    }
    
    // MARK: - Setup Views
    private func loadXib() {
        // загружаем xib из какого-то Boundle (можно чекнуть документацию)
        Bundle.main.loadNibNamed("PlaceSubgroupView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
    
    private func setupViews() {
        contentView.backgroundColor = Colors.contentColor
        setupLabels()
    }
    
    private func setupLabels() {
        for label in [subject, type, professor, group] {
            label?.textAlignment = .left
            label?.numberOfLines = 0
            label?.lineBreakMode = .byWordWrapping
        }
        group.textAlignment = .right
        group.textColor = .gray
        
        subject.textColor = Colors.sibsuBlue
        type.textColor = Colors.sibsuGreen
        group.textColor = .systemGray
    }
    
    // MARK: - Recongnizers
    private func addRecongnizers() {
        let longRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(longPress))
        self.addGestureRecognizer(longRecognizer)
    }
    
    @objc func longPress() {
        // 1. let timetable = DataManager.sharedInstance.getTimetable(forProfessor: professorId)
        // NotificationCenter.default.post(name: .didSelectProfessor, object: self, userInfo: [0: timetalbe])
        
        // 2. let timetable = DataManager.sharedinstance.gettimetable(forPlace: placeId)
        // NotificationCenter.default.post(name: .didSelectPlace, object: self, userInfo: [0: timetalbe])
    }

}

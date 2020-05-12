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
    
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var leaderName: UILabel!
    @IBOutlet weak var leaderEmail: UILabel!
    @IBOutlet weak var leaderPhone: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.name.text = group?.name

        if let email = group?.email {
            self.email.text = email
        } else {
            self.email.text = "Нет информации"
        }
        
        if let leaderName = group?.leaderName {
            self.leaderName.text = leaderName
        } else {
            self.leaderName.text = "Нет информации"
        }
        
        if let leaderEmail = group?.leaderPhone {
            self.leaderEmail.text = leaderEmail
        } else {
            self.leaderEmail.text = "Нет информации"
        }
        
        if let leaderPhone = group?.leaderPhone {
            self.leaderPhone.text = leaderPhone
        } else {
            self.leaderPhone.text = "Нет информации"
        }
        
    }
    
    convenience init(group: RGroup) {
        self.init()
        self.group = group
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

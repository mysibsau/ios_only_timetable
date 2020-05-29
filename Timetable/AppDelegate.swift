//
//  AppDelegate.swift
//  Timetable
//
//  Created by art-off on 07.04.2020.
//  Copyright © 2020 art-off. All rights reserved.
//

import Foundation
import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        //Common.addGroups()
        //Common.addProfessors()
        //Common.addPlaces()
        
        
        //Common.addGroupTimetable1()
        //Common.addGroupTimetable5()
        
        //Common.addProfessorTimetable1()
        //Common.addProfessorTimetable5()
        
        //Common.addPlaceTimetable0()
        //Common.addPlaceTimetable99()
        
        
        return true
    }

    // MARK: UISceneSession Lifecycle
    @available(iOS 13.0, *)
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

}


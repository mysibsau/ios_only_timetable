//
//  AppDelegate.swift
//  Timetable
//
//  Created by art-off on 07.04.2020.
//  Copyright © 2020 art-off. All rights reserved.
//

import Foundation
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
//        Common.addGroups()
//        Common.addProfessors()
//        Common.addPlaces()
        
        
//        Common.addGroupTimetable1()
//        Common.addGroupTimetable5()
        
//        Common.addProfessorTimetable1()
//        Common.addProfessorTimetable5()
//
//        Common.addPlaceTimetable0()
//        Common.addPlaceTimetable99()
        
        //openRealm()
        
        return true
    }
    
//    func openRealm() {
//        guard let bundleDownloadedURL = Bundle.main.path(forResource: "init-data", ofType: "realm") else { return }
//        //print(bundleDownloadedURL)
//
//        let fileManager = FileManager.default
//
//        // создаем дирректорию для приложения в Documents
//        let sibsuURL = try! fileManager
//            .url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
//            .appendingPathComponent("sibsu")
//
//        if !fileManager.fileExists(atPath: sibsuURL.path) {
//            do {
//                try fileManager.createDirectory(at: sibsuURL, withIntermediateDirectories: true, attributes: nil)
//            } catch {
//                NSLog("Не выходит создать папку в Document директории")
//            }
//        }
//
//        // Конечное нахождение файла realm
//        let downloadedURL = sibsuURL.appendingPathComponent("sibsu-downloaded.realm").path
//
//        if !fileManager.fileExists(atPath: downloadedURL) {
//            do {
//                try fileManager.copyItem(atPath: bundleDownloadedURL, toPath: downloadedURL)
//            } catch let error {
//                print(error)
//            }
//        }
//    }

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


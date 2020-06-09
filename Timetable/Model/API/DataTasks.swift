//
//  DataTasks.swift
//  Timetable
//
//  Created by art-off on 09.06.2020.
//  Copyright © 2020 art-off. All rights reserved.
//

import Foundation

// Класс для скачивания нескольких данных
class DataTasks {
    
    // MARK: - Properties
    private var tasks = [URLSessionDataTask]()
    
    private var isDownloading = false
    
    
    // MARK: - Methods
    func add(task: URLSessionDataTask) {
        guard !isDownloading else { return }
        
        tasks.append(task)
    }
    
    func resumeAll() {
        guard !isDownloading else { return }
        
        for task in tasks {
            task.resume()
        }
        
        isDownloading = true
    }
    
    func cancelAll() {
        guard isDownloading else { return }
        
        for task in tasks {
            task.cancel()
        }
        
        isDownloading = false
    }
    
}

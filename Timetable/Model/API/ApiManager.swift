//
//  ApiManager.swift
//  Timetable
//
//  Created by art-off on 07.06.2020.
//  Copyright © 2020 art-off. All rights reserved.
//

import Foundation

class ApiManager {
    
    static let shared = ApiManager()
    
    // MARK: - Privates properties
    private let downloadingQueue: OperationQueue = {
        let queue = OperationQueue()
        queue.maxConcurrentOperationCount = 2
        return queue
    }()
    
    private let session = URLSession(configuration: URLSessionConfiguration.default)
    
    
    // MARK: - Прекращение всех загрузок
    func cancelAllDownloading() {
        downloadingQueue.cancelAllOperations()
    }
    
    
    // MARK: - Скачивание группы и хэша
    func loadGroupsAndGroupsHash(completion: @escaping (_ groupsHash: String?, _ groups: [RGroup]?) -> Void) {
        var downloadedGroupsHash: String?
        var downloadedGroups: [RGroup]?

        let completionOperation = BlockOperation {
            completion(downloadedGroupsHash, downloadedGroups)
        }

        let groupsDownloadOperation = DownloadOperation(session: session, url: API.groups()) { data, response, error in
            guard let groups = ResponseHandler.handleGroupsResponse(data, response, error) else {
                completion(nil, nil)
                self.downloadingQueue.cancelAllOperations()
                return
            }
            
            downloadedGroups = groups
        }
        
        let hashDownloadOperation = DownloadOperation(session: session, url: API.groupsHash()) { data, response, error in
            guard let hash = ResponseHandler.handleHashResponse(data, response, error) else {
                completion(nil, nil)
                self.downloadingQueue.cancelAllOperations()
                return
            }
            
            downloadedGroupsHash = hash
        }

        completionOperation.addDependency(groupsDownloadOperation)
        completionOperation.addDependency(hashDownloadOperation)

        downloadingQueue.addOperation(groupsDownloadOperation)
        downloadingQueue.addOperation(hashDownloadOperation)
        downloadingQueue.addOperation(completionOperation)
    }
    
    
    // MARK: - Скачивание расписания для группы
    func loadGroupTimetable(withId id: Int,
                            completionIfNeedNotLoadGroups: @escaping (_ groupsHash: String?, _ groupTimetable: RGroupTimetable?) -> Void,
                            startIfNeedLoadGroups: @escaping () -> Void,
                            completionIfNeedLoadGroups: @escaping (_ groupsHash: String?, _ groups: [RGroup]?, _ groupTimetable: RGroupTimetable?) -> Void) {
        
        var downloadedGroupTimetable: RGroupTimetable?
        var downloadedGroupsHash: String?
        
        let completionOperation = BlockOperation {
            guard
                let downloadedGroupTimetable = downloadedGroupTimetable,
                let downloadedGroupsHash = downloadedGroupsHash
            else {
                completionIfNeedNotLoadGroups(nil, nil)
                return
            }
            
            if downloadedGroupsHash == UserDefaultsConfig.groupsHash {
                completionIfNeedNotLoadGroups(downloadedGroupsHash, downloadedGroupTimetable)
            } else {
                startIfNeedLoadGroups()
                self.loadGroupsAndGroupsHashForLoadTimetable(groupTimegable: downloadedGroupTimetable, completion: completionIfNeedLoadGroups)
            }
        }
        
        let groupTimetableDownloadOperation = DownloadOperation(session: session, url: API.timetable(forGroupId: id)) { data, response, error in
            let (optionalGroupTimetable, optionalGroupHash) = ResponseHandler.handleGroupTimetableResponse(groupId: id, data, response, error)
            
            guard
                let groupTimetable = optionalGroupTimetable,
                let groupHash = optionalGroupHash
            else {
                // Есил не вышло скачать - прекращаем все загрузки и пытаемся открыть старое
                self.downloadingQueue.cancelAllOperations()
                completionIfNeedNotLoadGroups(nil, nil)
                return
            }
            
            downloadedGroupsHash = groupHash
            downloadedGroupTimetable = groupTimetable
        }
        
        // Добавляем зависимости
        completionOperation.addDependency(groupTimetableDownloadOperation)
        
        // Добавляем все в очередь
        downloadingQueue.addOperation(groupTimetableDownloadOperation)
        downloadingQueue.addOperation(completionOperation)
    }
    
    private func loadGroupsAndGroupsHashForLoadTimetable(groupTimegable: RGroupTimetable, completion: @escaping (_ groupsHash: String?, _ groups: [RGroup]?, _ groupTimetable: RGroupTimetable?) -> Void) {
        var downloadedGroupsHash: String?
        var downloadedGroups: [RGroup]?

        let completionOperation = BlockOperation {
            completion(downloadedGroupsHash, downloadedGroups, groupTimegable)
        }

        let groupsDownloadOperation = DownloadOperation(session: session, url: API.groups()) { data, response, error in
            guard let groups = ResponseHandler.handleGroupsResponse(data, response, error) else {
                completion(nil, nil, nil)
                self.downloadingQueue.cancelAllOperations()
                return
            }
            
            downloadedGroups = groups
        }
        
        let hashDownloadOperation = DownloadOperation(session: session, url: API.groupsHash()) { data, response, error in
            guard let hash = ResponseHandler.handleHashResponse(data, response, error) else {
                completion(nil, nil, nil)
                self.downloadingQueue.cancelAllOperations()
                return
            }
            
            downloadedGroupsHash = hash
        }

        completionOperation.addDependency(groupsDownloadOperation)
        completionOperation.addDependency(hashDownloadOperation)

        downloadingQueue.addOperation(groupsDownloadOperation)
        downloadingQueue.addOperation(hashDownloadOperation)
        downloadingQueue.addOperation(completionOperation)
    }
    
    // MARK: - Curr Week Number
    static func loadCurrWeekIsEwenTask(complition: @escaping (Bool?) -> Void) -> URLSessionDataTask {
        let url = API.currWeekIsEven()
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let httpResponse = response as? HTTPURLResponse,
                (200..<300).contains(httpResponse.statusCode) else {
                    complition(nil)
                    return
            }
            
            guard let data = data else {
                complition(nil)
                return
            }
            
            do {
                guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                    let currWeekIsEven = json["isEven"] as? String else {
                        complition(nil)
                        return
                }
                
                if currWeekIsEven.lowercased() == "true" {
                    complition(true)
                } else if currWeekIsEven.lowercased() == "false" {
                    complition(false)
                } else {
                    complition(nil)
                }
            } catch let jsonError {
                print(jsonError)
                complition(nil)
            }
        }
        
        return task
    }

}

//
//  DownloadOperation.swift
//  Timetable
//
//  Created by art-off on 05.09.2020.
//  Copyright © 2020 art-off. All rights reserved.
//

import Foundation

class DownloadOperation: Operation {
    
    private var task: URLSessionDataTask!
    
    
    // MARK: - State
    enum OperationState: Int {
        case ready
        case executing
        case finished
    }
    
    // default state is ready (when the operation is created)
    private var state: OperationState = .ready {
        willSet {
            self.willChangeValue(forKey: "isExecuting")
            self.willChangeValue(forKey: "isFinished")
        }
        
        didSet {
            self.didChangeValue(forKey: "isExecuting")
            self.didChangeValue(forKey: "isFinished")
        }
    }
    
    override var isReady: Bool { return state == .ready }
    override var isExecuting: Bool { return state == .executing }
    override var isFinished: Bool { return state == .finished }
    
    
    // MARK: - Initialization
    init(session: URLSession, url: URL, completionHandler: ((Data?, URLResponse?, Error?) -> Void)?) {
        super.init()
        
        task = session.dataTask(with: url) { [weak self] data, response, error in
            if let completionHandler = completionHandler {
                completionHandler(data, response, error)
            }
            self?.state = .finished
        }
    }
    
    
    // MARK: - Overrides Methods
    override func start() {
        /*
         if the operation or queue got cancelled even
         before the operation has started, set the
         operation state to finished and return
         */
        if (self.isCancelled) {
            state = .finished
            return
        }
        
        // set the state to executing
        state = .executing
        
        print("downloading \(self.task.originalRequest?.url?.absoluteString ?? "")")
        
        // start the downloading
        self.task.resume()
    }
    
    override func cancel() {
        super.cancel()
        
        // cancel the downloading
        self.task.cancel()
    }
    
}

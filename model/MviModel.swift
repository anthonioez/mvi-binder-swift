//
//  MviModel.swift
//  CatchupiOS
//
//  Created by Anthony Ezeh on 07/07/2022.
//

import Foundation

class MviModel<Intent, Event>: BinderEvent<Event>, BinderConsumer {

    internal let serialQueue = {
        return DispatchQueue(label: UUID.init().uuidString)
    }()

    override func destroy() {
        super.destroy()
    }

    func consume(_ event: Any) {
        DispatchQueue.main.async { [weak self] in
            self?.consumeEvent(event)
        }
    }

    func consumeEvent(_ event: Any) {
        
    }

    func syncExecute(_ work: @escaping () -> Void) {
        serialQueue.sync(execute: work)
    }

    func asyncExecute(_ work: @escaping () -> Void) {
        serialQueue.async(execute: work)
    }

}

//
//  BinderEvent.swift
//  CatchupiOS
//
//  Created by Anthony Ezeh on 07/07/2022.
//

import Foundation
import UIKit

class BinderEvent<EventType> : NSObject, BinderProducer {
     
    typealias Producer = EventType

    private let uuid: String!
    
    private var queue: DispatchQueue!
    
    private var listeners = [BinderObserver]()
    
    override init() {
        uuid = UUID.init().uuidString
        queue = DispatchQueue(label: uuid, qos: DispatchQoS.background)        
    }
    
    deinit {
        destroy()
    }
    
    // overrides
    func subscribe(_ observer: BinderObserver) {
        if !listeners.contains(where: { $0.isEqualTo(observer) }) {
            listeners.append(observer)
        }
    }
    
    func unsubscribe(_ observer: BinderObserver) {
        if let index = listeners.firstIndex(where: { $0.isEqualTo(observer) }) {
            listeners.remove(at: index)
        }
    }

    // publics
    public func produce(_ event: EventType) {
        queue.async {
            self.notifyListeners(event)
        }
    }
    
    public func destroy() {
        queue = nil
        listeners.removeAll()
    }

    // privates
    private func notifyListeners(_ value: EventType) {
        for listener in listeners {
            DispatchQueue.global(qos: .default).async {
                listener.onEvent(value)
            }
        }
    }

}

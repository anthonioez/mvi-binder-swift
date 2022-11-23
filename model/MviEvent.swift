//
//  MviEvent.swift
//  Binder
//
//  Created by Anthony Ezeh on 07/07/2022.
//

import Foundation

protocol MviEvent {
    associatedtype Event
    associatedtype S
    associatedtype E
    
    init()
    
    var effect: E? {
        get
        set
    }
    
    var state: S? {
        get
        set
    }
    
}

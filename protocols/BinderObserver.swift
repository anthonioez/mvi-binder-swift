//
//  BinderObserver.swift
//  Binder
//
//  Created by Anthony Ezeh on 07/07/2022.
//

import Foundation

public protocol BinderObserver : NSObjectProtocol {
    
    func onEvent(_ event: Any)

    func isEqualTo(_ observer: BinderObserver) -> Bool
    
}


extension BinderObserver where Self: Equatable {
    
    func isEqualTo(_ observer: BinderObserver) -> Bool {
        guard let entry = observer as? Self else { return false }
        return self == entry
    }
    
}

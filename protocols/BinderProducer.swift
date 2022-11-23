//
//  BinderProducer.swift
//  Binder
//
//  Created by Anthony Ezeh on 07/07/2022.
//

import Foundation

public protocol BinderProducer : NSObjectProtocol  {
        
    func subscribe(_ observer: BinderObserver)
    
    func unsubscribe(_ observer: BinderObserver)

}

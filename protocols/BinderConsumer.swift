//
//  BinderConsumer.swift
//  Binder
//
//  Created by Anthony Ezeh on 07/07/2022.
//

import Foundation

protocol BinderConsumer : NSObjectProtocol  {
    
    func consume(_ event: Any)
    
}

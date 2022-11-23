//
//  Binder.swift
//  Binder
//
//  Created by Anthony Ezeh on 07/07/2022.
//

import Foundation

final class Binder {

    private var bindings = [BinderConnection]()
    private var name = ""

    init(_ named: String = "") {
        self.name = named
    }

    func bind(_ from: BinderProducer?, to: BinderConsumer?) {
        
        if let from = from, let to = to {            
            let binding = BinderConnection(from, to: to)
            binding.connect()
            
            bindings.append(binding)
        }
    }
    
    func bind(_ connection : BinderConnection) {
        connection.name = name
        connection.connect()
        bindings.append(connection)
    }

    func destroy() {
        for binding in bindings {
            binding.disconnect()
            binding.destroy()
        }
        bindings.removeAll()
    }

}



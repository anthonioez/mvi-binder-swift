//
//  BinderMiddleware.swift
//  CatchupiOS
//
//  Created by Anthony Ezeh on 07/09/2022.
//

import Foundation

final class BinderMiddleware {

    static let shared = BinderMiddleware()

    private var middlewares = [BinderInterceptor]()

    private init () {
    }

    func registerMiddleware(_ middleware: BinderInterceptor) {
        middlewares.append(middleware)
    }

    func intercept(_ name: String, event: Any) -> Any {
        var interceptedEvent = event
        for middleware in middlewares {
            if let newEvent = middleware.intercept(name, input: interceptedEvent) {
                interceptedEvent = newEvent
            }
        }
        return interceptedEvent
    }

}

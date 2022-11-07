//
//  BinderConnection.swift
//  CatchupiOS
//
//  Created by Anthony Ezeh on 07/07/2022.
//

import Foundation

final class BinderConnection: NSObject, BinderObserver {

    private var producer: BinderProducer? = nil
    private var consumer: BinderConsumer? = nil
    private var transformer: BinderTransformer? = nil
    private var interceptor: BinderInterceptor? = nil

    var name = ""
    var intercepted = false

    static func using(_ transformer: BinderTransformer?) -> BinderConnection {
        return BinderConnection(using: transformer)
    }

    static func tying(_ interceptor: BinderInterceptor?) -> BinderConnection {
        return BinderConnection(tying: interceptor)
    }

    static func intercepted() -> BinderConnection {
        return BinderConnection().withIntercept()
    }

    static func interceptUsing(_ transformer: BinderTransformer?) -> BinderConnection {
        return BinderConnection(using: transformer).withIntercept()
    }

    init(_ from: BinderProducer? = nil,
         to: BinderConsumer? = nil,
         using transformer: BinderTransformer? = nil,
         tying interceptor: BinderInterceptor? = nil) {
        self.producer = from
        self.consumer = to
        self.transformer = transformer
        self.interceptor = interceptor
    }

    func onEvent(_ event: Any) {
        let interceptedEvent = intercepted ? BinderMiddleware.shared.intercept(name, event: event) : event
        if let transformer = transformer {
            consumer?.consume(transformer.tranform(input: interceptedEvent))
        } else {
            consumer?.consume(interceptedEvent)
        }
    }

    func withIntercept() -> BinderConnection {
        intercepted = true
        return self
    }

    func connect() {
        producer?.subscribe(self)
    }
    
    func disconnect() {
        producer?.unsubscribe(self)
    }

    func destroy() {
        producer = nil
        consumer = nil
        transformer = nil
        interceptor = nil
    }
    
}

extension BinderConnection {

    static func >>> (lhs: BinderProducer, rhs: BinderConnection) -> BinderConnection {
        rhs.producer = lhs
        return rhs
    }

    static func <<< (lhs: BinderConsumer, rhs: BinderConnection) -> BinderConnection {
        rhs.consumer = lhs
        return rhs
    }

}

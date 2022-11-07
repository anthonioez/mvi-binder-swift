//
//  MviMiddleware.swift
//  CatchupiOS
//
//  Created by Anthony Ezeh on 24/08/2022.
//

import Foundation

protocol BinderInterceptor {

    func intercept(_ name: String, input: Any) -> Any?

}

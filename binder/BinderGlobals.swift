//
//  BinderGlobals.swift
//  CatchupiOS
//
//  Created by Anthony Ezeh on 24/08/2022.
//

import Foundation

precedencegroup ProducerPrecedence {
    associativity: right
    lowerThan: BitwiseShiftPrecedence

}
infix operator >>> : ProducerPrecedence

precedencegroup ConsumerPrecedence {
    associativity: right
    higherThan: ProducerPrecedence
}
infix operator <<< : ConsumerPrecedence

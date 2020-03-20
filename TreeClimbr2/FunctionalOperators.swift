//
//  FunctionalOperators.swift
//  TreeClimbr2
//
//  Created by Mar Koss on 2020-03-19.
//  Copyright © 2020 Mar Koss. All rights reserved.
//

import Foundation

precedencegroup ForwardApplication
{
    associativity: left
}

// Pipe Forward operator
infix operator |> : ForwardApplication

func |> <A, B> (a: A, f: (A) -> B) -> B
{
    return f(a)
}


precedencegroup ForwardComposition
{
    associativity: left
    higherThan: ForwardApplication
}

// Forward Compose Operator
infix operator >>> : ForwardComposition

func >>> <A, B, C> (f: @escaping (A) -> B, g: @escaping (B) -> C) -> ((A) -> C)
{
    return { a in
        g(f(a))
    }
}

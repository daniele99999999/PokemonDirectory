//
//  PropertyWrapperAtomic.swift
//  PokemonDirectory
//
//  Created by daniele on 28/09/2020.
//  Copyright © 2020 DeeplyMadStudio. All rights reserved.
//

import Foundation

@propertyWrapper public final class Atomic<Value>
{
    private var queue = DispatchQueue(label: "com.atomic.queue")
    private var value: Value

    public init(wrappedValue: Value)
    {
        self.value = wrappedValue
        self.queue = DispatchQueue(label: "com.atomic.queue.\(type(of: wrappedValue)).\(ObjectIdentifier(self))")
    }
    
    public var wrappedValue: Value
    {
        get
        {
            return self.queue.sync { self.value }
        }
        set
        {
            self.queue.sync { self.value = newValue }
        }
    }
    
    public func mutate(_ mutation: (inout Value) -> Void)
    {
        return self.queue.sync
        {
            mutation(&self.value)
        }
    }
}

//
//  Person.swift
//  Test
//
//  Created by Cameron S Slash on 8/1/24.
//

import Foundation
import SwiftData

@Model
public class Person: Identifiable {
    public var id: UUID
    public var name: String
    public var age: Int
    
    public init(name: String, age: Int) {
        self.id = UUID()
        self.name = name
        self.age = age
    }
}

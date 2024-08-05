//
//  ContentViewModel.swift
//  Test
//
//  Created by Cameron S Slash on 8/1/24.
//

import Factory
import Fakery
import Foundation
import SwiftUI
import Observation

public class ContentViewModel {
    @ObservationIgnored @Injected(\.swiftDataService) private var swiftDataService: any ISwiftDataService
    
    public var people: [Person] { return swiftDataService.people }
    
    public init() { }
    
    public func addPerson(_ person: Person, completion: (_ success: Bool) -> Void) {
        completion(self.swiftDataService.addPerson(person))
    }
    
    public func deletePerson(at indexSet: IndexSet, completion: (_ success: Bool) -> Void) {
        for index in indexSet {
            completion(self.swiftDataService.deletePerson(self.people[index]))
        }
    }
    
    public func deletePerson(_ person: Person, completion: (_ success: Bool) -> Void) {
        completion(self.swiftDataService.deletePerson(person))
    }
}

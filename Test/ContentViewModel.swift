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
    @ObservationIgnored @Injected(\.faker) private var faker: Faker
    
    public var people: [Person] { return swiftDataService.people }
    
    public var multiSelection: Set<Person.ID> = .init()
    
    public var requestSuccessful: Bool?
    
    public init() { }
    
    public func addPerson(completion: (_ success: Bool) -> Void) {
        completion(self.swiftDataService.addPerson(Person(name: self.faker.name.name(), age: self.faker.number.randomInt(min: 18, max: 50))))
    }
    
    public func deletePerson(at indexSet: IndexSet) {
        for index in indexSet {
            self.requestSuccessful = self.swiftDataService.deletePerson(self.people[index])
        }
    }
    
    public func deleteSelection() {
        for id in multiSelection {
            self.requestSuccessful = self.swiftDataService.deletePersonById(id)
        }
    }
}

//
//  MockSwiftDataService.swift
//  PeopleTests
//
//  Created by Cameron S Slash on 8/2/24.
//

import Foundation
import Observation
import People
import SwiftData

@Observable
internal class MockSwiftDataService: ISwiftDataService {
    var people: [Person] = []
    
    var tempPeople: [Person] = []
    
    required init(modelContext: ModelContext) { }
    
    required init() { }
    
    func fetchPeople() {
        self.people.append(contentsOf: self.tempPeople)
        self.tempPeople = []
    }
    
    func addPerson(_ person: People.Person) -> Bool {
        self.tempPeople.append(person)
        self.fetchPeople()
        return true
    }
    
    func updatePerson(_ person: People.Person) -> Bool {
        return false
    }
    
    func deletePerson(_ person: People.Person) -> Bool {
        self.people.removeAll(where: { $0.id == person.id })
        self.fetchPeople()
        return true
    }
}

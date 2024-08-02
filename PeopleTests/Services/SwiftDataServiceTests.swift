//
//  SwiftDataServiceTests.swift
//  PeopleTests
//
//  Created by Cameron Slash on 8/1/24.
//

import Fakery
@testable import People
import SwiftData
import Testing

@MainActor
struct SwiftDataServiceTests {
    let faker: Faker
    
    init() throws {
        self.faker = Faker()
    }
    
    @Test func appStartsEmpty() async throws {
        //Arrange
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Person.self, configurations: config)
        
        //Act
        let service = SwiftDataService(modelContext: container.mainContext)
        
        //Assert
        #expect(service.people.isEmpty)
    }
    
    @Test func canAddPerson() async throws {
        //Arrange
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Person.self, configurations: config)
        let service = SwiftDataService(modelContext: container.mainContext)
        let person = Person(name: faker.name.name(), age: faker.number.randomInt(min: 18, max: 50))
        
        //Act
        #expect(service.people.isEmpty)
        
        let successfulResult = service.addPerson(person)
        service.fetchPeople()
        
        //Assert
        #expect(successfulResult)
        #expect(!service.people.isEmpty)
        #expect(service.people.contains(where: { $0.id == person.id }))
    }
    
    @Test func canDeletePerson() async throws {
        //Arrange
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Person.self, configurations: config)
        let service = SwiftDataService(modelContext: container.mainContext)
        let person = Person(name: faker.name.name(), age: faker.number.randomInt(min: 18, max: 50))
        
        _ = service.addPerson(person)
        service.fetchPeople()
        
        //Act
        #expect(!service.people.isEmpty)
        
        let successfulResult = service.deletePerson(person)
        service.fetchPeople()
        
        //Assert
        #expect(successfulResult)
        #expect(service.people.isEmpty)
    }
}

//
//  ContentViewModelTests.swift
//  PeopleTests
//
//  Created by Cameron Slash on 8/1/24.
//

import Fakery
import Factory
@testable import People
import Testing

struct ContentViewModelTests {
    let contentViewModel: ContentViewModel
    let faker: Faker = .init()
    
    init() throws {
        Container.shared.reset()
        Container.shared.swiftDataService.register { MockSwiftDataService() }
        
        self.contentViewModel = ContentViewModel()
    }

    @Test func canFetchPeople() async throws {
        Container.shared.reset()
        Container.shared.swiftDataService.register { MockSwiftDataService() }
        
        //Arrange
        for _ in 0..<3 {
            let person = Person(name: self.faker.name.name(), age: self.faker.number.randomInt(min: 18, max: 50))
            self.contentViewModel.addPerson(person) { _ in }
        }
        
        //Act
        let people = self.contentViewModel.people
        
        //Assert
        #expect(!people.isEmpty)
        #expect(people.count == 3)
    }
    
    @Test func canAddPerson() async throws {
        Container.shared.reset()
        Container.shared.swiftDataService.register { MockSwiftDataService() }
        
        //Arrange
        let fakeName = self.faker.name.name()
        let fakeAge = self.faker.number.randomInt(min: 18, max: 50)
        let person = Person(name: fakeName, age: fakeAge)
        
        //Act
        var successfulResponse: Bool = false
        self.contentViewModel.addPerson(person) { success in successfulResponse = success }
        
        //Assert
        #expect(successfulResponse)
        #expect(!self.contentViewModel.people.isEmpty)
        #expect(self.contentViewModel.people.first?.name == fakeName)
        #expect(self.contentViewModel.people.first?.age == fakeAge)
    }
    
    @Test func canDeletePerson() async throws {
        Container.shared.reset()
        Container.shared.swiftDataService.register { MockSwiftDataService() }
        
        //Arrange
        let person = Person(name: self.faker.name.name(), age: self.faker.number.randomInt(min: 18, max: 50))
        self.contentViewModel.addPerson(person) { _ in }
        let firstPerson = self.contentViewModel.people.first!
        
        //Act
        var successfulResponse: Bool = false
        self.contentViewModel.deletePerson(firstPerson) { success in successfulResponse = success }
        
        //Assert
        #expect(successfulResponse)
        #expect(self.contentViewModel.people.isEmpty)
    }
}

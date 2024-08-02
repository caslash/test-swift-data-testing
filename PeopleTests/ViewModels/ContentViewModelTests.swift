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
    
    init() throws {
        Container.shared.faker.register { Faker() }
        Container.shared.swiftDataService.register { MockSwiftDataService() }
        
        self.contentViewModel = ContentViewModel()
    }

    @Test func canFetchPeople() async throws {
        //Arrange
        for _ in 0..<3 {
            self.contentViewModel.addPerson { _ in }
        }
        
        //Act
        let people = self.contentViewModel.people
        
        //Assert
        #expect(!people.isEmpty)
        #expect(people.count == 3)
    }
    
    @Test func canAddPerson() async throws {
        //Arrange
        let faker = Container.shared.faker.resolve()
        let fakeName = faker.name.name()
        let fakeAge = faker.number.randomInt(min: 18, max: 50)
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
        //Arrange
        self.contentViewModel.addPerson() { _ in }
        let person = self.contentViewModel.people.first!
        
        //Act
        var successfulResponse: Bool = false
        self.contentViewModel.deletePerson(person) { success in successfulResponse = success }
        
        //Assert
        #expect(successfulResponse)
        #expect(self.contentViewModel.people.isEmpty)
    }
}

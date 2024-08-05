//
//  AddPersonViewModelTests.swift
//  PeopleTests
//
//  Created by Cameron S Slash on 8/5/24.
//

import Fakery
import Factory
@testable import People
import Testing

struct AddPersonViewModelTests {
    let faker: Faker = .init()
    
    init() throws {
        Container.shared.reset()
        Container.shared.swiftDataService.register { MockSwiftDataService() }
    }
    
    @Test func canSavePerosn() async throws {
        Container.shared.reset()
        Container.shared.swiftDataService.register { MockSwiftDataService() }
        
        var successfulResponse: Bool = false
        
        //Arrange
        let contentViewModel = ContentViewModel()
        let addPersonViewModel = AddPersonViewModel { success in
            successfulResponse = success
        }
        
        let name = self.faker.name.name()
        let age = self.faker.number.randomInt(min: 18, max: 50)
        
        addPersonViewModel.name = name
        addPersonViewModel.age = age
        
        //Act
        addPersonViewModel.savePerson()
        
        //Assert
        #expect(successfulResponse)
        #expect(!contentViewModel.people.isEmpty)
        #expect(contentViewModel.people.contains(where: { $0.name == name }))
    }
}

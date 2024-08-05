//
//  AddPersonViewModel.swift
//  People
//
//  Created by Cameron S Slash on 8/5/24.
//

import Factory
import Foundation
import Observation

@Observable
public class AddPersonViewModel {
    @ObservationIgnored @Injected(\.swiftDataService) private var swiftDataService
    
    public var name: String = ""
    public var age: Int = 18
    
    private var saveCompletion: (_ success: Bool) -> Void
    
    public init(_ completion: @escaping (_ success: Bool) -> Void) {
        self.saveCompletion = completion
    }
    
    public func savePerson() {
        let newPerson = Person(name: self.name, age: self.age)
        self.saveCompletion(self.swiftDataService.addPerson(newPerson))
    }
}

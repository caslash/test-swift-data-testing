//
//  SwiftDataService.swift
//  Test
//
//  Created by Cameron S Slash on 8/1/24.
//

import Foundation
import SwiftData
import Observation

public protocol ISwiftDataService {
    var people: [Person] { get }
    
    init()
    init(modelContext: ModelContext)
    
    func fetchPeople()
    func addPerson(_ person: Person) -> Bool
    func updatePerson(_ person: Person) -> Bool
    func deletePerson(_ person: Person) -> Bool
    func deletePersonById(_ id: Person.ID) -> Bool
}

@Observable
public class SwiftDataService: ISwiftDataService {
    private let modelContext: ModelContext
    
    public var people: [Person] = []
    
    public required init() {
        self.modelContext = try! ModelContext(ModelContainer(for: Person.self))
        self.fetchPeople()
    }
    
    public required init(modelContext: ModelContext) {
        self.modelContext = modelContext
        self.fetchPeople()
    }
    
    public func fetchPeople() {
        do {
            self.people = try self.modelContext.fetch(FetchDescriptor<Person>())
        } catch {
            print("Failed to fetch people: \(error.localizedDescription)")
        }
    }
    
    public func addPerson(_ person: Person) -> Bool {
        do {
            self.modelContext.insert(person)
            try self.modelContext.save()
            self.fetchPeople()
            return true
        } catch {
            print("Failed to add \(person.name): \(error.localizedDescription)")
            return false
        }
    }
    
    public func updatePerson(_ person: Person) -> Bool {
        do {
            return true
        } catch {
            print("Failed to update \(person.name): \(error.localizedDescription)")
            return false
        }
    }
    
    public func deletePerson(_ person: Person) -> Bool {
        do {
            self.modelContext.delete(person)
            try self.modelContext.save()
            self.fetchPeople()
            return true
        } catch {
            print("Failed to delete \(person.name): \(error.localizedDescription)")
            return false
        }
    }
    
    public func deletePersonById(_ id: Person.ID) -> Bool {
        do {
            let person = try self.modelContext.fetch(FetchDescriptor<Person>(predicate: #Predicate { $0.id == id })).first
            if let person {
                return self.deletePerson(person)
            }
            return false
        } catch {
            print("Failed to delete \(id): \(error.localizedDescription)")
            return false
        }
    }
}

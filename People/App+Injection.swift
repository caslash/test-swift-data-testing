//
//  App+Injection.swift
//  Test
//
//  Created by Cameron S Slash on 8/1/24.
//

import Fakery
import Factory
import Foundation

extension Container {
    var swiftDataService: Factory<any ISwiftDataService> {
        Factory(self) { SwiftDataService() }
            .singleton
    }
}

//
//  ContentView.swift
//  Test
//
//  Created by Cameron S Slash on 8/1/24.
//

import SwiftUI

struct ContentView: View {
    @State private var viewModel: ContentViewModel = .init()
    var body: some View {
        NavigationStack {
            List {
                ForEach(self.viewModel.people) { person in
                    HStack(alignment: .bottom) {
                        Text(person.name)
                        
                        Text("\(person.age)")
                            .font(.caption)
                            .foregroundStyle(.gray)
                    }
                }
                .onDelete(perform: self.viewModel.deletePerson)
            }
            .toolbar {
                Button{
                    self.viewModel.addPerson { success in print("Success: \(success)") }
                } label: {
                    Label("Add", systemImage: "plus")
                }
            }
        }
    }
}

#Preview {
    ContentView()
}

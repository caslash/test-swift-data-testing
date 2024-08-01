//
//  ContentView.swift
//  Test
//
//  Created by Cameron S Slash on 8/1/24.
//

import SwiftUI
import AlertToast

struct ContentView: View {
    @State private var viewModel: ContentViewModel = .init()
    
    @State private var showToast: Bool = false
    @State private var toastTitle: String?
    @State private var successfulToast: Bool?
    
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
                .onDelete { indexSet in
                    self.viewModel.deletePerson(at: indexSet) { success in
                        self.successfulToast = success
                        self.toastTitle = success ? "Deleted Person" : "Couldn't delete person"
                        self.showToast = true
                    }
                }
            }
            .toolbar {
                Button{
                    self.viewModel.addPerson { success in
                        self.successfulToast = success
                        self.toastTitle = success ? "Added Person" : "Couldn't add person"
                        self.showToast = true
                    }
                } label: {
                    Label("Add", systemImage: "plus")
                }
            }
        }
        .toast(isPresenting: $showToast, duration: 2, tapToDismiss: true) {
            AlertToast(displayMode: .hud, type: self.successfulToast ?? false ? .complete(.green) : .error(.red), title: self.toastTitle)
        } completion: {
            self.toastTitle = nil
            self.successfulToast = false
        }
    }
}

#Preview {
    ContentView()
}

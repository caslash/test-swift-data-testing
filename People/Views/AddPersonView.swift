//
//  AddPersonView.swift
//  People
//
//  Created by Cameron S Slash on 8/5/24.
//

import SwiftUI

struct AddPersonView: View {
    @Environment(\.dismiss) private var dissmiss
    @State private var viewModel: AddPersonViewModel
    
    var body: some View {
        Form {
            TextField("Name", text: self.$viewModel.name)
            
            Stepper("\(self.viewModel.age) years old", value: self.$viewModel.age)
        }
        .navigationTitle("Add Person")
        .toolbar {
            Button {
                self.viewModel.savePerson()
                self.dissmiss.callAsFunction()
            } label: {
                Label("Save", systemImage: "plus")
            }
        }
    }
    
    init(_ completion: @escaping (_ success: Bool) -> Void) {
        self.viewModel = AddPersonViewModel(completion)
    }
}

#Preview {
    NavigationStack {
        AddPersonView() { _ in }
    }
}

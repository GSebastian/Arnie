//
//  AddExerciseView.swift
//  Arnie Workout Tracker
//
//  Created by Sebastian Ghetu on 20/06/2020.
//  Copyright © 2020 Sebastian Ghetu. All rights reserved.
//

import SwiftUI

struct AddExerciseView: View {

    @State private var name: String?

    @Binding var shouldDisplay: Bool

    @ObservedObject var viewModel: AddExerciseViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            VStack(alignment: .leading, spacing: 12) {
                VStack(alignment: .leading) {
                    Text("Name")
                        .font(.headline)
                    TextField("for example, Pushup", text: $name)
                        .textFieldStyle(DefaultTextFieldStyle())
                }

                if viewModel.errorText != nil {
                    Text(viewModel.errorText!)
                        .foregroundColor(.systemRed)
                }
            }

            Button(action: {
                self.viewModel.saveExercise(named: self.name)
            }, label: ({
                Text("Save")
                    .foregroundColor(Color(.link))
                    .font(Font.headline.bold())
            }))
        }
        .padding()
        .backgroundColor(.secondarySystemBackground)
        .onReceive(viewModel.workoutSaved, perform: ({
            self.shouldDisplay = false
        }))
    }
}

struct AddExerciseView_Previews: PreviewProvider {
    static var previews: some View {
        AddExerciseView(shouldDisplay: .constant(true), viewModel: AddExerciseViewModel())
    }
}

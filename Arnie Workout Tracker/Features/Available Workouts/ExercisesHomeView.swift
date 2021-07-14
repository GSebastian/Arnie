//
//  ExercisesHomeView.swift
//  Arnie Workout Tracker
//
//  Created by Sebastian Ghetu on 20/06/2020.
//  Copyright © 2020 Sebastian Ghetu. All rights reserved.
//

import SwiftUI

struct ExercisesHomeView: View {
    
    @State private var addExerciseDisplayed = false
    
    var exercisesViewModel: ExercisesViewModel
    var addExerciseViewModel: AddExerciseViewModel

    var body: some View {
        VStack {
            HStack(alignment: .center) {
                Text("Exercises")
                    .font(.largeTitle)

                Spacer()

                Button(action: {
                    self.hideKeyboard()
                    self.addExerciseDisplayed.toggle()
                }) {
                    Text(addExerciseDisplayed ? "Cancel" : "Add New")
                        .font(.headline)
                }
                .animation(.none)
            }
            .padding()

            if addExerciseDisplayed {
                AddExerciseView(shouldDisplay: $addExerciseDisplayed,
                                viewModel: self.addExerciseViewModel)
            }

            ExercisesView(viewModel: exercisesViewModel)
        }
        .transition(AnyTransition.opacity)
        .animation(.easeInOut(duration: 0.3))
    }

    private func hideKeyboard() {
        // HACK: Having to dismiss the keyboard before navigating away
        // from the page, as described here:
        // https://stackoverflow.com/questions/58952203/swiftui-ios-app-crashes-when-state-change-causes-keyboard-to-resign-as-first-res
        UIApplication
            .shared
            .sendAction(
                #selector(UIResponder.resignFirstResponder),
                to: nil,
                from: nil,
                for: nil)
    }
}

struct ExercisesHomeView_Previews: PreviewProvider {
    static var previews: some View {
        ExercisesHomeView(
            exercisesViewModel: ExercisesViewModel(),
            addExerciseViewModel: AddExerciseViewModel())
    }
}

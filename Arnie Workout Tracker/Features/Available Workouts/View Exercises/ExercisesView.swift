//
//  ExercisesView.swift
//  Arnie Workout Tracker
//
//  Created by Sebastian Ghetu on 20/06/2020.
//  Copyright © 2020 Sebastian Ghetu. All rights reserved.
//

import SwiftUI

struct ExercisesView: View {

    @ObservedObject var viewModel: ExercisesViewModel

    var body: some View {
        List(viewModel.exercises, id: \.name) { exercise in
            PrimarySecondaryTertiaryTextCellView(data: exercise)
        }
        .onAppear(perform: viewModel.onAppear)
        .onDisappear(perform: viewModel.onDisappear)
    }
}

struct ExercisesView_Previews: PreviewProvider {
    static var previews: some View {
        ExercisesView(viewModel: ExercisesViewModel())
    }
}

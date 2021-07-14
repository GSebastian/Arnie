//
//  WorkoutFinishedView.swift
//  Arnie Workout Tracker
//
//  Created by Sebastian Ghetu on 10/06/2020.
//  Copyright © 2020 Sebastian Ghetu. All rights reserved.
//

import SwiftUI

struct WorkoutFinishedView: View {
    
    @ObservedObject var viewModel: WorkoutFinishedViewModel
    
    @Binding var isPresented: Bool
    
    var body: some View {
        GeometryReader { proxy in
            ScrollView(.vertical, showsIndicators: true) {
                HStack {
                    VStack(alignment: .leading) {
                        Spacer(minLength: proxy.size.height / 2 - 50)
                        Text("Congrats!")
                            .font(.largeTitle)
                            .foregroundColor(.label)
                        Text("Workout finished")
                            .font(.title)
                            .foregroundColor(.secondaryLabel)
                        Spacer(minLength: 20)
                        Button(action: {
                            self.isPresented = false
                        }) {
                            Text("Dismiss")
                                .font(.title)
                        }
                    }
                    Spacer()
                }
            }
        }
    }
}

struct WorkoutFinishedView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutFinishedView(viewModel: .init(), isPresented: .constant(true))
    }
}

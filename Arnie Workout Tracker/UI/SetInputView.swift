//
//  SetInputView.swift
//  Arnie Workout Tracker
//
//  Created by Sebastian Ghetu on 02/05/2020.
//  Copyright © 2020 Sebastian Ghetu. All rights reserved.
//

import SwiftUI

struct SetInputView: View {
    let textRecognitionService = TextRecognitionService()
    
    @State var inputEvents: [DrawingView.Commands] = []
    @State var recognisedText: String?
    @State var drawnImage: UIImage?
    
    var body: some View {
        
        VStack(alignment: .center, spacing: 16) {
            
            ZStack(alignment: .bottomTrailing) {
                DrawingView(inputEvents: $inputEvents, drawingImage: $drawnImage)
                    .background(Color(.secondarySystemBackground))
                DrawingControlsView(
                    onUndoPressed: ({
                        self.inputEvents.append(.undo)
                    }),
                    onRedoPressed: ({
                        self.inputEvents.append(.redo)
                    }))
            }
            
            if recognisedText != nil {
                Text(recognisedText!)
                    .font(.title)
                    .foregroundColor(Color(.label))
            }
            
            Button(action: {
                guard let image = self.drawnImage else { return }
                
                self.textRecognitionService
                    .textFromImage(image) { recognisedText in
                        self.recognisedText = recognisedText?.trimmingCharacters(in: .whitespacesAndNewlines)
                        print("Text: \(recognisedText)")
                }
            }) {
                HStack(alignment: .center) {
                    Spacer()
                    Text("Next")
                        .padding()
                        .foregroundColor(Color(.link))
                        .font(Font.headline.bold())
                    Spacer()
                }
                .background(Color(.systemGray6))
                .cornerRadius(6)
            }
        }
        .animation(.easeInOut(duration: 0.2))
        .padding()
    }
}

struct SetInputView_Previews: PreviewProvider {
    static var previews: some View {
        SetInputView(recognisedText: nil, drawnImage: UIImage(named: "number"))
    }
}

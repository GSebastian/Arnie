//
//  DrawingControlsView.swift
//  Arnie Workout Tracker
//
//  Created by Sebastian Ghetu on 07/05/2020.
//  Copyright © 2020 Sebastian Ghetu. All rights reserved.
//

import SwiftUI

struct DrawingControlsView: View {
    let onUndoPressed: () -> Void
    let onRedoPressed: () -> Void
    
    var body: some View {
        HStack(alignment: .center) {
            Button(action: {
                self.onUndoPressed()
            }) {
                Image(systemName: "arrow.uturn.left.circle.fill")
                    .font(.system(size: 40))
            }
            
            Button(action: {
                self.onRedoPressed()
            }) {
                Image(systemName: "arrow.uturn.right.circle.fill")
                    .font(.system(size: 40))
            }
        }
    }
}

struct DrawingControlsView_Previews: PreviewProvider {
    static var previews: some View {
        DrawingControlsView(onUndoPressed: {}, onRedoPressed: {})
    }
}

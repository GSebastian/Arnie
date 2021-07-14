//
//  DrawingView.swift
//  Arnie Workout Tracker
//
//  Created by Sebastian Ghetu on 20/04/2020.
//  Copyright © 2020 Sebastian Ghetu. All rights reserved.
//

import SwiftUI
import SwiftyDraw

struct DrawingView: UIViewRepresentable {
    
    enum Commands {
        case undo
        case redo
    }
    
    @Binding var inputEvents: [Commands]
    @Binding var drawingImage: UIImage?
    
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
    
    func makeUIView(context: Context) -> SwiftyDrawView {
        let view = SwiftyDrawView(frame: .zero)
        view.brush = .medium
        
        view.brush.color = Color(.label)
        view.backgroundColor = .systemBackground
        view.delegate = context.coordinator
    
        return view
    }
    
    func updateUIView(_ uiView: SwiftyDrawView, context: Context) {
        // HACK: Not sure of a better way to do this, but updating the events
        // synchronously doesn't actually remove them from the list
        defer {
            DispatchQueue.main.async {
                _ = self.inputEvents.popLast()
            }
        }
        guard let lastInputEvent = inputEvents.last else { return }
        switch lastInputEvent {
        case .redo:
            uiView.redo()
        case .undo:
            uiView.undo()
        }
        // HACK: Another instance where updating this synchronously doesn't work
        DispatchQueue.main.async {
            self.drawingImage = UIImage.image(with: uiView)
        }
    }
    
    class Coordinator: NSObject, SwiftyDrawViewDelegate {
        let parent: DrawingView
        
        init(parent: DrawingView) {
            self.parent = parent
        }

        func swiftyDraw(shouldBeginDrawingIn drawingView: SwiftyDrawView, using touch: UITouch) -> Bool {
            return true
        }
        
        func swiftyDraw(didBeginDrawingIn drawingView: SwiftyDrawView, using touch: UITouch) {
        }
        
        func swiftyDraw(isDrawingIn drawingView: SwiftyDrawView, using touch: UITouch) {
        }
        
        func swiftyDraw(didFinishDrawingIn drawingView: SwiftyDrawView, using touch: UITouch) {
            
            parent.drawingImage = UIImage.image(with: drawingView)
        }
        
        func swiftyDraw(didCancelDrawingIn drawingView: SwiftyDrawView, using touch: UITouch) {
        }
    }
}

struct DrawingView_Previews: PreviewProvider {
    static var previews: some View {
        DrawingView(inputEvents: .constant([]), drawingImage: .constant(nil))
    }
}

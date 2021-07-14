//
//  IntPickerView.swift
//  Arnie Workout Tracker
//
//  Created by Sebastian Ghetu on 09/05/2020.
//  Copyright © 2020 Sebastian Ghetu. All rights reserved.
//

import SwiftUI
import SwiftUIX

struct IntPickerView: View {
    
    @State var contentOffset: CGPoint
    @Binding var contentOffsetBinding: CGPoint

    var viewModel: IntPickerViewModel
    
    init(viewModel: IntPickerViewModel) {
        self.viewModel = viewModel
        self._contentOffset = State<CGPoint>(initialValue: viewModel.rememberedScrollOffset)
        self._contentOffsetBinding = _contentOffset.projectedValue.onSet({ (point) in
            viewModel.rememberedScrollOffset = point
        })
    }
    
    var body: some View {
        GeometryReader { proxy in
            CocoaScrollView(.vertical, showsIndicators: false) {
                Spacer()
                    .frame(height: proxy.size.height / 2)
                ForEach(0..<101) { value in
                    HStack {
                        Button(action: {
                            self.viewModel.currentValue = value
                        }, label: {
                            HStack {
                                Spacer()
                                Text("\(value)")
                                    .font(.title)
                                    .foregroundColor(Color(.label))
                                Spacer()
                            }
                            .padding()
                        })
                        .buttonStyle(BorderlessButtonStyle())
                    }
                }
                // HACK: Getting around a SwiftUIX issue where the contents don't show up
                .frame(width: proxy.size.width)
            }.contentOffset(self.$contentOffsetBinding)
        }
    }
}

struct IntPickerView_Previews: PreviewProvider {
    static var previews: some View {
        IntPickerView(viewModel: IntPickerViewModel(currentValue: nil))
    }
}

//
//  PrimarySecondaryTertiaryTextCellView.swift
//  Arnie Workout Tracker
//
//  Created by Sebastian Ghetu on 13/04/2020.
//  Copyright © 2020 Sebastian Ghetu. All rights reserved.
//

import SwiftUI

struct PrimarySecondaryTertiaryTextCellView: View {
    let data: PrimarySecondaryTertiaryTextCellDisplayable
    
    var body: some View {
        HStack(alignment: .center) {
            VStack(alignment: .leading) {
                if self.data.primaryText != nil {
                    Text(self.data.primaryText!)
                        .font(.headline)
                        .foregroundColor(.primary)
                }
                if self.data.secondaryText != nil {
                    Text(self.data.secondaryText!)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                if self.data.tertiaryText != nil {
                    Text(self.data.tertiaryText!)
                        .font(.subheadline)
                        .foregroundColor(.tertiaryLabel)
                }
            }
            Spacer()
        }
        .padding(.vertical, 16)
        .padding(.horizontal, 8)
        .background(Color(.secondarySystemBackground))
        .cornerRadius(8)
    }
}

struct PrimarySecondaryTertiaryTextCellView_Previews: PreviewProvider {
    
    static var previews: some View {
        Group {
            PrimarySecondaryTertiaryTextCellView(data: NewDataService().workouts[0])
                .previewLayout(.fixed(width: 320, height: 80))
                .environment(\.colorScheme, .light)
            PrimarySecondaryTertiaryTextCellView(data: NewDataService().workouts[0])
                .previewLayout(.fixed(width: 320, height: 80))
                .environment(\.colorScheme, .dark)
        }
    }
}

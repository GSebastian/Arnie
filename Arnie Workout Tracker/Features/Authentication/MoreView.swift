//
//  MoreView.swift
//  Arnie Workout Tracker
//
//  Created by Sebastian Ghetu on 04/06/2020.
//  Copyright © 2020 Sebastian Ghetu. All rights reserved.
//

import FirebaseUI
import SwiftUI

struct MoreView: View {
    var body: some View {
        NavigationView {
            List {
                Button(action: {
                    do {
                        try FUIAuth.defaultAuthUI()?.signOut()
                    } catch {
                        
                    }
                }) {
                    HStack(alignment: .center) {
                        Image(systemName: .arrowRight)
                        Text("more.home.signOut")
                    }
                }
            }
            .navigationBarTitle("more.home.navBar", displayMode: .large)
        }
    }
}

struct MoreView_Previews: PreviewProvider {
    static var previews: some View {
        MoreView()
    }
}

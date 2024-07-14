//
//  ContentView.swift
//  Todo Mobile
//
//  Created by Fahmi Dzulqarnain on 11/07/2024.
//

import Defaults
import SwiftUI

struct ContentView: View {
    init() {
         UINavigationBar.appearance().largeTitleTextAttributes = [
            .foregroundColor: UIColor(named: "Red") ?? UIColor.label
         ]
    }
    
    var body: some View {
        if Defaults[.token] == nil {
            SignInView()
        } else {
            TodoListView()
        }
    }
}

#Preview {
    ContentView()
}

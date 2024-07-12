//
//  ContentView.swift
//  Todo Mobile
//
//  Created by Fahmi Dzulqarnain on 11/07/2024.
//

import SwiftUI

struct ContentView: View {
    init() {
         UINavigationBar.appearance().largeTitleTextAttributes = [
            .foregroundColor: UIColor(named: "Red") ?? UIColor.label
         ]
    }
    
    var body: some View {
        TodoListView()
    }
}

#Preview {
    ContentView()
}

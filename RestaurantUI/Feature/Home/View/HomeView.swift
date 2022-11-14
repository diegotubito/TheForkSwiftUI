//
//  ContentView.swift
//  RestaurantUI
//
//  Created by David Gomez on 13/11/2022.
//

import SwiftUI

struct HomeView: View {
    var viewModel: RestaurantViewModel = RestaurantViewModel()
    
    var body: some View {
        Group {
            VStack {
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundColor(.accentColor)
                Text("Hello, world!")
            }
            .padding()
        } .task {
            await viewModel.loadRestaurants()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

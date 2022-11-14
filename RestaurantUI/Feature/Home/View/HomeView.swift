//
//  ContentView.swift
//  RestaurantUI
//
//  Created by David Gomez on 13/11/2022.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel: RestaurantViewModel = RestaurantViewModel()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.model.restaurants) { item in
                    RestaurantCell(item: item)
                        .listRowSeparator(.hidden)
                }
            }
            .listStyle(.plain)
            .navigationTitle("The Fork: Restaurants")
        }
        .task {
            await viewModel.loadRestaurants()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

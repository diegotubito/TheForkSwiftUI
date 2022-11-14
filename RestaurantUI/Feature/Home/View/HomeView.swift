//
//  ContentView.swift
//  RestaurantUI
//
//  Created by David Gomez on 13/11/2022.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel: RestaurantViewModel = RestaurantViewModel()
    @State private var isShowingSheet = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.model.restaurants) { item in
                    RestaurantCell(item: item)
                        .listRowSeparator(.hidden)
                }
            }
            .listStyle(.plain)
            .navigationTitle("RESTAURANT_TITLE".localized)
            .toolbar {
                Button {
                    isShowingSheet.toggle()
                } label: {
                    Image("sort")
                }
                .actionSheet(isPresented: $isShowingSheet, content: {
                    ActionSheet(
                        title: Text("SORT_OPTION_TITLE".localized),
                        message: Text("SORT_OPTION_SUBTITLE".localized),
                        buttons: [
                            .cancel(Text("DISMISS_OPTION".localized)),
                            .default(Text("SORT_OPTION_NAME".localized), action: {
                                self.viewModel.sortByName()
                            }),
                            .default(Text("SORT_OPTION_RATE".localized), action: {
                                self.viewModel.sortByRating()
                            })

                        ]
                    )
                })
            }
        }
        .task {
            await viewModel.loadRestaurants()
        }
    }
    
    func didDismiss() {
        // Handle the dismissing action.
        print("handle dismis")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

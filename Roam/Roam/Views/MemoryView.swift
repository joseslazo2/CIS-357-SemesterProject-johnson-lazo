//
//  MemoryView.swift
//  Roam
//
//  Created by Joshua Johnson on 3/10/25.
//

import SwiftUI

struct MemoryView: View {
    @Binding var goToAddView: Bool
    @Binding var goToMemoryView: Bool
    @Binding var goToHomeView: Bool
    @EnvironmentObject var viewModel: LocationViewModel
    
    var body: some View {
        VStack {
            Spacer()
            List {
                ForEach(viewModel.locations) { locationItem in
                    VStack(alignment: .leading) {
                        Button(action: {
                            // TODO - add action where when location item is pressed
                        }){
                            VStack {
                                Text(locationItem.name)
                                Text("Lat: \(locationItem.latitude), Long: \(locationItem.longitude)")
                                Text("Date: \(locationItem.date)")
                            }
                        }
                    }
                }
                .onDelete(perform: delete)
            }
            Spacer()
            
            // ---------- NAVIGATION BAR ----------
            HStack {
                Button(action: {
                    goToHomeView = true
                    goToAddView = false
                    goToMemoryView = false
                }) {
                    Image(systemName: "house")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .foregroundColor(Color.white)
                }
                
                Spacer()
                
                Button(action: {
                    goToAddView = true
                    goToMemoryView = false
                    goToHomeView = false
                }){
                    Image(systemName: "plus.circle")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .foregroundColor(Color.white)
                }
                Spacer()
                
                Button(action:{
                    goToMemoryView = true
                    goToHomeView = false
                    goToAddView = false
                }){
                    Image(systemName: "clock.fill")
                        .resizable()
                        .frame(width: 28, height: 28)
                        .foregroundColor(Color.white)
                }
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: 45)
            .background(Color.gray)
        }
        .onAppear {
            startListener(viewModel: viewModel)
        }
        .onDisappear {
            stopListener()
        }
    }
    func delete(at offsets: IndexSet) {
        let location = viewModel.locations[offsets.first ?? 0]
        Task {
            await deleteLocation(location: location)
        }
    }
}
